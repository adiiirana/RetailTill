using DevExpress.Xpf.Grid;
using OfflineRetailV2.Data;
using System;
using System.Data;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace OfflineRetailV2.UserControls.POSSection
{
    /// <summary>
    /// Interaction logic for frm_TradeInvoicesListDlg.xaml
    /// </summary>
    public partial class frm_TradeInvoicesListDlg : Window
    {
        public int SelectedTradeInvoiceId { get; private set; }
        public int SelectedCustomerID { get; private set; }
        public string SelectedCustomerName { get; private set; }

        public frm_TradeInvoicesListDlg()
        {
            InitializeComponent();
            Loaded += Frm_TradeInvoicesListDlg_Loaded;
            ModalWindow.CloseCommand = new CommandBase(OnCloseCommand);
        }

        private void Frm_TradeInvoicesListDlg_Loaded(object sender, RoutedEventArgs e)
        {
            PosDataObject.POS objPOS = new PosDataObject.POS();
            objPOS.Connection = SystemVariables.Conn;
            DataTable dtbl = objPOS.FetchTradeInvoicesList();

            grdTradeInvoices.ItemsSource = dtbl;
        }

        private void BtnEditBusinessInfo_Click(object sender, RoutedEventArgs e)
        {
            if (gridViewTrade.FocusedRowHandle >= 0)
            {
                var selectedRow = grdTradeInvoices.GetRow(gridViewTrade.FocusedRowHandle) as DataRowView;
                if (selectedRow != null)
                {
                    int selectedInvId = GeneralFunctions.fnInt32(selectedRow["TradeInvoiceId"].ToString());
                    int currentRowHandle = gridViewTrade.FocusedRowHandle;

                    EditableInvoice_Dlg optionsDlg = new EditableInvoice_Dlg();
                    optionsDlg.InvoiceID = selectedInvId;
                    optionsDlg.ShowDialog();

                    PosDataObject.POS objPOS = new PosDataObject.POS();
                    objPOS.Connection = SystemVariables.Conn;
                    DataTable dtbl = objPOS.FetchTradeInvoicesList();
                    grdTradeInvoices.ItemsSource = dtbl;
                    if (currentRowHandle < dtbl.Rows.Count)
                    {
                        gridViewTrade.FocusedRowHandle = currentRowHandle;
                    }
                }
            }
        }

        private void BtnSelectInvoice_Click(object sender, RoutedEventArgs e)
        {
            SelectInvoiceAndClose();
        }

        private void gridView_PreviewMouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            SelectInvoiceAndClose();
        }

        private void SelectInvoiceAndClose()
        {
            if (gridViewTrade.FocusedRowHandle >= 0)
            {
                var selectedRow = grdTradeInvoices.GetRow(gridViewTrade.FocusedRowHandle) as DataRowView;
                if (selectedRow != null)
                {
                    string status = selectedRow["Status"].ToString();
                    if (status.Equals("Voided", StringComparison.OrdinalIgnoreCase))
                    {
                        new MessageBoxWindow().Show("This invoice has been voided and cannot be selected.", "Action Not Allowed", MessageBoxButton.OK, MessageBoxImage.Warning);
                        return;
                    }
                    if (status.Equals("Paid", StringComparison.OrdinalIgnoreCase))
                    {
                        new MessageBoxWindow().Show("Invoice is already paid.", "Action Not Allowed", MessageBoxButton.OK, MessageBoxImage.Warning);
                        return;
                    }
                    else if (status.Equals("Partially Paid", StringComparison.OrdinalIgnoreCase))
                    {
                        new MessageBoxWindow().Show("This invoice is partially paid and cannot be edited. Please clear the balance to close it.", "Action Not Allowed", MessageBoxButton.OK, MessageBoxImage.Warning);
                        return;
                    }
                    SelectedTradeInvoiceId = GeneralFunctions.fnInt32(selectedRow["TradeInvoiceId"].ToString());
                    if (selectedRow.Row.Table.Columns.Contains("CustomerID"))
                    {
                        SelectedCustomerID = GeneralFunctions.fnInt32(selectedRow["CustomerID"].ToString());
                    }
                    string customerName = selectedRow["ContactPerson"] != DBNull.Value ? selectedRow["ContactPerson"].ToString() : "";
                    string companyName = selectedRow["Customer"] != DBNull.Value ? selectedRow["Customer"].ToString() : "";
                    SelectedCustomerName = customerName;
                    DialogResult = true;
                    Close();
                }
            }
        }

        private void TxtSearchGrdData_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtSearchGrdData.Text) || txtSearchGrdData.Text == "Search Trade Invoices")
            {
                grdTradeInvoices.FilterString = "";
                return;
            }
            string filterValue = txtSearchGrdData.Text;
            grdTradeInvoices.FilterString = $"ToStr([TradeInvoiceId]) LIKE '%{filterValue}%' OR [Customer] LIKE '%{filterValue}%'";
        }

        private void GrdTradeInvoices_CustomColumnDisplayText(object sender, CustomColumnDisplayTextEventArgs e)
        {
            if ((e.Column.FieldName == "Amount" || e.Column.FieldName == "AmountPaid" || e.Column.FieldName == "BalanceDue") && e.Value != null && e.Value != DBNull.Value)
            {
                double amountVal = 0;
                if (double.TryParse(e.Value.ToString(), out amountVal))
                {
                    e.DisplayText = SystemVariables.CurrencySymbol + " " + amountVal.ToString("f2");
                }
            }
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
            if (gridViewTrade.FocusedRowHandle > 0)
            {
                gridViewTrade.FocusedRowHandle--;
            }
        }

        private void BtnDownHeader_Click(object sender, RoutedEventArgs e)
        {
            if (gridViewTrade.FocusedRowHandle < (grdTradeInvoices.ItemsSource as DataTable).Rows.Count - 1)
            {
                gridViewTrade.FocusedRowHandle++;
            }
        }

        private void BtnEmail_Click(object sender, RoutedEventArgs e)
        {
            Button btn = sender as Button;
            if (btn != null && btn.Tag != null)
            {
                int selectedInvId = GeneralFunctions.fnInt32(btn.Tag.ToString());

                if (selectedInvId > 0)
                {
                    MessageBoxResult result = new MessageBoxWindow().Show("Are you sure you want to email this invoice to the customer?", "Confirm Email", MessageBoxButton.YesNo, MessageBoxImage.Question);
                    if (result != MessageBoxResult.Yes)
                    {
                        return;
                    }
                    try
                    {
                        this.Cursor = Cursors.Wait;
                        EditableInvoice_Dlg emailInvoiceDlg = new EditableInvoice_Dlg();
                        emailInvoiceDlg.InvoiceID = selectedInvId;
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
            }
        }

        private void BtnPay_Click(object sender, RoutedEventArgs e)
        {
            Button btn = sender as Button;
            if (btn != null && btn.Tag != null)
            {
                int selectedInvId = GeneralFunctions.fnInt32(btn.Tag.ToString());
                if (selectedInvId > 0)
                {
                    DataRowView selectedRow = null;
                    DataTable dt = grdTradeInvoices.ItemsSource as DataTable;
                    foreach (DataRowView row in dt.DefaultView)
                    {
                        if (row["TradeInvoiceId"].ToString() == selectedInvId.ToString())
                        {
                            selectedRow = row;
                            break;
                        }
                    }
                    if (selectedRow != null)
                    {
                        double amountDue = GeneralFunctions.fnDouble(selectedRow["BalanceDue"].ToString());
                        int customerId = GeneralFunctions.fnInt32(selectedRow["CustomerID"].ToString());
                        string custName = selectedRow["ContactPerson"] != DBNull.Value ? selectedRow["ContactPerson"].ToString() : "";
                        string compName = selectedRow["Customer"] != DBNull.Value ? selectedRow["Customer"].ToString() : "";
                        string dispCustId = customerId.ToString();
                        double credLimit = 0;

                        // Fetch Trade Customer details (Credit Limit)
                        PosDataObject.Customer objCust = new PosDataObject.Customer();
                        objCust.Connection = SystemVariables.Conn;
                        DataTable dtTrade = objCust.FetchTradeCustomer(customerId);
                        if (dtTrade != null && dtTrade.Rows.Count > 0)
                        {
                            credLimit = Convert.ToDouble(dtTrade.Rows[0]["CreditLimit"]);
                        }

                        // Fetch Account Ref (Display ID) using PosDataObject.POS
                        PosDataObject.POS objPOS = new PosDataObject.POS();
                        objPOS.Connection = SystemVariables.Conn;
                        DataTable dtRecord = objPOS.FetchCustomerRecord(customerId);
                        if (dtRecord != null && dtRecord.Rows.Count > 0)
                        {
                            dispCustId = dtRecord.Rows[0]["CustomerID"].ToString();
                        }

                        // Check if invoice was created with "Take Deposit" (Partially Paid) or Unpaid
                        double grossTotal = GeneralFunctions.fnDouble(selectedRow["Amount"].ToString());
                        int settlementOption = (amountDue < grossTotal) ? 2 : 1; // 2 = Take Deposit, 1 = Add to Trade Account

                        // Open the tender dialog in invoice payment mode
                        frmPOSTenderDlg frm_POSTenderDlg = new frmPOSTenderDlg();
                        int currentActiveSessionID = GeneralFunctions.GetTradeCloseOutID();
                        // Set properties for invoice payment
                        frm_POSTenderDlg.IsTradeInvoicePayment = true;
                        frm_POSTenderDlg.InitialSettlementOption = settlementOption;
                        frm_POSTenderDlg.PayTradeInvoiceId = selectedInvId;
                        frm_POSTenderDlg.PayTradeInvoiceAmount = amountDue;
                        frm_POSTenderDlg.CustID = customerId;
                        frm_POSTenderDlg.CustomerName = custName;
                        frm_POSTenderDlg.CompanyName = compName;
                        frm_POSTenderDlg.DisplayCustomerID = dispCustId;
                        frm_POSTenderDlg.CreditLimit = credLimit;
                        frm_POSTenderDlg.TradeCloseoutID = currentActiveSessionID;

                        // Provide a dummy cart to avoid null reference issues
                        DataTable dummyCart = new DataTable();
                        dummyCart.Columns.Add("ID", typeof(string));
                        dummyCart.Columns.Add("PRODUCTTYPE", typeof(string));
                        dummyCart.Columns.Add("QTY", typeof(string));
                        dummyCart.Columns.Add("PRICE", typeof(string));
                        dummyCart.Columns.Add("DISCOUNT", typeof(string));
                        frm_POSTenderDlg.POSDatatbl = dummyCart;

                        bool? res = frm_POSTenderDlg.ShowDialog();

                        // Refresh the grid after payment
                        if (res == true)
                        {
                            Frm_TradeInvoicesListDlg_Loaded(null, null);
                        }
                    }
                }
            }
        }

        private void BtnVoid_Click(object sender, RoutedEventArgs e)
        {
            Button btn = sender as Button;
            if (btn != null && btn.Tag != null)
            {
                int selectedInvId = GeneralFunctions.fnInt32(btn.Tag.ToString());

                if (selectedInvId > 0)
                {
                    MessageBoxResult result = new MessageBoxWindow().Show(
                        "Are you sure you want to void this invoice?\n\nThis action will restore customer's credit limit and reverse any payments associated with this invoice.",
                        "Confirm Void",
                        MessageBoxButton.YesNo,
                        MessageBoxImage.Warning);

                    if (result == MessageBoxResult.Yes)
                    {
                        try
                        {
                            this.Cursor = Cursors.Wait;
                            int currentActiveSessionID = GeneralFunctions.GetTradeCloseOutID();

                            PosDataObject.POS objPos = new PosDataObject.POS();
                            objPos.Connection = SystemVariables.Conn;

                            string res = objPos.VoidTradeInvoice(selectedInvId, currentActiveSessionID);

                            if (res == "Success")
                            {
                                new MessageBoxWindow().Show("Invoice Voided Successfully.", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
                                Frm_TradeInvoicesListDlg_Loaded(null, null);
                            }
                            else
                            {
                                new MessageBoxWindow().Show("Failed to void invoice: \n\n" + res, "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                            }
                        }
                        catch (Exception ex)
                        {
                            new MessageBoxWindow().Show("An error occurred: " + ex.Message, "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                        }
                        finally
                        {
                            this.Cursor = Cursors.Arrow;
                        }
                    }
                }
            }
        }
    }
}