using OfflineRetailV2.Data;
using PdfSharp.Xps;
using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.IO.Packaging;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Printing;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Xps;
using System.Windows.Xps.Packaging;

namespace OfflineRetailV2.UserControls.POSSection
{
    /// <summary>
    /// Interaction logic for EditableInvoice_Dlg.xaml
    /// </summary>
    public partial class EditableInvoice_Dlg : Window
    {
        private int InvId;
        private bool IsLoading = false;
        private DateTime invoiceDate;

        public int InvoiceID
        {
            get { return InvId; }
            set { InvId = value; }
        }

        public EditableInvoice_Dlg()
        {
            InitializeComponent();
            this.Height = SystemParameters.WorkArea.Height;
            this.Top = SystemParameters.WorkArea.Top;
            this.Loaded += EditableInvoice_Dlg_Loaded;
            invoiceDate = DateTime.MinValue;
        }

        private void EditableInvoice_Dlg_Loaded(object sender, RoutedEventArgs e)
        {
            double screenWidth = SystemParameters.WorkArea.Width;
            this.Left = (screenWidth - this.Width) / 2;

            LoadCompanyLogo();
            if (InvId > 0)
            {
                LoadInvoiceData(InvId);
            }
        }

        private void LoadInvoiceData(int id)
        {
            try
            {
                IsLoading = true;
                PosDataObject.POS objPOS = new PosDataObject.POS();
                objPOS.Connection = SystemVariables.Conn;

                string currencySym = SystemVariables.CurrencySymbol + " ";

                string defaultNotes = "";
                string defaultTerms = "";
                string defaultBankName = "";
                string defaultAccountNo = "";
                string defaultSortCode = "";

                PosDataObject.POS objWholesale = new PosDataObject.POS();
                objWholesale.Connection = SystemVariables.Conn;
                DataTable dtWholesale = objWholesale.FetchTradeStoreData();

                if (dtWholesale.Rows.Count > 0)
                {
                    DataRow wr = dtWholesale.Rows[0];

                    defaultBankName = wr["WSBankName"].ToString();
                    defaultAccountNo = wr["WSAccountNo"].ToString();
                    defaultSortCode = wr["WSSortCode"].ToString();
                    defaultNotes = wr["WSNotes"].ToString();
                    defaultTerms = wr["WSTerms"].ToString();

                    bool showBank = wr["ShowBankDetails"].ToString() == "1" || wr["ShowBankDetails"].ToString().ToLower() == "true";
                    bool showTerms = wr["ShowTerms"].ToString() == "1" || wr["ShowTerms"].ToString().ToLower() == "true";
                    bool showNotes = wr["ShowNotes"].ToString() == "1" || wr["ShowNotes"].ToString().ToLower() == "true";

                    pnlBankDetails.Visibility = showBank ? Visibility.Visible : Visibility.Collapsed;
                    pnlTerms.Visibility = showTerms ? Visibility.Visible : Visibility.Collapsed;
                    pnlNotes.Visibility = showNotes ? Visibility.Visible : Visibility.Collapsed;
                }

                // Load Invoice Header Data
                DataTable dtHeader = objPOS.FetchTradeInvoiceHeader(id.ToString());
                if (dtHeader.Rows.Count > 0)
                {
                    DataRow dr = dtHeader.Rows[0];

                    txtReceiptNo.Text = dr["ID"].ToString();
                    txtPONumber.Text = dr["InvoiceNo"].ToString();
                    txtBillTo.Text = dr["CustAddress"].ToString();
                    txtShipTo.Text = dr["ShippingAddress"].ToString();

                    // FALLBACK LOGIC: If invoice-specific notes/terms/bank are empty, use the wholesale defaults
                    string invNotes = dr["Notes"].ToString();
                    txtNotes.Text = string.IsNullOrWhiteSpace(invNotes) ? defaultNotes : invNotes;

                    string invTerms = dr["Terms"].ToString();
                    txtTerms.Text = string.IsNullOrWhiteSpace(invTerms) ? defaultTerms : invTerms;

                    string invBankName = dr["BankName"].ToString();
                    txtBankName.Text = string.IsNullOrWhiteSpace(invBankName) ? defaultBankName : invBankName;

                    string invAccountNo = dr["AccountNo"].ToString();
                    txtAccountNo.Text = string.IsNullOrWhiteSpace(invAccountNo) ? defaultAccountNo : invAccountNo;

                    string invSortCode = dr["SortCode"].ToString();
                    txtSortCode.Text = string.IsNullOrWhiteSpace(invSortCode) ? defaultSortCode : invSortCode;

                    txtCompany.Text = dr["CustCompany"].ToString();
                    txtPhone.Text = dr["CustMobile"].ToString();
                    txtEmail.Text = dr["CustEmail"].ToString();

                    DateTime invDate = GeneralFunctions.fnDate(dr["InvoiceDate"].ToString());
                    txtInvoiceDate.Text = invDate.ToString("dd/MM/yyyy");
                    this.invoiceDate = invDate;

                    DateTime dueDate = GeneralFunctions.fnDate(dr["DueDate"].ToString());
                    txtDueDate.Text = dueDate.ToString("dd/MM/yyyy");

                    // Payment Terms Mapping
                    int paymentTermsDays = 0;
                    if (dr["PaymentTermsDays"] != DBNull.Value && !string.IsNullOrEmpty(dr["PaymentTermsDays"].ToString()))
                    {
                        int.TryParse(dr["PaymentTermsDays"].ToString(), out paymentTermsDays);
                    }

                    bool matched = false;
                    foreach (ComboBoxItem item in cmbPaymentTerms.Items)
                    {
                        if (item.Tag.ToString() == paymentTermsDays.ToString())
                        {
                            cmbPaymentTerms.SelectedItem = item;
                            matched = true;
                            break;
                        }
                    }
                    if (!matched) cmbPaymentTerms.SelectedIndex = -1;

                    // Totals and Status
                    double netTotal = GeneralFunctions.fnDouble(dr["NetTotal"].ToString());
                    double vatTotal = GeneralFunctions.fnDouble(dr["VatTotal"].ToString());
                    double grossTotal = GeneralFunctions.fnDouble(dr["GrossTotal"].ToString());
                    // Fetch live amount paid from Database
                    double amountPaid = 0;
                    using (SqlConnection conn = new SqlConnection(SystemVariables.ConnectionString))
                    {
                        conn.Open();
                        string sqlPaid = @"SELECT ISNULL(SUM(TenderAmount), 0)
                                   FROM TradeTender tt
                                   INNER JOIN TradeTrans tr ON tt.TransactionNo = tr.ID
                                   WHERE tr.TransType = 14 AND tr.TransNoteNo = @TradeInvoiceId";
                        using (SqlCommand cmdPaid = new SqlCommand(sqlPaid, conn))
                        {
                            cmdPaid.Parameters.AddWithValue("@TradeInvoiceId", id);
                            amountPaid = Convert.ToDouble(cmdPaid.ExecuteScalar() ?? 0);
                        }
                    }
                    string invoiceStatus = dr["Status"].ToString();
                    btnUpdate.Visibility = Visibility.Visible;
                    btnEmail.Visibility = Visibility.Visible;
                    btnUpdate.IsEnabled = true;
                    btnEmail.IsEnabled = true;
                    btnUpdate.Opacity = 1.0;
                    btnEmail.Opacity = 1.0;

                    if (invoiceStatus.Equals("Voided", StringComparison.OrdinalIgnoreCase))
                    {
                        txtInvoiceStatus.Text = "VOIDED";
                        txtInvoiceStatus.Foreground = new SolidColorBrush(Colors.Gray);

                        btnUpdate.IsEnabled = false;
                        btnEmail.IsEnabled = false;
                        btnUpdate.Opacity = 0.5;
                        btnEmail.Opacity = 0.5;
                    }
                    else if (invoiceStatus.Equals("Paid", StringComparison.OrdinalIgnoreCase) || amountPaid >= grossTotal)
                    {
                        amountPaid = grossTotal;
                        txtInvoiceStatus.Text = "PAID";
                        txtInvoiceStatus.Foreground = new SolidColorBrush(Color.FromRgb(71, 169, 41)); // Green
                    }
                    else if (invoiceStatus.Equals("Partially Paid", StringComparison.OrdinalIgnoreCase) || amountPaid > 0)
                    {
                        txtInvoiceStatus.Text = "PARTIALLY PAID";
                        txtInvoiceStatus.Foreground = new SolidColorBrush(Colors.DarkOrange); // Orange
                    }
                    else
                    {
                        txtInvoiceStatus.Text = "UNPAID";
                        txtInvoiceStatus.Foreground = new SolidColorBrush(Color.FromRgb(198, 62, 59)); // Red
                    }

                    double balanceDue = grossTotal - amountPaid;
                    txtSubtotal.Text = currencySym + GeneralFunctions.FormatDouble1(netTotal);
                    txtTaxAmount.Text = currencySym + GeneralFunctions.FormatDouble1(vatTotal);
                    txtTotal.Text = currencySym + GeneralFunctions.FormatDouble1(grossTotal);
                    txtAmountPaid.Text = currencySym + GeneralFunctions.FormatDouble1(amountPaid);
                    txtBalanceDue.Text = currencySym + GeneralFunctions.FormatDouble1(balanceDue);

                    // Signature
                    if (dtHeader.Columns.Contains("CompanySignature") && dr["CompanySignature"] != DBNull.Value)
                    {
                        try
                        {
                            byte[] sigBytes = (byte[])dr["CompanySignature"];
                            imgSignature.Source = GetImageFromByteArray(sigBytes);
                            pnlSignaturePlaceholder.Visibility = Visibility.Collapsed;
                        }
                        catch
                        {
                            imgSignature.Source = null;
                            pnlSignaturePlaceholder.Visibility = Visibility.Visible;
                        }
                    }
                    else
                    {
                        imgSignature.Source = null;
                        pnlSignaturePlaceholder.Visibility = Visibility.Visible;
                    }
                }

                // Load Invoice Line Items
                DataTable dtDetails = objPOS.FetchTradeInvoiceDetails(id.ToString());
                if (dtDetails != null && dtDetails.Rows.Count > 0)
                {
                    var groupedItems = dtDetails.AsEnumerable()
                        .GroupBy(r => new
                        {
                            ProductID = r["ProductID"],
                            Description = r["Description"],
                            Price = r["Price"]
                        })
                        .Select(g => new
                        {
                            Description = g.Key.Description,
                            Qty = g.Sum(row => GeneralFunctions.fnDouble(row["Qty"].ToString())),
                            Price = GeneralFunctions.fnDouble(g.Key.Price.ToString()),
                            TotalPrice = g.Sum(row => GeneralFunctions.fnDouble(row["TotalPrice"].ToString()))
                        })
                        .ToList();

                    DataTable dtDisplay = new DataTable();
                    dtDisplay.Columns.Add("Description", typeof(string));
                    dtDisplay.Columns.Add("Qty", typeof(double));
                    dtDisplay.Columns.Add("FormattedPrice", typeof(string));
                    dtDisplay.Columns.Add("FormattedTotal", typeof(string));

                    foreach (var item in groupedItems)
                    {
                        DataRow newRow = dtDisplay.NewRow();
                        newRow["Description"] = item.Description;
                        newRow["Qty"] = item.Qty;
                        newRow["FormattedPrice"] = currencySym + GeneralFunctions.FormatDouble1(item.Price);
                        newRow["FormattedTotal"] = currencySym + GeneralFunctions.FormatDouble1(item.TotalPrice);
                        dtDisplay.Rows.Add(newRow);
                    }
                    lstItems.ItemsSource = dtDisplay.DefaultView;
                }
            }
            catch (Exception ex)
            {
                GeneralFunctions.SetTransactionLog("Error loading Editable Invoice Data", ex.Message);
            }
            finally
            {
                IsLoading = false;
            }
        }

