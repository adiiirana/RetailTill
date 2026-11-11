using OfflineRetailV2.Data;
using System;
using System.Windows;
using System.Windows.Controls;

namespace OfflineRetailV2.SumUp
{
    /// <summary>SumUp payment method names and the method chooser. The payment itself runs in frm_SumUpTransaction.</summary>
    public static class SumUpReaderPayDialog
    {
        public const string MethodReader = "READER";
        public const string MethodCardForm = "CARDFORM";

        // Asks how to take the payment when both SumUp methods are on. Returns MethodReader, MethodCardForm, or "" when cancelled.
        public static string ChooseMethod(Window owner, decimal amount, string currency)
        {
            string choice = "";
            StackPanel sp = new StackPanel();
            sp.Children.Add(new TextBlock
            {
                Text = "How should " + amount.ToString("f2") + " " + currency + " be paid?",
                FontSize = 16,
                TextWrapping = TextWrapping.Wrap,
                Margin = new Thickness(20, 20, 20, 10)
            });
            Button btnReader = new Button { Content = "SumUp card reader", Height = 42, Margin = new Thickness(20, 4, 20, 4) };
            Button btnForm = new Button { Content = "Enter card details", Height = 42, Margin = new Thickness(20, 4, 20, 4) };
            Button btnCancel = new Button { Content = "Cancel", Height = 32, Margin = new Thickness(20, 4, 20, 20) };
            sp.Children.Add(btnReader);
            sp.Children.Add(btnForm);
            sp.Children.Add(btnCancel);
            Window w = new Window
            {
                Title = "SumUp Payment",
                Content = sp,
                Width = 400,
                SizeToContent = SizeToContent.Height,
                WindowStartupLocation = WindowStartupLocation.CenterOwner,
                ResizeMode = ResizeMode.NoResize,
                WindowStyle = WindowStyle.ToolWindow,
                Topmost = true
            };
            try { w.Owner = owner; } catch { }
            btnReader.Click += (s, e) => { choice = MethodReader; w.Close(); };
            btnForm.Click += (s, e) => { choice = MethodCardForm; w.Close(); };
            btnCancel.Click += (s, e) => { choice = ""; w.Close(); };
            w.ShowDialog();
            return choice;
        }
    }

    /// <summary>Outcome of a SumUp Solo reader payment. Success is true only when SumUp reported SUCCESSFUL.</summary>
    public class SumUpReaderResult
    {
        public bool Success { get; set; }
        public string Status { get; set; } = "";              // PAID | FAILED | CANCELLED | PENDING
        public decimal Amount { get; set; }                    // amount SumUp charged (falls back to the requested amount)
        public string TransactionId { get; set; } = "";        // SumUp transaction id, needed for refunds
        public string TransactionCode { get; set; } = "";      // code printed on the SumUp receipt
        public string ClientTransactionId { get; set; } = "";  // id used to look the payment up again
        public string Reference { get; set; } = "";
        public string Error { get; set; } = "";
        public int PaymentRowId { get; set; }                  // SumUpPayment.ID, 0 if logging failed
    }
}
