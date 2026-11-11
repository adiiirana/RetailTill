using OfflineRetailV2.Data;
using System;
using System.Windows;

namespace OfflineRetailV2.SumUp
{
    /// <summary>
    /// Pays a SumUp checkout with card details, using the XEPOS-style popup frm_SumUpCardDetailsDlg.
    /// Only a SumUp SANDBOX account is accepted: the account is checked before any card field is shown,
    /// so a real card number is never typed into the till.
    /// </summary>
    public static class SumUpPayDialog
    {
        // Returns the checkout when it is PAID, otherwise null (closed without paying, refused, or error).
        // payUrl is kept for callers; the popup itself does not use it.
        public static SumUpCheckout Show(Window owner, int paymentRowId, string checkoutId, string reference,
            decimal amount, string currency, string payUrl, Action onChanged)
        {
            Settings.LoadSumUpSettings();
            if (Settings.SumUpApiKey == "" || Settings.SumUpMerchantCode == "")
            {
                DocMessage.MsgInformation("Please enter the SumUp API key and merchant code in General Settings > SumUp first.");
                return null;
            }

            SumUpCheckout checkoutInfo;
            try
            {
                SumUpClient probe = new SumUpClient(Settings.SumUpApiKey, Settings.SumUpMerchantCode);
                checkoutInfo = probe.GetCheckoutAsync(checkoutId).GetAwaiter().GetResult();
            }
            catch (Exception ex)
            {
                DocMessage.MsgInformation("Could not check this checkout with SumUp." + "\r\n" + ex.Message);
                return null;
            }
            if (!checkoutInfo.MerchantSandbox)
            {
                DocMessage.MsgInformation("This checkout is on a live SumUp account." + "\r\n"
                    + "Card details can only be entered for sandbox testing. Take live payments on the card reader.");
                return null;
            }
            if (checkoutInfo.Status == "PAID")
            {
                SumUpPaymentStore.UpdateStatus(paymentRowId, "PAID", checkoutInfo.TransactionCode);
                onChanged?.Invoke();
                return checkoutInfo;
            }

            var dlg = new frm_SumUpCardDetailsDlg(paymentRowId, checkoutId, reference, amount, currency, onChanged);
            try { if (owner != null && owner.IsLoaded) dlg.Owner = owner; } catch { }
            dlg.ShowDialog();
            return dlg.PaidCheckout;
        }
    }
}