        private void CmbPaymentTerms_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (IsLoading || !this.IsLoaded) return;
            CalculateDueDate();
        }

        private void CalculateDueDate()
        {
            if (txtDueDate == null) return;
            try
            {
                int days = GetSelectedPaymentDays();
                DateTime invDate = invoiceDate != DateTime.MinValue ? invoiceDate : DateTime.Today;
                DateTime newDueDate = invDate.AddDays(days);
                txtDueDate.Text = newDueDate.ToString("dd/MM/yyyy");
            }
            catch { }
        }

        private int GetSelectedPaymentDays()
        {
            if (cmbPaymentTerms.SelectedItem is ComboBoxItem selectedItem)
            {
                if (int.TryParse(selectedItem.Tag.ToString(), out int days))
                {
                    return days;
                }
            }
            return 0;
        }

        private void btnUpdate_Click(object sender, RoutedEventArgs e)
        {
            if (InvId <= 0) return;

            // Validate Company Name
            if (string.IsNullOrWhiteSpace(txtCompany.Text))
            {
                new MessageBoxWindow().Show("Company Name cannot be empty.", "Validation Error", MessageBoxButton.OK, MessageBoxImage.Warning);
                txtCompany.Focus();
                return;
            }

            // Validate Phone
            if (string.IsNullOrWhiteSpace(txtPhone.Text))
            {
                new MessageBoxWindow().Show("Phone number cannot be empty.", "Validation Error", MessageBoxButton.OK, MessageBoxImage.Warning);
                txtPhone.Focus();
                return;
            }

            // Validate Email
            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                new MessageBoxWindow().Show("Email cannot be empty.", "Validation Error", MessageBoxButton.OK, MessageBoxImage.Warning);
                txtEmail.Focus();
                return;
            }

