using OfflineRetailV2.Data;
using System.Data;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace OfflineRetailV2.UserControls
{
    /// <summary>
    /// Interaction logic for frm_UnpaidInvoicesBrwUC.xaml
    /// </summary>
    public partial class frm_UnpaidInvoicesBrwUC : UserControl
    {
        public frm_MainAdmin ParentForm { get; set; }

        public frm_UnpaidInvoicesBrwUC()
        {
            InitializeComponent();
        }

        private void btnBack_PreviewMouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            ParentForm.RedirectToSubmenu("Invoice");
        }

        public void FetchGridData()
        {
            PosDataObject.UnpaidInvoice objUnpaidInvoice = new PosDataObject.UnpaidInvoice();
            objUnpaidInvoice.Connection = SystemVariables.Conn;
            DataTable dbtbl = objUnpaidInvoice.FetchData();

            grdUnpaidInvoices.ItemsSource = dbtbl;
        }

        private void TxtSearchGrdData_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtSearchGrdData.Text) || txtSearchGrdData.Text == "Search Unpaid Invoices")
            {
                grdUnpaidInvoices.FilterString = "";
                return;
            }
            string filterValue = txtSearchGrdData.Text;
            grdUnpaidInvoices.FilterString = $"[InvoiceID] LIKE '%{filterValue}%' OR [Customer] LIKE '%{filterValue}%' OR [FirstItem] LIKE '%{filterValue}%' OR [AssignedStaff] LIKE '%{filterValue}%'";
        }

        private void btnCreateSimpleInvoice_Click(object sender, RoutedEventArgs e)
        {
            DocMessage.MsgInformation("Create Simple Invoice functionality is not implemented yet.");
        }

        private void btnCreateCustomInvoice_Click(object sender, RoutedEventArgs e)
        {
            DocMessage.MsgInformation("Create Custom Invoice functionality is not implemented yet.");
        }
    }
}
