using OfflineRetailV2.Data;
using System;
using System.Data;
using System.Data.SqlClient;

namespace OfflineRetailV2.SumUp
{
    /// <summary>Local log of the amounts posted to SumUp, shown in General Settings > SumUp Transactions.</summary>
    public static class SumUpPaymentStore
    {
        public static int Insert(int invoiceNo, string reference, string checkoutId, decimal amount,
            string currency, string status, string errorMessage, string payUrl = "",
            string method = "CHECKOUT", string clientTransactionId = "")
        {
            try
            {
                using (SqlConnection con = new SqlConnection(SystemVariables.ConnectionString))
                using (SqlCommand cmd = new SqlCommand(
                    " insert into SumUpPayment(UserID, InvoiceNo, CheckoutReference, CheckoutId, Amount, Currency, Status, ErrorMessage, PayUrl, Method, ClientTransactionId) "
                    + " values (@UserID, @InvoiceNo, @Ref, @CheckoutId, @Amount, @Currency, @Status, @Err, @PayUrl, @Method, @ClientTxnId); select cast(SCOPE_IDENTITY() as int) ", con))
                {
                    cmd.Parameters.AddWithValue("@UserID", SystemVariables.CurrentUserID);
                    cmd.Parameters.AddWithValue("@InvoiceNo", invoiceNo);
                    cmd.Parameters.AddWithValue("@Ref", reference ?? "");
                    cmd.Parameters.AddWithValue("@CheckoutId", checkoutId ?? "");
                    cmd.Parameters.AddWithValue("@Amount", amount);
                    cmd.Parameters.AddWithValue("@Currency", currency ?? "");
                    cmd.Parameters.AddWithValue("@Status", status ?? "");
                    cmd.Parameters.AddWithValue("@Err", Trim(errorMessage, 400));
                    cmd.Parameters.AddWithValue("@PayUrl", Trim(payUrl, 400));
                    cmd.Parameters.AddWithValue("@Method", method ?? "CHECKOUT");
                    cmd.Parameters.AddWithValue("@ClientTxnId", clientTransactionId ?? "");
                    con.Open();
                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
            catch (Exception) { return 0; }
        }

        public static DataTable Fetch()
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection con = new SqlConnection(SystemVariables.ConnectionString))
                using (SqlDataAdapter da = new SqlDataAdapter(
                    " select ID, InvoiceNo, CheckoutReference, CheckoutId, Amount, Currency, Status, TransactionCode, ErrorMessage, PayUrl, Method, ClientTransactionId, CreatedOn "
                    + " from SumUpPayment where UserID=@UserID order by ID desc ", con))
                {
                    da.SelectCommand.Parameters.AddWithValue("@UserID", SystemVariables.CurrentUserID);
                    da.Fill(dt);
                }
            }
            catch (Exception) { }
            return dt;
        }

        public static void UpdateStatus(int id, string status, string transactionCode)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(SystemVariables.ConnectionString))
                using (SqlCommand cmd = new SqlCommand(" update SumUpPayment set Status=@Status, TransactionCode=@Code where ID=@ID ", con))
                {
                    cmd.Parameters.AddWithValue("@Status", status ?? "");
                    cmd.Parameters.AddWithValue("@Code", transactionCode ?? "");
                    cmd.Parameters.AddWithValue("@ID", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception) { }
        }

        // Links a payment taken before the sale was saved (InvoiceNo 0) to the invoice created afterwards.
        public static bool SetInvoiceNo(int id, int invoiceNo)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(SystemVariables.ConnectionString))
                using (SqlCommand cmd = new SqlCommand(" update SumUpPayment set InvoiceNo=@InvoiceNo where ID=@ID ", con))
                {
                    cmd.Parameters.AddWithValue("@InvoiceNo", invoiceNo);
                    cmd.Parameters.AddWithValue("@ID", id);
                    con.Open();
                    return cmd.ExecuteNonQuery() > 0;
                }
            }
            catch (Exception) { return false; }
        }

        // True when a saved sale (CardTrans with a transaction number) carries this SumUp reference, even if
        // SumUpPayment.InvoiceNo was never set. Returns true on error, so callers never refund a sale by mistake.
        public static bool IsReferenceOnSavedSale(string reference)
        {
            if (string.IsNullOrEmpty(reference)) return false;
            try
            {
                using (SqlConnection con = new SqlConnection(SystemVariables.ConnectionString))
                using (SqlCommand cmd = new SqlCommand(" select count(*) from CardTrans where Reference=@Ref and isnull(TransactionNo,0) > 0 ", con))
                {
                    cmd.Parameters.AddWithValue("@Ref", reference);
                    con.Open();
                    return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
                }
            }
            catch (Exception) { return true; }
        }

        private static string Trim(string s, int max)
        {
            if (string.IsNullOrEmpty(s)) return "";
            return s.Length > max ? s.Substring(0, max) : s;
        }
    }
}
