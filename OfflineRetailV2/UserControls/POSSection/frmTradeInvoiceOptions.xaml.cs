using System;
using System.Windows;
using System.Windows.Input;

namespace OfflineRetailV2.UserControls.POSSection
{
    /// <summary>
    /// Interaction logic for frmTradeInvoiceOptions.xaml
    /// </summary>
    public partial class frmTradeInvoiceOptions : Window
    {
        public string SelectedOption { get; private set; }
        public int TradeInvoiceID { get; set; }
        public Action PrintReceiptAction { get; set; }

        public frmTradeInvoiceOptions()
        {
            InitializeComponent();
            ModalWindow.CloseCommand = new CommandBase(OnCloseCommand);
        }

        private void OnCloseCommand(object obj)
        {
            this.DialogResult = false;
            this.Close();
        }

        private void BtnEmail_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                this.Cursor = Cursors.Wait;
                EditableInvoice_Dlg emailInvoiceDlg = new EditableInvoice_Dlg();
                emailInvoiceDlg.InvoiceID = this.TradeInvoiceID;
                emailInvoiceDlg.Owner = this;
                emailInvoiceDlg.LoadDataForEmail();
                bool emailSent = emailInvoiceDlg.SendInvoiceEmail();

                if (emailSent)
                {
                    new MessageBoxWindow().Show("Invoice successfully emailed to the customer.", "Email Sent", MessageBoxButton.OK, MessageBoxImage.Information);
                }
            }
            catch (Exception ex)
            {
                new MessageBoxWindow().Show("Failed to send email: " + ex.Message, "Email Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            finally
            {
                this.Cursor = Cursors.Arrow;
            }
        }

        private void BtnA4_Click(object sender, RoutedEventArgs e)
        {
            EditableInvoice_Dlg a4InvoiceDlg = new EditableInvoice_Dlg();
            a4InvoiceDlg.InvoiceID = this.TradeInvoiceID;
            a4InvoiceDlg.Owner = this;
            a4InvoiceDlg.ShowDialog();
        }

        private void BtnReceipt_Click(object sender, RoutedEventArgs e)
        {
            if (PrintReceiptAction != null)
            {
                this.Cursor = Cursors.Wait;
                PrintReceiptAction.Invoke();
                this.Cursor = Cursors.Arrow;
            }
        }
    }
}
