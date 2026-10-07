using OfflineRetailV2.Data;
using System.Data;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace OfflineRetailV2.UserControls.POSSection
{
    /// <summary>
    /// Interaction logic for frm_POSPendingPaymentsDlg.xaml
    /// </summary>
    public partial class frm_POSPendingPaymentsDlg : Window
    {
        public int SelectedInvoiceNo { get; private set; }

        public frm_POSPendingPaymentsDlg()
        {
            InitializeComponent();
            Loaded += Frm_POSPendingPaymentsDlg_Loaded;
            ModalWindow.CloseCommand = new CommandBase(OnCloseCommand);
        }

        private void Frm_POSPendingPaymentsDlg_Loaded(object sender, RoutedEventArgs e)
        {
            PosDataObject.POS objPOS = new PosDataObject.POS();
            objPOS.Connection = SystemVariables.Conn;
            DataTable dtbl = objPOS.FetchPendingPayments();

            grdPendingPayments.ItemsSource = dtbl;
        }

        private async void btnOK_Click(object sender, RoutedEventArgs e)
        {
            await SelectInvoiceAndClose();
        }

        private async void gridView_PreviewMouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            await SelectInvoiceAndClose();
        }

        private async Task SelectInvoiceAndClose()
        {
            if (gridViewPending.FocusedRowHandle >= 0)
            {
                var selectedRow = grdPendingPayments.GetRow(gridViewPending.FocusedRowHandle) as DataRowView;
                if (selectedRow != null)
                {
                    SelectedInvoiceNo = GeneralFunctions.fnInt32(selectedRow["InvoiceNo"].ToString());
                    DialogResult = true;
                    Close();
                }
            }
        }

        private void TxtSearchGrdData_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtSearchGrdData.Text) || txtSearchGrdData.Text == "Search Unpaid Invoices")
            {
                grdPendingPayments.FilterString = "";
                return;
            }
            string filterValue = txtSearchGrdData.Text;
            grdPendingPayments.FilterString = $"[InvoiceNo] LIKE '%{filterValue}%' OR [Customer] LIKE '%{filterValue}%' OR [FirstItem] LIKE '%{filterValue}%'";
        }

        private void BtnCancel_Click(object sender, RoutedEventArgs e)
        {
            DialogResult = false;
            Close();
        }

        private void OnCloseCommand(object obj)
        {
            DialogResult = false;
            Close();
        }

        private void BtnUpHeader_Click(object sender, RoutedEventArgs e)
        {
            if (gridViewPending.FocusedRowHandle > 0)
            {
                gridViewPending.FocusedRowHandle--;
            }
        }

        private void BtnDownHeader_Click(object sender, RoutedEventArgs e)
        {
            if (gridViewPending.FocusedRowHandle < (grdPendingPayments.ItemsSource as DataTable).Rows.Count - 1)
            {
                gridViewPending.FocusedRowHandle++;
            }
        }
    }
}
