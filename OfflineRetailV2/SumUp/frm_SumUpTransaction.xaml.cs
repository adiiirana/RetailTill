using OfflineRetailV2.Data;
using System;
using System.Threading.Tasks;
using System.Windows;

namespace OfflineRetailV2.SumUp
{
    /// <summary>
    /// SumUp "Card payment" window, same look and flow as the EVO window (frm_EvoTransaction):
    /// "Starting transaction, Please wait ..." -> card step -> result, with Cancel while waiting and OK at the end.
    /// Two methods, chosen by the switches in General Settings > SumUp:
    ///  - Solo card reader: SumUp cloud reader checkout over HTTPS (SumUpClient);
    ///  - Card details: SumUp checkout + card details popup over HTTPS (SumUpClient, sandbox only).
    /// Result is filled when the window closes; Result.Success is true only when SumUp confirmed the payment.
    /// </summary>
    public partial class frm_SumUpTransaction : Window
    {
        private const int ReaderTimeoutSeconds = 180;
        private const int TerminateGraceSeconds = 15;
        private const int PollMilliseconds = 2000;

        private readonly decimal _amount;
        private readonly string _currency;
        private readonly string _reference;
        private readonly string _method;
        private bool _running = true;
        private bool _cancelRequested;

        public SumUpReaderResult Result { get; private set; }

        public frm_SumUpTransaction()
        {
            InitializeComponent();
        }

        // method: SumUpReaderPayDialog.MethodReader or SumUpReaderPayDialog.MethodCardForm.
        public frm_SumUpTransaction(decimal amount, string currency, string reference, string method)
        {
            InitializeComponent();
            _amount = amount;
            _currency = currency ?? "";
            _reference = reference ?? "";
            _method = method ?? SumUpReaderPayDialog.MethodReader;
            Result = new SumUpReaderResult { Status = "FAILED", Amount = amount, Reference = _reference };

            ContentTextBlock.Text = "Starting transaction, Please wait ...";
            ModalWindowWC.CloseCommand = new CommandBase(o => OnCloseRequested());
        }

        private async void Window_Loaded(object sender, RoutedEventArgs e)
        {
            try
            {
                Settings.LoadSumUpSettings();
                if (_method == SumUpReaderPayDialog.MethodCardForm)
                    await RunCardDetailsAsync();
                else
                    await RunReaderAsync();
            }
            catch (Exception ex)
            {
                Result.Status = "FAILED";
                Result.Success = false;
                Result.Error = ex.Message;
            }
            Finish();
        }

        // ---------------- Solo card reader ----------------

        private async Task RunReaderAsync()
        {
            if (Settings.SumUpApiKey == "" || Settings.SumUpMerchantCode == "" || Settings.SumUpReaderId == ""
                || Settings.SumUpAffiliateKey == "" || Settings.SumUpAppId == "")
            {
                Result.Error = "Card reader payment needs the API key, merchant code, affiliate key, app ID and a paired reader in General Settings > SumUp.";
                return;
            }

            SumUpClient client = new SumUpClient(Settings.SumUpApiKey, Settings.SumUpMerchantCode);
            string readerId = Settings.SumUpReaderId;
            string clientTxnId = "";
            string finalStatus = "FAILED";
            string error = "";
            SumUpTransaction last = null;

            try
            {
                clientTxnId = await client.StartReaderCheckoutAsync(readerId, _amount, _currency, "Sale " + _reference,
                    Settings.SumUpAppId, Settings.SumUpAffiliateKey, _reference);

                ContentTextBlock.Text = "Present the card on the SumUp reader." + "\n" + _amount.ToString("f2") + " " + _currency;
                CloseButton.Content = "Cancel";
                CloseButton.Visibility = Visibility.Visible;

                DateTime started = DateTime.Now;
                DateTime terminateSentAt = DateTime.MinValue;
                bool done = false;
                while (!done)
                {
                    bool timedOut = (DateTime.Now - started).TotalSeconds >= ReaderTimeoutSeconds;
                    if ((_cancelRequested || timedOut) && terminateSentAt == DateTime.MinValue)
                    {
                        // Stop the reader so it cannot take the card after the till has given up.
                        terminateSentAt = DateTime.Now;
                        ContentTextBlock.Text = _cancelRequested ? "Cancelling, Please wait ..." : "No answer from the reader. Stopping it ...";
                        CloseButton.IsEnabled = false;
                        try { await client.TerminateReaderCheckoutAsync(readerId); } catch { }
                    }

                    SumUpTransaction t = null;
                    try { t = await client.GetTransactionAsync(clientTxnId); }
                    catch (Exception pollEx) { error = pollEx.Message; }   // network blip: keep polling

                    if (t != null)
                    {
                        last = t;
                        if (t.Status == "SUCCESSFUL")
                        {
                            // Paid, even if Cancel was pressed: the card was charged, so the sale must go through.
                            finalStatus = "PAID";
                            error = "";
                            done = true;
                        }
                        else if (t.Status == "FAILED" || t.Status == "CANCELLED")
                        {
                            finalStatus = t.Status;
                            error = _cancelRequested ? "Cancelled at the till." : "Payment declined or not completed.";
                            done = true;
                        }
                    }

                    if (!done && terminateSentAt != DateTime.MinValue
                        && (DateTime.Now - terminateSentAt).TotalSeconds >= TerminateGraceSeconds)
                    {
                        if (last == null && _cancelRequested)
                        {
                            finalStatus = "CANCELLED";
                            error = "Cancelled at the till.";
                        }
                        else
                        {
                            finalStatus = "PENDING";
                            error = "No final answer from SumUp. Check the SumUp dashboard before taking the payment again.";
                        }
                        done = true;
                    }

                    if (!done) await Task.Delay(PollMilliseconds);
                }
            }
            catch (Exception ex)
            {
                // StartReaderCheckout failed: nothing was sent to the reader.
                finalStatus = "FAILED";
                error = ex.Message;
            }

            Result.Status = finalStatus;
            Result.Success = finalStatus == "PAID";
            Result.Error = error;
            Result.ClientTransactionId = clientTxnId;
            if (last != null)
            {
                Result.TransactionId = last.Id ?? "";
                Result.TransactionCode = last.TransactionCode ?? "";
                if (last.Amount.HasValue && last.Amount.Value > 0) Result.Amount = last.Amount.Value;
            }

            Result.PaymentRowId = SumUpPaymentStore.Insert(0, _reference, "", Result.Amount, _currency, finalStatus, error, "",
                SumUpReaderPayDialog.MethodReader, clientTxnId);
            if (Result.PaymentRowId > 0 && Result.TransactionCode != "")
                SumUpPaymentStore.UpdateStatus(Result.PaymentRowId, finalStatus, Result.TransactionCode);
        }

