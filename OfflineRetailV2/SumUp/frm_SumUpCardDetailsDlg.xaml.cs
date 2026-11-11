using OfflineRetailV2.Data;
using System;
using System.Windows;
using System.Windows.Input;

namespace OfflineRetailV2.SumUp
{
    /// <summary>
    /// SumUp card details popup in the XEPOS POS dialog style (like frm_POSPaidOutDlg).
    /// Pays a SumUp checkout with card details (PUT /v0.1/checkouts/{id}); only a SumUp sandbox account is accepted.
    /// PaidCheckout is set when the payment went through; the window then closes by itself.
    /// </summary>
    public partial class frm_SumUpCardDetailsDlg : Window
    {
        private readonly int _paymentRowId;
        private readonly string _checkoutId;
        private readonly decimal _amount;
        private readonly string _currency;
        private readonly Action _onChanged;
        private bool _paying;

        NumKeyboard nkybrd;
        FullKeyboard fkybrd;
        bool IsAboutNumKybrdOpen = false;
        bool IsAboutFullKybrdOpen = false;

        public SumUpCheckout PaidCheckout { get; private set; }

        public frm_SumUpCardDetailsDlg()
        {
            InitializeComponent();
        }

        public frm_SumUpCardDetailsDlg(int paymentRowId, string checkoutId, string reference, decimal amount, string currency, Action onChanged)
        {
            InitializeComponent();
            _paymentRowId = paymentRowId;
            _checkoutId = checkoutId ?? "";
            _amount = amount;
            _currency = currency ?? "";
            _onChanged = onChanged;

            lbAmount.Text = SystemVariables.CurrencySymbol + " " + amount.ToString("f2") + (_currency == "" ? "" : "  " + _currency);
            btnPay.Content = "PAY";
            if (!string.IsNullOrEmpty(reference)) TitleText.Text = "Card Details  (" + reference + ")";

            ModalWindow.CloseCommand = new CommandBase(o => CloseIfIdle());
            Loaded += (s, e) =>
            {
                nkybrd = new NumKeyboard();
                fkybrd = new FullKeyboard();
                txtName.Focus();
            };
            Closing += (s, e) =>
            {
                if (_paying) { e.Cancel = true; return; }   // never close while SumUp is processing the card
                CloseKeyboards();
                ResMan.closeKeyboard();
            };
        }

        // Fills a SumUp sandbox test card (Visa, frictionless: no 3D Secure).
        private void BtnTestCard_Click(object sender, RoutedEventArgs e)
        {
            txtName.Text = "Test Customer";
            txtNumber.Text = "4200 0000 0000 0091";
            txtMonth.Text = "12";
            txtYear.Text = "30";
            txtCvv.Text = "123";
            lbStatus.Text = "";
        }

        private void BtnCancel_Click(object sender, RoutedEventArgs e)
        {
            CloseIfIdle();
        }

        private void CloseIfIdle()
        {
            if (_paying) return;
            Close();
        }

        private async void BtnPay_Click(object sender, RoutedEventArgs e)
        {
            CloseKeyboards();
            string name = (txtName.Text ?? "").Trim();
            string number = (txtNumber.Text ?? "").Replace(" ", "").Replace("-", "").Trim();
            string month = (txtMonth.Text ?? "").Trim().PadLeft(2, '0');
            string year = (txtYear.Text ?? "").Trim();
            string cvv = (txtCvv.Text ?? "").Trim();

            if (name == "") { ShowError("Enter the cardholder name.", txtName); return; }
            if (number.Length < 12 || !IsDigits(number)) { ShowError("Enter a valid card number.", txtNumber); return; }
            int mm;
            if (!int.TryParse(month, out mm) || mm < 1 || mm > 12) { ShowError("Enter the expiry month as MM (01-12).", txtMonth); return; }
            if (year.Length != 2 || !IsDigits(year)) { ShowError("Enter the expiry year as YY.", txtYear); return; }
            if (cvv.Length < 3 || !IsDigits(cvv)) { ShowError("Enter the 3 or 4 digit CVV.", txtCvv); return; }

            SetBusy(true, "Paying, Please wait ...");
            try
            {
                SumUpClient client = new SumUpClient(Settings.SumUpApiKey, Settings.SumUpMerchantCode);
                SumUpCheckout current = await client.GetCheckoutAsync(_checkoutId);
                if (!current.MerchantSandbox)
                {
                    ShowError("Refused: this is a live SumUp account. Card details can only be used in the SumUp sandbox.", null);
                    return;
                }
                if (current.Status == "PAID")
                {
                    Paid(current);
                    return;
                }

                SumUpCheckout paid = await client.PayCheckoutWithCardAsync(_checkoutId, name, number, month, year, cvv);
                SumUpPaymentStore.UpdateStatus(_paymentRowId, paid.Status, paid.TransactionCode);
                _onChanged?.Invoke();

                if (paid.Status == "PAID")
                    Paid(paid);
                else if (paid.RequiresNextStep)
                    ShowError("SumUp asks for 3D Secure on this card. Use TEST CARD (no 3D Secure).", null);
                else
                    ShowError("Payment not completed. SumUp status: " + paid.Status, null);
            }
            catch (Exception ex)
            {
                ShowError(ex.Message, null);
            }
            finally
            {
                SetBusy(false, null);
            }
        }

