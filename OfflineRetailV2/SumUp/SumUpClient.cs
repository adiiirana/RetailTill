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