        // ---------------- Card details (sandbox) ----------------

        private async Task RunCardDetailsAsync()
        {
            string method = SumUpReaderPayDialog.MethodCardForm;
            if (Settings.SumUpApiKey == "" || Settings.SumUpMerchantCode == "")
            {
                Result.Error = "Please enter the SumUp API key and merchant code in General Settings > SumUp.";
                return;
            }
            SumUpClient client = new SumUpClient(Settings.SumUpApiKey, Settings.SumUpMerchantCode);

            SumUpCheckout co;
            try
            {
                co = await client.CreateCheckoutAsync(_reference, _amount, _currency, "Sale " + _reference);
            }
            catch (Exception ex)
            {
                Result.Error = "SumUp checkout error: " + ex.Message;
                Result.PaymentRowId = SumUpPaymentStore.Insert(0, _reference, "", _amount, _currency, "FAILED", Result.Error, "", method, "");
                return;
            }

            Result.PaymentRowId = SumUpPaymentStore.Insert(0, _reference, co.Id ?? "", _amount, _currency,
                "PENDING", "", co.HostedCheckoutUrl ?? "", method, "");
            ContentTextBlock.Text = "Enter the card details." + "\n" + _amount.ToString("f2") + " " + _currency;

            // The card details popup checks the account (sandbox only) and pays the checkout.
            SumUpCheckout paid = SumUpPayDialog.Show(this, Result.PaymentRowId, co.Id ?? "", _reference, _amount, _currency,
                co.HostedCheckoutUrl ?? "", null);

            if (paid != null && paid.Status == "PAID")
            {
                Result.Success = true;
                Result.Status = "PAID";
                Result.Error = "";
                Result.TransactionId = paid.TransactionId ?? "";
                Result.TransactionCode = paid.TransactionCode ?? "";
                return;
            }

            // Not paid: close the checkout on SumUp so it cannot be paid later without a sale.
            Result.Status = "CANCELLED";
            Result.Error = "The card details payment was not completed.";
            ContentTextBlock.Text = "Cancelling, Please wait ...";
            try { await client.DeactivateCheckoutAsync(co.Id ?? ""); } catch { }
            if (Result.PaymentRowId > 0) SumUpPaymentStore.UpdateStatus(Result.PaymentRowId, "CANCELLED", "");
        }

        // ---------------- Window behaviour ----------------

        private void Finish()
        {
            _running = false;
            ContentTextBlock.Text = Result.Success
                ? "Payment approved." + "\n" + "Transaction code: " + Result.TransactionCode
                : (Result.Status == "PENDING" ? "Payment not confirmed." : "Payment not completed.") + "\n" + Result.Error;
            CloseButton.Content = "OK";
            CloseButton.IsEnabled = true;
            CloseButton.Visibility = Visibility.Visible;
        }

        private void CloseButton_Click(object sender, RoutedEventArgs e)
        {
            OnCloseRequested();
        }

        // Cancel while waiting asks the reader to stop; the window closes only once the result is known.
        private void OnCloseRequested()
        {
            if (_running)
            {
                if (_method != SumUpReaderPayDialog.MethodCardForm && !_cancelRequested)
                {
                    _cancelRequested = true;
                    CloseButton.IsEnabled = false;
                    ContentTextBlock.Text = "Cancelling, Please wait ...";
                }
                return;
            }
            Close();
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (_running) e.Cancel = true;   // never close while the card may still be charged
        }
    }
}