            // Validate Billing Address
            if (string.IsNullOrWhiteSpace(txtBillTo.Text))
            {
                new MessageBoxWindow().Show("Billing Address (Bill To) cannot be empty.", "Validation Error", MessageBoxButton.OK, MessageBoxImage.Warning);
                txtBillTo.Focus();
                return;
            }

            // Validate Shipping Address
            if (string.IsNullOrWhiteSpace(txtShipTo.Text))
            {
                new MessageBoxWindow().Show("Shipping Address (Ship To) cannot be empty.", "Validation Error", MessageBoxButton.OK, MessageBoxImage.Warning);
                txtShipTo.Focus();
                return;
            }

            // Validate Payment Terms
            if (cmbPaymentTerms.SelectedIndex == -1)
            {
                new MessageBoxWindow().Show("Please select Payment Terms.", "Validation Error", MessageBoxButton.OK, MessageBoxImage.Warning);
                cmbPaymentTerms.Focus();
                return;
            }

            // Validate Due Date
            if (string.IsNullOrWhiteSpace(txtDueDate.Text))
            {
                new MessageBoxWindow().Show("Due Date cannot be empty.", "Validation Error", MessageBoxButton.OK, MessageBoxImage.Warning);
                txtDueDate.Focus();
                return;
            }
            try
            {
                this.Cursor = Cursors.Wait;

                PosDataObject.POS objPOS = new PosDataObject.POS();
                objPOS.Connection = SystemVariables.Conn;

                string billingAddress = txtBillTo.Text;
                string shippingAddress = txtShipTo.Text;
                string company = txtCompany.Text;
                string phone = txtPhone.Text;
                string email = txtEmail.Text;
                int paymentTerms = GetSelectedPaymentDays();
                string termsText = (cmbPaymentTerms.SelectedItem as ComboBoxItem)?.Content.ToString() ?? "";
                string notes = txtNotes.Text;
                string terms = txtTerms.Text;

                string bankName = txtBankName.Text;
                string accountNo = txtAccountNo.Text;
                string sortCode = txtSortCode.Text;

                DateTime dueDate = (invoiceDate != DateTime.MinValue)
                    ? invoiceDate.AddDays(paymentTerms)
                    : DateTime.Today;

                objPOS.UpdateTradeInvoiceEditableData(InvId, billingAddress, shippingAddress, company, phone, email, paymentTerms, 
                    dueDate, notes, terms, bankName, accountNo, sortCode);

                new MessageBoxWindow().Show("Invoice updated successfully.", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            catch (Exception ex)
            {
                new MessageBoxWindow().Show("Error updating invoice: " + ex.Message, "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                GeneralFunctions.SetTransactionLog("Error saving Invoice changes", ex.Message);
            }
            finally
            {
                this.Cursor = Cursors.Arrow;
            }
        }

        private void LoadCompanyLogo()
        {
            try
            {
                PosDataObject.POS objPOS = new PosDataObject.POS();
                objPOS.Connection = SystemVariables.Conn;

                DataTable dtLogo = objPOS.FetchStoreLogo();

                if (dtLogo.Rows.Count > 0)
                {
                    if (dtLogo.Rows[0]["logo"] != DBNull.Value)
                    {
                        byte[] imgData = (byte[])dtLogo.Rows[0]["logo"];
                        imgLogo.Source = GetImageFromByteArray(imgData);
                        pnlLogoPlaceholder.Visibility = Visibility.Collapsed;
                    }
                }
            }
            catch (Exception ex)
            {
                GeneralFunctions.SetTransactionLog("Error loading Logo in EditableInvoice", ex.Message);
            }
        }

        private BitmapImage GetImageFromByteArray(byte[] array)
        {
            if (array == null || array.Length == 0) return null;

            var image = new BitmapImage();
            using (var ms = new MemoryStream(array))
            {
                ms.Position = 0;
                image.BeginInit();
                image.CreateOptions = BitmapCreateOptions.PreservePixelFormat;
                image.CacheOption = BitmapCacheOption.OnLoad;
                image.UriSource = null;
                image.StreamSource = ms;
                image.EndInit();
            }
            image.Freeze();
            return image;
        }

        private void BtnPrint_Click(object sender, RoutedEventArgs e)
        {
            PrintDialog printDlg = new PrintDialog();
            bool isPrinterFound = false;
            try
            {
                LocalPrintServer localPrintServer = new LocalPrintServer();
                PrintQueue printQueue = localPrintServer.GetPrintQueues()
                    .FirstOrDefault(pq => pq.Name.Equals("Microsoft Print to PDF", StringComparison.OrdinalIgnoreCase));
                if (printQueue != null)
                {
                    printDlg.PrintQueue = printQueue;
                    isPrinterFound = true;
                }
            }
            catch{}

            if (isPrinterFound || printDlg.ShowDialog() == true)
            {
                double pageWidth = 793;
                // Document Generate
                FlowDocument doc = GenerateInvoiceDocument(pageWidth);

                doc.PageHeight = printDlg.PrintableAreaHeight;
                doc.PageWidth = printDlg.PrintableAreaWidth;
                doc.PagePadding = new Thickness(40);
                doc.ColumnGap = 0;
                doc.ColumnWidth = doc.PageWidth - doc.PagePadding.Left - doc.PagePadding.Right;

                IDocumentPaginatorSource idpSource = doc;
                printDlg.PrintDocument(idpSource.DocumentPaginator, "Invoice Print");
            }
        }

        private FlowDocument GenerateInvoiceDocument(double pageWidth)
        {
            FlowDocument doc = new FlowDocument();
            doc.FontFamily = new FontFamily("Arial");
            doc.FontSize = 12;
            doc.Background = Brushes.White;
            doc.TextAlignment = TextAlignment.Left;

            // HEADER SECTION (Logo & Invoice Info)
            Table headerTable = new Table();
            headerTable.CellSpacing = 0;
            headerTable.Columns.Add(new TableColumn() { Width = new GridLength(1.2, GridUnitType.Star) }); // Left (Logo)
            headerTable.Columns.Add(new TableColumn() { Width = new GridLength(1, GridUnitType.Star) });   // Right (Info)

            TableRowGroup headerGroup = new TableRowGroup();
            TableRow headerRow = new TableRow();

            // LEFT CELL: Logo & Company Info
            TableCell logoCell = new TableCell();
            BlockUIContainer logoContainer = new BlockUIContainer();
            Image imgPrint = new Image();

            if (imgLogo.Source != null)
            {
                imgPrint.Source = imgLogo.Source;
                imgPrint.Height = 150; // Logo
                imgPrint.Stretch = Stretch.Uniform;
                imgPrint.HorizontalAlignment = HorizontalAlignment.Left;
            }
            logoContainer.Child = imgPrint;
            logoCell.Blocks.Add(logoContainer);

            Paragraph pComp = new Paragraph(new Run(txtCompany.Text));
            pComp.FontWeight = FontWeights.Bold;
            pComp.FontSize = 18;
            pComp.Margin = new Thickness(0, 10, 0, 8);
            logoCell.Blocks.Add(pComp);

            Paragraph pPhone = new Paragraph(new Run($"Phone: {txtPhone.Text}"));
            pPhone.FontSize = 12;
            pPhone.Foreground = Brushes.Black;
            pPhone.Margin = new Thickness(0, 0, 0, 5);
            logoCell.Blocks.Add(pPhone);

            Paragraph pEmail = new Paragraph(new Run($"Email: {txtEmail.Text}"));
            pEmail.FontSize = 12;
            pEmail.Foreground = Brushes.Black;
            pEmail.Margin = new Thickness(0, 0, 0, 0);
            logoCell.Blocks.Add(pEmail);

            headerRow.Cells.Add(logoCell);

            // RIGHT CELL: Invoice Meta Data
            TableCell metaCell = new TableCell();

            // Title
            Paragraph pInvTitle = new Paragraph(new Run("INVOICE"));
            pInvTitle.FontSize = 40;
            pInvTitle.TextAlignment = TextAlignment.Right;
            pInvTitle.Foreground = Brushes.LightSlateGray;
            pInvTitle.FontWeight = FontWeights.Light;
            pInvTitle.Margin = new Thickness(0, 50, 0, 10);
            metaCell.Blocks.Add(pInvTitle);

            BlockUIContainer detailsContainer = new BlockUIContainer();
            Grid detailsGrid = new Grid();
            detailsGrid.HorizontalAlignment = HorizontalAlignment.Right;

            detailsGrid.ColumnDefinitions.Add(new ColumnDefinition() { Width = GridLength.Auto });
            detailsGrid.ColumnDefinitions.Add(new ColumnDefinition() { Width = GridLength.Auto });

            int rIndex = 0;

            Action<string, string, bool> addDetailRow = (label, value, isBold) =>
            {
                detailsGrid.RowDefinitions.Add(new RowDefinition());

                TextBlock lbl = new TextBlock(new Run(label));
                lbl.Foreground = Brushes.Black;
                lbl.Margin = new Thickness(0, 0, 15, 5);
                lbl.HorizontalAlignment = HorizontalAlignment.Left;
                if (isBold) { lbl.FontWeight = FontWeights.Bold; lbl.Foreground = Brushes.Black; }

                TextBlock val = new TextBlock(new Run(value));
                val.Foreground = Brushes.Black;
                val.Margin = new Thickness(0, 0, 0, 5);
                val.HorizontalAlignment = HorizontalAlignment.Left;
                if (isBold) { val.FontWeight = FontWeights.Bold; }

                Grid.SetRow(lbl, rIndex); Grid.SetColumn(lbl, 0);
                Grid.SetRow(val, rIndex); Grid.SetColumn(val, 1);
                detailsGrid.Children.Add(lbl); detailsGrid.Children.Add(val);
                rIndex++;
            };

            // Add The Rows
            addDetailRow("Invoice #:", txtReceiptNo.Text, true);
            addDetailRow("Invoice Date:", txtInvoiceDate.Text, false);
            addDetailRow("PO #:", txtPONumber.Text, false);
            addDetailRow("Due Date:", txtDueDate.Text, false);

            detailsContainer.Child = detailsGrid;
            metaCell.Blocks.Add(detailsContainer);

            headerRow.Cells.Add(metaCell);

            headerGroup.Rows.Add(headerRow);
            headerTable.RowGroups.Add(headerGroup);
            doc.Blocks.Add(headerTable);

            // ADDRESS SECTION (Bill To / Ship To)
            Table addrTable = new Table();
            addrTable.Margin = new Thickness(0, 25, 0, 25);
            addrTable.Columns.Add(new TableColumn() { Width = new GridLength(1, GridUnitType.Star) });
            addrTable.Columns.Add(new TableColumn() { Width = new GridLength(1, GridUnitType.Star) });

            TableRowGroup addrGroup = new TableRowGroup();
            TableRow addrRow = new TableRow();

            // Bill To
            TableCell billCell = new TableCell();
            billCell.Blocks.Add(new Paragraph(new Run("Bill To")) { FontWeight = FontWeights.SemiBold, Foreground = Brushes.Black });
            billCell.Blocks.Add(new Paragraph(new Run(txtBillTo.Text)) { Margin = new Thickness(0, 5, 20, 0), Foreground = Brushes.Black });
            addrRow.Cells.Add(billCell);

            // Ship To
            TableCell shipCell = new TableCell();
            shipCell.Blocks.Add(new Paragraph(new Run("Ship To")) { FontWeight = FontWeights.SemiBold, Foreground = Brushes.Black });
            shipCell.Blocks.Add(new Paragraph(new Run(txtShipTo.Text)) { Margin = new Thickness(0, 5, 0, 0), Foreground = Brushes.Black });
            addrRow.Cells.Add(shipCell);

            addrGroup.Rows.Add(addrRow);
            addrTable.RowGroups.Add(addrGroup);
            doc.Blocks.Add(addrTable);

            // ITEMS TABLE
            Table itemsTable = new Table();
            itemsTable.CellSpacing = 0;
            itemsTable.BorderBrush = Brushes.LightGray;
            itemsTable.BorderThickness = new Thickness(0, 0, 0, 1);
            itemsTable.Margin = new Thickness(0, 0, 0, 20);

            itemsTable.Columns.Add(new TableColumn() { Width = new GridLength(5, GridUnitType.Star) }); // Desc
            itemsTable.Columns.Add(new TableColumn() { Width = new GridLength(1, GridUnitType.Star) }); // Qty
            itemsTable.Columns.Add(new TableColumn() { Width = new GridLength(1.5, GridUnitType.Star) }); // Rate
            itemsTable.Columns.Add(new TableColumn() { Width = new GridLength(1.5, GridUnitType.Star) }); // Amount

            TableRowGroup itemsGroup = new TableRowGroup();

            // Header Row
            TableRow itemsHeader = new TableRow();
            itemsHeader.Background = (Brush)new BrushConverter().ConvertFrom("#111827");
            itemsHeader.Cells.Add(CreateHeaderCell("Item", TextAlignment.Left));
            itemsHeader.Cells.Add(CreateHeaderCell("Qty", TextAlignment.Center));
            itemsHeader.Cells.Add(CreateHeaderCell("Rate", TextAlignment.Center));
            itemsHeader.Cells.Add(CreateHeaderCell("Amount", TextAlignment.Right));
            itemsGroup.Rows.Add(itemsHeader);

            // Data Rows
            if (lstItems.ItemsSource is DataView dv)
            {
                foreach (DataRowView row in dv)
                {
                    TableRow itemRow = new TableRow();
                    itemRow.Cells.Add(CreateDataCell(row["Description"].ToString(), TextAlignment.Left));
                    itemRow.Cells.Add(CreateDataCell(row["Qty"].ToString(), TextAlignment.Center));
                    itemRow.Cells.Add(CreateDataCell(row["FormattedPrice"].ToString(), TextAlignment.Center));
                    itemRow.Cells.Add(CreateDataCell(row["FormattedTotal"].ToString(), TextAlignment.Right));
                    itemsGroup.Rows.Add(itemRow);
                }
            }
            itemsTable.RowGroups.Add(itemsGroup);
            doc.Blocks.Add(itemsTable);

            // FOOTER SECTION
            BlockUIContainer footerContainer = new BlockUIContainer();

            Grid footerGrid = new Grid();
            footerGrid.Margin = new Thickness(0, 10, 0, 0);
            footerGrid.ColumnDefinitions.Add(new ColumnDefinition() { Width = new GridLength(1.8, GridUnitType.Star) }); // Left (Notes)
            footerGrid.ColumnDefinitions.Add(new ColumnDefinition() { Width = new GridLength(1.2, GridUnitType.Star) }); // Right (Totals)

            // REPLACE THE OLD "LEFT SIDE: Notes & Terms" SECTION WITH THIS:

            // LEFT SIDE: Notes, Terms & Bank Details
            StackPanel pnlLeftFooter = new StackPanel();
            pnlLeftFooter.Margin = new Thickness(0, 0, 20, 0);

            // Dynamic Notes
            if (pnlNotes.Visibility == Visibility.Visible && !string.IsNullOrEmpty(txtNotes.Text))
            {
                pnlLeftFooter.Children.Add(new TextBlock() { Text = "Notes", FontWeight = FontWeights.SemiBold, Foreground = Brushes.Black, Margin = new Thickness(0, 0, 0, 2) });
                pnlLeftFooter.Children.Add(new TextBlock() { Text = txtNotes.Text, FontSize = 11, TextWrapping = TextWrapping.Wrap, Margin = new Thickness(0, 0, 0, 15), Foreground = Brushes.Black });
            }

            // Dynamic Terms
            if (pnlTerms.Visibility == Visibility.Visible && !string.IsNullOrEmpty(txtTerms.Text))
            {
                pnlLeftFooter.Children.Add(new TextBlock() { Text = "Terms & Conditions", FontWeight = FontWeights.SemiBold, Foreground = Brushes.Black, Margin = new Thickness(0, 0, 0, 2) });
                pnlLeftFooter.Children.Add(new TextBlock() { Text = txtTerms.Text, FontSize = 11, TextWrapping = TextWrapping.Wrap, Margin = new Thickness(0, 0, 0, 15), Foreground = Brushes.Black });
            }

            // Dynamic Bank Details
            if (pnlBankDetails.Visibility == Visibility.Visible)
            {
                pnlLeftFooter.Children.Add(new TextBlock() { Text = "Bank Payment Details", FontWeight = FontWeights.SemiBold, Foreground = Brushes.Black, Margin = new Thickness(0, 0, 0, 2) });
                string bankInfo = $"Bank: {txtBankName.Text}\nAccount: {txtAccountNo.Text}\nSort Code: {txtSortCode.Text}";
                pnlLeftFooter.Children.Add(new TextBlock() { Text = bankInfo, FontSize = 11, Foreground = Brushes.Black });
            }

            Grid.SetColumn(pnlLeftFooter, 0);
            footerGrid.Children.Add(pnlLeftFooter);

            //Grid.SetColumn(pnlNotes, 0);
            //footerGrid.Children.Add(pnlNotes);

            // RIGHT SIDE: Totals & Signature
            StackPanel pnlTotals = new StackPanel();

            // Totals Grid
            Grid gridTotals = new Grid();
            gridTotals.ColumnDefinitions.Add(new ColumnDefinition() { Width = new GridLength(1, GridUnitType.Star) });
            gridTotals.ColumnDefinitions.Add(new ColumnDefinition() { Width = GridLength.Auto });

            int tRowIndex = 0;
            AddGridRow(gridTotals, ref tRowIndex, "Subtotal", txtSubtotal.Text, false);
            AddGridRow(gridTotals, ref tRowIndex, "Tax", txtTaxAmount.Text, false);
            AddGridRow(gridTotals, ref tRowIndex, "Total", txtTotal.Text, true);
            AddGridRow(gridTotals, ref tRowIndex, "Amount Paid", txtAmountPaid.Text, false);
            AddGridRow(gridTotals, ref tRowIndex, "Balance Due", txtBalanceDue.Text, true);
            AddGridRow(gridTotals, ref tRowIndex, "Status", txtInvoiceStatus.Text, true);

            pnlTotals.Children.Add(gridTotals);

            // Signature
            StackPanel pnlSig = new StackPanel();
            pnlSig.Margin = new Thickness(0, 40, 0, 0);
            pnlSig.HorizontalAlignment = HorizontalAlignment.Right;

            pnlSig.Children.Add(new TextBlock()
            {
                Text = "Authorized Signature",
                FontWeight = FontWeights.SemiBold,
                Foreground = Brushes.Black,
                HorizontalAlignment = HorizontalAlignment.Right,
                FontSize = 13,
                Margin = new Thickness(0, 0, 0, 5)
            });

            Image imgSigPrint = new Image();
            if (imgSignature.Source != null)
            {
                imgSigPrint.Source = imgSignature.Source;
                imgSigPrint.Height = 120;
                imgSigPrint.Stretch = Stretch.Uniform;
                imgSigPrint.HorizontalAlignment = HorizontalAlignment.Right;
                pnlSig.Children.Add(imgSigPrint);
            }
            else
            {
                Border line = new Border() { BorderBrush = Brushes.Black, BorderThickness = new Thickness(0, 0, 0, 1), Width = 180, Height = 1, HorizontalAlignment = HorizontalAlignment.Right };
                pnlSig.Children.Add(line);
            }

            pnlTotals.Children.Add(pnlSig);

            Grid.SetColumn(pnlTotals, 1);
            footerGrid.Children.Add(pnlTotals);

            footerContainer.Child = footerGrid;
            doc.Blocks.Add(footerContainer);

            return doc;
        }

        private void AddGridRow(Grid grid, ref int rowIndex, string label, string value, bool isBold)
        {
            grid.RowDefinitions.Add(new RowDefinition());

            TextBlock lbl = new TextBlock() { Text = label };
            TextBlock val = new TextBlock() { Text = value, TextAlignment = TextAlignment.Right, Margin = new Thickness(10, 0, 0, 0) };

            lbl.FontWeight = FontWeights.Bold;
            lbl.FontSize = 13;
            lbl.Foreground = Brushes.Black;

            val.FontWeight = FontWeights.Bold;
            val.FontSize = 13;
            val.Foreground = Brushes.Black;

            // Spacing
            lbl.Margin = new Thickness(0, 4, 0, 4);
            val.Margin = new Thickness(0, 4, 0, 4);

            Grid.SetColumn(lbl, 0); Grid.SetRow(lbl, rowIndex);
            Grid.SetColumn(val, 1); Grid.SetRow(val, rowIndex);

            grid.Children.Add(lbl);
            grid.Children.Add(val);

            rowIndex++;
        }

        private TableCell CreateHeaderCell(string text, TextAlignment align)
        {
            TableCell cell = new TableCell(new Paragraph(new Run(text)));
            cell.Foreground = Brushes.White;
            cell.FontWeight = FontWeights.Bold;
            cell.Padding = new Thickness(10, 6, 10, 6);
            cell.TextAlignment = align;
            return cell;
        }

        private TableCell CreateDataCell(string text, TextAlignment align)
        {
            TableCell cell = new TableCell(new Paragraph(new Run(text)));
            cell.Padding = new Thickness(10, 6, 10, 6);
            cell.BorderBrush = Brushes.LightGray;
            cell.BorderThickness = new Thickness(0, 0, 0, 1);
            cell.TextAlignment = align;
            return cell;
        }

        private void BtnEmail_Click(object sender, RoutedEventArgs e)
        {
            MessageBoxResult result = new MessageBoxWindow().Show("Are you sure you want to Email?", "Confirm Email", MessageBoxButton.YesNo, MessageBoxImage.Question);
            if (result != MessageBoxResult.Yes)
            {
                return;
            }
            try
            {
                this.Cursor = Cursors.Wait;
                bool emailSent = SendInvoiceEmail();

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

        public void LoadDataForEmail()
        {
            LoadCompanyLogo();
            if (InvId > 0)
            {
                LoadInvoiceData(InvId);
            }
        }

        public bool SendInvoiceEmail()
        {
            string customerEmail = txtEmail.Text.Trim();

            if (string.IsNullOrEmpty(customerEmail))
            {
                new MessageBoxWindow().Show("Customer email address is missing in trade account.", "Validation Error", MessageBoxButton.OK, MessageBoxImage.Warning);
                return false;
            }

            try
            {
                double pageWidth = 793;
                FlowDocument doc = GenerateInvoiceDocument(pageWidth);
                doc.PagePadding = new Thickness(40);
                doc.ColumnGap = 0;
                doc.ColumnWidth = pageWidth - doc.PagePadding.Left - doc.PagePadding.Right;

                string tempPath = Path.GetTempPath();
                string xpsFileName = $"TradeInvoice_{txtReceiptNo.Text}.xps";
                string xpsFilePath = Path.Combine(tempPath, xpsFileName);

                if (File.Exists(xpsFilePath))
                {
                    File.Delete(xpsFilePath);
                }

                using (Package package = Package.Open(xpsFilePath, FileMode.Create))
                {
                    using (XpsDocument xpsDoc = new XpsDocument(package))
                    {
                        XpsDocumentWriter xpsWriter = XpsDocument.CreateXpsDocumentWriter(xpsDoc);
                        xpsWriter.Write(((IDocumentPaginatorSource)doc).DocumentPaginator);
                    }
                }

                string pdfFileName = $"TradeInvoice_{txtReceiptNo.Text}.pdf";
                string pdfFilePath = Path.Combine(tempPath, pdfFileName);

                if (File.Exists(pdfFilePath))
                {
                    File.Delete(pdfFilePath);
                }

                XpsConverter.Convert(xpsFilePath, pdfFilePath, 0);

                // SMTP Settings
                string SMTP_HOST = Settings.REHost;
                string SMTP_USER = Settings.REUser;
                string SMTP_PSWD = Settings.REPassword;
                int SMTP_PORT = Settings.REPort;
                bool SMTP_SSL = Settings.RESSL == "Y";
                string FROM_EMAIL = Settings.REFromAddress;
                string FROM_NAME = Settings.REFromName;

                if (string.IsNullOrEmpty(SMTP_HOST) || string.IsNullOrEmpty(FROM_EMAIL))
                {
                    new MessageBoxWindow().Show("SMTP email settings are not configured properly in General Settings.", "Email Setup Missing", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return false;
                }

                // Send Email
                using (SmtpClient smtp = new SmtpClient())
                {
                    smtp.Host = SMTP_HOST;
                    smtp.Port = SMTP_PORT > 0 ? SMTP_PORT : 587; // Default to 587
                    smtp.EnableSsl = SMTP_SSL;
                    smtp.Credentials = new NetworkCredential(SMTP_USER, SMTP_PSWD);

                    using (MailMessage msg = new MailMessage())
                    {
                        msg.From = new MailAddress(FROM_EMAIL, string.IsNullOrEmpty(FROM_NAME) ? Settings.Company : FROM_NAME);
                        msg.To.Add(new MailAddress(customerEmail, txtCompany.Text));

                        if (!string.IsNullOrEmpty(Settings.REReplyTo))
                        {
                            msg.ReplyToList.Add(new MailAddress(Settings.REReplyTo));
                        }

                        // Dynamic Color and Status Text for PAID, PARTIALLY PAID, and UNPAID
                        string statusColor = "";
                        string invoiceStatusText = "";

                        if (txtInvoiceStatus.Text.ToUpper() == "PAID")
                        {
                            statusColor = "#47a929"; // Green
                            invoiceStatusText = "This invoice has been successfully paid in full.";
                        }
                        else if (txtInvoiceStatus.Text.ToUpper() == "PARTIALLY PAID")
                        {
                            statusColor = "#e67e22"; // Orange
                            invoiceStatusText = "A partial payment has been received for this invoice. Please find the details below.";
                        }
                        else
                        {
                            statusColor = "#c63e3b"; // Red
                            invoiceStatusText = "Please find the attached invoice for your recent account sale.";
                        }

                        msg.Subject = $"Trade Invoice #{txtReceiptNo.Text} - {Settings.Company}";
                        msg.IsBodyHtml = true;
                        msg.Body = $@"
                                    <div style='font-family: Arial, sans-serif; color: #333; line-height: 1.6;'>
                                        <h2 style='color: #374151;'>Hello {txtCompany.Text},</h2>
                                        <p>Thank you for your business. {invoiceStatusText}</p>

                                        <div style='background-color: #f9fafb; padding: 15px; border-radius: 5px; width: 60%; border: 1px solid #e5e7eb; margin-top:15px; margin-bottom: 20px;'>
                                            <table style='border-collapse: collapse; width: 100%;'>
                                                <tr><td style='padding: 5px 0;'><b>Invoice #:</b></td><td style='text-align: right;'>{txtReceiptNo.Text}</td></tr>
                                                <tr><td style='padding: 5px 0;'><b>Invoice Date:</b></td><td style='text-align: right;'>{txtInvoiceDate.Text}</td></tr>
                                                <tr><td style='padding: 5px 0;'><b>Due Date:</b></td><td style='text-align: right;'>{txtDueDate.Text}</td></tr>
                                                <tr><td style='padding: 5px 0;'><b>Total Amount:</b></td><td style='text-align: right;'>{txtTotal.Text}</td></tr>
                                                <tr><td style='padding: 5px 0;'><b>Amount Paid:</b></td><td style='text-align: right;'>{txtAmountPaid.Text}</td></tr>
                                                <tr><td style='padding: 5px 0;'><b>Balance Due:</b></td><td style='text-align: right; font-weight: bold;'>{txtBalanceDue.Text}</td></tr>
                                                <tr><td style='padding: 5px 0; border-top: 1px solid #ddd;'><b>Status:</b></td><td style='text-align: right; font-weight: bold; color: {statusColor}; border-top: 1px solid #ddd;'>{txtInvoiceStatus.Text}</td></tr>
                                            </table>
                                        </div>

                                        <p>If you have any questions regarding this invoice, please feel free to contact us.</p>
                                        <br/>
                                        <p>Best Regards,<br/><b>{Settings.Company}</b></p>
                                    </div>";

                        Attachment attachment = new Attachment(pdfFilePath);
                        attachment.Name = pdfFileName;
                        msg.Attachments.Add(attachment);
                        smtp.Send(msg);
                    }
                }
                try { File.Delete(xpsFilePath); } catch { }
                try { File.Delete(pdfFilePath); } catch { }
                return true;
            }
            catch (Exception ex)
            {
                GeneralFunctions.SetTransactionLog("Trade Invoice Email Error", ex.Message);
                throw ex;
            }
        }
    }
}
