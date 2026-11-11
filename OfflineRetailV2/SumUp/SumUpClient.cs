using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace OfflineRetailV2.SumUp
{
    public class SumUpReader
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Status { get; set; }
    }

    public class SumUpTransaction
    {
        public string Id { get; set; }
        public string TransactionCode { get; set; }
        public string Status { get; set; }
        public decimal? Amount { get; set; }            // amount SumUp actually charged, major units (15.00)
        public string Raw { get; set; }
    }

    public class SumUpCheckout
    {
        public string Id { get; set; }
        public string Status { get; set; }              // PENDING | PAID | FAILED | EXPIRED
        public string HostedCheckoutUrl { get; set; }
        public string TransactionId { get; set; }
        public string TransactionCode { get; set; }
        public bool MerchantSandbox { get; set; }
        public bool RequiresNextStep { get; set; }      // 3D Secure or other customer action
    }

    public class SumUpApiException : Exception
    {
        public int StatusCode { get; private set; }

        public SumUpApiException(int statusCode, string body)
            : base(SumUpClient.ExtractMessage(statusCode, body))
        {
            StatusCode = statusCode;
        }
    }

    /// <summary>
    /// Thin HTTP wrapper over the SumUp Cloud API (https://api.sumup.com).
    /// Used by General Settings to verify credentials and pair / list / remove Solo readers.
    /// </summary>
    public class SumUpClient
    {
        private static readonly HttpClient http = CreateHttp();

        private readonly string apiKey;
        private readonly string merchantCode;

        public SumUpClient(string apiKey, string merchantCode)
        {
            this.apiKey = apiKey;
            this.merchantCode = merchantCode;
        }

        private static HttpClient CreateHttp()
        {
            System.Net.ServicePointManager.SecurityProtocol |= System.Net.SecurityProtocolType.Tls12;
            HttpClient c = new HttpClient();
            c.BaseAddress = new Uri("https://api.sumup.com/");
            c.Timeout = TimeSpan.FromSeconds(30);
            return c;
        }

        private string ReadersPath { get { return "v0.1/merchants/" + Uri.EscapeDataString(merchantCode) + "/readers"; } }

        private async Task<string> SendAsync(HttpMethod method, string path, object body)
        {
            using (HttpRequestMessage req = new HttpRequestMessage(method, path))
            {
                req.Headers.Authorization = new AuthenticationHeaderValue("Bearer", apiKey);
                if (body != null)
                    req.Content = new StringContent(Newtonsoft.Json.JsonConvert.SerializeObject(body), Encoding.UTF8, "application/json");

                using (HttpResponseMessage res = await http.SendAsync(req).ConfigureAwait(false))
                {
                    string text = await res.Content.ReadAsStringAsync().ConfigureAwait(false);
                    if (!res.IsSuccessStatusCode)
                        throw new SumUpApiException((int)res.StatusCode, text);
                    return text;
                }
            }
        }

        private static SumUpReader ParseReader(JToken t)
        {
            return new SumUpReader
            {
                Id = (string)t["id"],
                Name = (string)t["name"],
                Status = (string)t["status"]
            };
        }

        /// <summary>Lists readers; succeeds only when the API key and merchant code are valid.</summary>
        public async Task<List<SumUpReader>> ListReadersAsync()
        {
            JObject o = JObject.Parse(await SendAsync(HttpMethod.Get, ReadersPath, null).ConfigureAwait(false));
            List<SumUpReader> list = new List<SumUpReader>();
            JToken items = o["items"] ?? o["data"];
            if (items != null)
                foreach (JToken t in items) list.Add(ParseReader(t));
            return list;
        }

        public async Task<SumUpReader> PairReaderAsync(string pairingCode, string name)
        {
            string text = await SendAsync(HttpMethod.Post, ReadersPath,
                new { pairing_code = pairingCode, name = name }).ConfigureAwait(false);
            JObject o = JObject.Parse(text);
            return ParseReader(o["data"] ?? o);
        }

        public Task DeleteReaderAsync(string readerId)
        {
            return SendAsync(HttpMethod.Delete, ReadersPath + "/" + Uri.EscapeDataString(readerId), null);
        }

        /// <summary>Sends an amount to a paired Solo reader. Returns the client_transaction_id.</summary>
        public async Task<string> StartReaderCheckoutAsync(string readerId, decimal amount, string currency,
            string description, string appId, string affiliateKey, string foreignTransactionId)
        {
            var body = new
            {
                total_amount = new
                {
                    currency = currency,
                    minor_unit = 2,
                    value = (long)decimal.Round(amount * 100m, 0, MidpointRounding.AwayFromZero)
                },
                description = description,
                affiliate = new { app_id = appId, key = affiliateKey, foreign_transaction_id = foreignTransactionId }
            };
            string text = await SendAsync(HttpMethod.Post, ReadersPath + "/" + Uri.EscapeDataString(readerId) + "/checkout", body).ConfigureAwait(false);
            JObject o = JObject.Parse(text);
            return (string)o["data"]["client_transaction_id"];
        }

        public Task TerminateReaderCheckoutAsync(string readerId)
        {
            return SendAsync(HttpMethod.Post, ReadersPath + "/" + Uri.EscapeDataString(readerId) + "/terminate", new { });
        }

        /// <summary>
        /// Looks the transaction up by client_transaction_id. Returns null while SumUp has not created it yet.
        /// Status is SUCCESSFUL, FAILED, CANCELLED or PENDING.
        /// </summary>
        public async Task<SumUpTransaction> GetTransactionAsync(string clientTransactionId)
        {
            string text;
            try
            {
                text = await SendAsync(HttpMethod.Get, "v2.1/merchants/" + Uri.EscapeDataString(merchantCode)
                    + "/transactions?client_transaction_id=" + Uri.EscapeDataString(clientTransactionId), null).ConfigureAwait(false);
            }
            catch (SumUpApiException ex)
            {
                if (ex.StatusCode == 404) return null;
                throw;
            }
            JToken t = JToken.Parse(text);
            if (t is JObject && t["items"] is JArray) t = ((JArray)t["items"]).Count > 0 ? t["items"][0] : null;
            if (t == null || t.Type != JTokenType.Object) return null;
            return new SumUpTransaction
            {
                Id = (string)t["id"],
                TransactionCode = (string)t["transaction_code"],
                Status = ((string)t["status"] ?? "").ToUpperInvariant(),
                Amount = ParseAmount(t["amount"]),
                Raw = text
            };
        }

        private static decimal? ParseAmount(JToken a)
        {
            if (a == null || a.Type == JTokenType.Null) return null;
            try { return a.Value<decimal>(); } catch { return null; }
        }

        private static SumUpCheckout ParseCheckout(string text)
        {
            JObject o = JObject.Parse(text);
            string txnId = (string)o["transaction_id"];
            string txnCode = (string)o["transaction_code"];
            JToken txs = o["transactions"];
            if (string.IsNullOrEmpty(txnId) && txs is JArray && ((JArray)txs).Count > 0)
            {
                txnId = (string)txs[0]["id"];
                txnCode = (string)txs[0]["transaction_code"];
            }
            return new SumUpCheckout
            {
                Id = (string)o["id"],
                Status = ((string)o["status"] ?? "").ToUpperInvariant(),
                HostedCheckoutUrl = (string)o["hosted_checkout_url"],
                TransactionId = txnId,
                TransactionCode = txnCode,
                MerchantSandbox = (bool?)o["merchant_sandbox"] == true,
                RequiresNextStep = o["next_step"] != null
            };
        }

        /// <summary>Creates an online checkout with a SumUp-hosted payment page. amount is in major units (15.00).</summary>
        public async Task<SumUpCheckout> CreateHostedCheckoutAsync(string checkoutReference, decimal amount, string currency, string description)
        {
            string text = await SendAsync(HttpMethod.Post, "v0.1/checkouts", new
            {
                checkout_reference = checkoutReference,
                amount = decimal.Round(amount, 2),
                currency = currency,
                merchant_code = merchantCode,
                description = description,
                hosted_checkout = new { enabled = true }
            }).ConfigureAwait(false);
            return ParseCheckout(text);
        }

        /// <summary>POST /v0.1/checkouts with the sale data. amount is in major units (15.00).</summary>
        public async Task<SumUpCheckout> CreateCheckoutAsync(string checkoutReference, decimal amount, string currency, string description)
        {
            string text = await SendAsync(HttpMethod.Post, "v0.1/checkouts", new
            {
                checkout_reference = checkoutReference,
                amount = decimal.Round(amount, 2),
                currency = currency,
                merchant_code = merchantCode,
                description = description,
                purpose = "CHECKOUT",
                hosted_checkout = new { enabled = true }
            }).ConfigureAwait(false);
            return ParseCheckout(text);
        }

        public async Task<SumUpCheckout> GetCheckoutAsync(string checkoutId)
        {
            string text = await SendAsync(HttpMethod.Get, "v0.1/checkouts/" + Uri.EscapeDataString(checkoutId), null).ConfigureAwait(false);
            return ParseCheckout(text);
        }

        /// <summary>
        /// Pays a checkout with raw card details (PUT /v0.1/checkouts/{id}). Only for SANDBOX testing with SumUp's published
        /// test cards: raw card numbers must never be sent from a live till (PCI DSS).
        /// </summary>
        public async Task<SumUpCheckout> PayCheckoutWithCardAsync(string checkoutId, string cardholderName, string cardNumber,
            string expiryMonth, string expiryYear, string cvv)
        {
            // Hard stop for live accounts, whoever calls this: card details are sent only to a sandbox checkout.
            SumUpCheckout target = await GetCheckoutAsync(checkoutId).ConfigureAwait(false);
            if (!target.MerchantSandbox)
                throw new InvalidOperationException("Card details can only be sent to a SumUp sandbox checkout. Live payments must use the card reader.");

            string text = await SendAsync(HttpMethod.Put, "v0.1/checkouts/" + Uri.EscapeDataString(checkoutId), new
            {
                payment_type = "card",
                card = new
                {
                    name = cardholderName,
                    number = cardNumber,
                    expiry_month = expiryMonth,
                    expiry_year = expiryYear,
                    cvv = cvv
                }
            }).ConfigureAwait(false);
            return ParseCheckout(text);
        }

        /// <summary>
        /// Refunds a card payment (POST /v1.0/merchants/{merchant_code}/payments/{transaction_id}/refunds, 201 on success).
        /// amount is in major units (5.00); null refunds the full payment. SumUp rejects more than the refundable amount.
        /// </summary>
        public Task RefundTransactionAsync(string transactionId, decimal? amount)
        {
            object body = amount.HasValue ? (object)new { amount = decimal.Round(amount.Value, 2) } : new { };
            return SendAsync(HttpMethod.Post, "v1.0/merchants/" + Uri.EscapeDataString(merchantCode)
                + "/payments/" + Uri.EscapeDataString(transactionId) + "/refunds", body);
        }

        public Task DeactivateCheckoutAsync(string checkoutId)
        {
            return SendAsync(HttpMethod.Delete, "v0.1/checkouts/" + Uri.EscapeDataString(checkoutId), null);
        }

        internal static string ExtractMessage(int statusCode, string body)
        {
            string raw = string.IsNullOrWhiteSpace(body) ? "" : body.Trim();
            if (raw.Length > 400) raw = raw.Substring(0, 400);
            try
            {
                JObject o = JObject.Parse(body);
                string m = (string)(o["message"] ?? o["detail"] ?? o["error_message"] ?? o["title"]);
                if (!string.IsNullOrEmpty(m)) return "SumUp error " + statusCode + ": " + m + "\r\n" + raw;
            }
            catch { }
            return "SumUp error " + statusCode + (raw == "" ? "." : ": " + raw);
        }
    }
}