        private void Paid(SumUpCheckout checkout)
        {
            SumUpPaymentStore.UpdateStatus(_paymentRowId, "PAID", checkout.TransactionCode);
            _onChanged?.Invoke();
            PaidCheckout = checkout;
            _paying = false;
            Close();
        }

        private void SetBusy(bool busy, string text)
        {
            _paying = busy;
            btnPay.IsEnabled = !busy;
            btnCancel.IsEnabled = !busy;
            btnTestCard.IsEnabled = !busy;
            txtName.IsEnabled = txtNumber.IsEnabled = txtMonth.IsEnabled = txtYear.IsEnabled = txtCvv.IsEnabled = !busy;
            if (busy) lbStatus.Text = text ?? "";
        }

        private void ShowError(string message, UIElement focus)
        {
            lbStatus.Text = message;
            if (focus != null) focus.Focus();
        }

        private static bool IsDigits(string s)
        {
            foreach (char c in s) if (c < '0' || c > '9') return false;
            return s.Length > 0;
        }

        // ---------------- XEPOS touch keyboards (same behaviour as the POS dialogs) ----------------

        private void Edit_LostFocus(object sender, RoutedEventArgs e)
        {
            CloseKeyboards();
        }

        private void Text_GotFocus(object sender, RoutedEventArgs e)
        {
            if (Settings.UseTouchKeyboardInPOS == "N") return;
            CloseKeyboards();
            if (IsAboutFullKybrdOpen) return;

            fkybrd = new FullKeyboard();
            var location = ((FrameworkElement)sender).PointToScreen(new Point(0, 0));
            fkybrd.Left = GeneralFunctions.fnInt32((SystemParameters.WorkArea.Width - 800) / 2);
            fkybrd.Top = location.Y + 35 + 320 > SystemParameters.WorkArea.Height ? location.Y - 35 - 320 : location.Y + 35;
            fkybrd.Height = 320;
            fkybrd.Width = 800;
            fkybrd.IsWindow = true;
            fkybrd.calledform = this;
            fkybrd.Closing += FKybrd_Closing;
            fkybrd.Show();
            IsAboutFullKybrdOpen = true;
        }

        private void Number_GotFocus(object sender, RoutedEventArgs e)
        {
            if (Settings.UseTouchKeyboardInPOS == "N") return;
            CloseKeyboards();
            if (IsAboutNumKybrdOpen) return;

            nkybrd = new NumKeyboard();
            var location = ((FrameworkElement)sender).PointToScreen(new Point(0, 0));
            nkybrd.Left = location.X + 385 <= SystemParameters.WorkArea.Width ? location.X : location.X - (location.X + 385 - SystemParameters.WorkArea.Width);
            nkybrd.Top = location.Y + 35 + 270 > SystemParameters.WorkArea.Height ? location.Y - 270 : location.Y + 35;
            nkybrd.Height = 270;
            nkybrd.Width = 385;
            nkybrd.IsWindow = true;
            nkybrd.CalledForm = this;
            nkybrd.Closing += NKybrd_Closing;
            nkybrd.Show();
            IsAboutNumKybrdOpen = true;
        }

        private void CloseKeyboards()
        {
            if (fkybrd != null) fkybrd.Close();
            if (nkybrd != null) nkybrd.Close();
        }

        private void FKybrd_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (!IsAboutFullKybrdOpen) e.Cancel = true;
            else { IsAboutFullKybrdOpen = false; e.Cancel = false; }
        }

        private void NKybrd_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (!IsAboutNumKybrdOpen) e.Cancel = true;
            else { IsAboutNumKybrdOpen = false; e.Cancel = false; }
        }
    }
}
