using OfflineRetailV2.Data;
using System;
using System.Data;
using System.Threading.Tasks;

namespace OfflineRetailV2.SumUp
{
    /// <summary>Outcome of a SumUp refund. Success is true only when SumUp accepted the refund.</summary>
    public class SumUpRefundResult
    {
        public bool Success { get; set; }
        public decimal Amount { get; set; }
        public string TransactionId { get; set; } = "";   // the original sale's SumUp transaction id
        public string Error { get; set; } = "";
        public int PaymentRowId { get; set; }              // SumUpPayment.ID of the refund log row
    }

    /// <summary>SumUp refunds, shared by the tender return and the return/reprint screen.</summary>
    public static class SumUpRefund
    {
        public const string MethodRefund = "REFUND";

        // Refunds amount (positive, major units) of the original SumUp payment and logs it in SumUpPayment
        // (Method REFUND, ClientTransactionId = original transaction id). Does not show any message.
        public static async Task<SumUpRefundResult> RefundAsync(string originalTransactionId, decimal amount,
            int invoiceNo, string reference)
        {
            SumUpRefundResult result = new SumUpRefundResult
            {
                Amount = decimal.Round(Math.Abs(amount), 2),
                TransactionId = originalTransactionId ?? ""
            };

            Settings.LoadSumUpSettings();
            if (Settings.SumUpApiKey == "" || Settings.SumUpMerchantCode == "")
            {
                result.Error = "SumUp is not configured. Please enter the API key and merchant code in General Settings > SumUp.";
                return result;
            }
            if (result.TransactionId == "")
            {
                result.Error = "The SumUp transaction of the original sale was not found, so the card cannot be refunded.";
                return result;
            }
            if (result.Amount <= 0)
            {
                result.Error = "Invalid refund amount.";
                return result;
            }

            try
            {
                SumUpClient client = new SumUpClient(Settings.SumUpApiKey, Settings.SumUpMerchantCode);
                await client.RefundTransactionAsync(result.TransactionId, result.Amount).ConfigureAwait(false);
                result.Success = true;
            }
            catch (SumUpApiException ex)
            {
                result.Error = ex.Message;
            }
            catch (Exception ex)
            {
                // Network error: SumUp may or may not have done the refund.
                result.Error = "Could not reach SumUp: " + ex.Message
                    + "\r\nCheck the SumUp dashboard before refunding again.";
            }

            result.PaymentRowId = SumUpPaymentStore.Insert(invoiceNo, reference ?? "", "", result.Amount, Settings.SumUpCurrency,
                result.Success ? "REFUNDED" : "REFUND FAILED", result.Error, "", MethodRefund, result.TransactionId);
            return result;
        }

        // Finds the SumUp transaction id of an invoice's card sale in CardTrans (saved there by CardVarify).
        public static string FindSaleTransactionId(DataTable cardTrans)
        {
            if (cardTrans == null) return "";
            for (int i = cardTrans.Rows.Count - 1; i >= 0; i--)
            {
                DataRow dr = cardTrans.Rows[i];
                if (GeneralFunctions.fnInt32(dr["PaymentGateway"].ToString()) != 11) continue;
                if (!string.Equals(dr["TransactionType"].ToString(), "Sale", StringComparison.OrdinalIgnoreCase)) continue;
                string id = dr["RefCardTranID"].ToString().Trim();
                if (id != "") return id;
            }
            return "";
        }
    }
}
