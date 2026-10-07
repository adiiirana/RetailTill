using DevExpress.Xpf.Editors;
using DevExpress.Xpf.Grid.LookUp;
using OfflineRetailV2.Data; // Keeping your original namespace for Data Objects
using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Interop;
using System.Windows.Media;
using System.Windows.Threading;

namespace OfflineRetailV2.UserControls.POSSection
{
    public partial class AddProductWindow2 : Window
    {
        // Variables from reference logic
        public int NewItemID { get; private set; } = 0;
        public int EditingItemID { get; set; } = 0; // 0 = New, >0 = Edit
        private int DefaultProductTypeID = -1;
        private bool _isClosing = false;
        public int PreselectedCategoryID { get; set; }
        // Keyboards
        FullKeyboard fkybrd;
        bool IsAboutFullKybrdOpen = false;

        public AddProductWindow2()
        {
            InitializeComponent();

            // Wire up Close Command for the ModalWindow control
            if (ModalWindow != null)
            {
                ModalWindow.CloseCommand = new CommandBase(OnCloseCommandExecute);
            }

            this.Loaded += Window_Loaded;
        }

        private void OnCloseCommandExecute(object obj)
        {
            _isClosing = true;
            CloseKeyboards();

            // Setting this property AUTOMATICALLY calls this.Close()
            if (ComponentDispatcher.IsThreadModal) // Safe check
            {
                this.DialogResult = false;
            }
            else
            {
                this.Close();
            }
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            // 1. Apply ATM-Style Currency Mask
            //MessageBox.Show("B: Window_Loaded Start - PreselectedCategoryID: " + PreselectedCategoryID);
            txtPrice.MaskType = MaskType.Numeric;
            string cSymbol = SystemVariables.CurrencySymbol;
            txtPrice.Mask = $"{cSymbol} #,##0.00";
            txtPrice.MaskUseAsDisplayFormat = true;
            txtPrice.EditValue = 0m;

            // 2. Populate Data
            PopulateProductType();
            PopulateCategory();
            DeptLookup();

            if (EditingItemID > 0)
            {
                LoadItemForEdit(EditingItemID);
                btnOK.Content = "UPDATE ITEM";
            }
            else // New Item Block
            {
                cmbProductType.SelectedIndex = 0;
                chkActive.IsChecked = true;

                if (PreselectedCategoryID != 0 && GeneralFunctions.fnInt32(PreselectedCategoryID.ToString()) > 0)
                {
                    Dispatcher.BeginInvoke(new Action(() =>
                    {
                        // Re-affirming the selection once the UI is fully rendered
                        int targetID = GeneralFunctions.fnInt32(PreselectedCategoryID.ToString());
                        DataTable dt = cmbCategory.ItemsSource as DataTable;
                        if (dt != null)
                        {
                            var targetRow = dt.AsEnumerable()
                                .FirstOrDefault(r => GeneralFunctions.fnInt32(r["ID"].ToString()) == targetID);

                            if (targetRow != null)
                            {
                                cmbCategory.EditValue = targetRow["ID"];
                            }
                        }
                    }), DispatcherPriority.Background);
                }

                txtSKU.IsEnabled = false;
                txtSKU.Text = "Auto-Generated";
            }

            // 4. Ensure Visual Tree is loaded for Popup Widths
            Dispatcher.BeginInvoke(new Action(() =>
            {
                if (cmbCategory != null) cmbCategory.PopupWidth = cmbCategory.ActualWidth;
            }), DispatcherPriority.Render);
        }

        #region Data Population & Loading

        private void PopulateProductType()
        {
            // Using logic from reference to fetch default ID, but keeping simple population
            try
            {
                // If you have a specific table for types, fetch it here. 
                // Otherwise, we default to ID -1 logic from reference.
                DefaultProductTypeID = 1; // Fallback
            }
            catch (Exception ex)
            {
                DocMessage.MsgInformation("Error loading product types: " + ex.Message);
            }
        }

        public void PopulateCategory()
        {
            try
            {
                PosDataObject.Category objCategory = new PosDataObject.Category();
                objCategory.Connection = SystemVariables.Conn;
                DataTable dbtblCat = objCategory.FetchLookupData();

                cmbCategory.ItemsSource = dbtblCat;
                cmbCategory.ValueMember = "ID";
                cmbCategory.DisplayMember = "Description";

                // Handle pre-selection immediately after data is bound
                if (EditingItemID == 0 && PreselectedCategoryID != 0)
                {
                    int targetID = GeneralFunctions.fnInt32(PreselectedCategoryID.ToString());
                    if (targetID > 0)
                    {
                        // Force search in the DataTable to match the specific internal type
                        foreach (DataRow dr in dbtblCat.Rows)
                        {
                            if (GeneralFunctions.fnInt32(dr["ID"].ToString()) == targetID)
                            {
                                // Set the EditValue to the EXACT object from the row to ensure type match
                                cmbCategory.EditValue = dr["ID"];
                                break;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                DocMessage.MsgInformation("Error loading categories: " + ex.Message);
            }
        }


        public void DeptLookup()
        {
            try
            {
                PosDataObject.Department objDepartment = new PosDataObject.Department();
                objDepartment.Connection = SystemVariables.Conn;
                DataTable dbtblDept = objDepartment.FetchLookupData();

                cmbDept.ItemsSource = dbtblDept;
                cmbDept.DisplayMember = "Description";
                cmbDept.ValueMember = "ID";

                if (dbtblDept.Rows.Count > 0) cmbDept.EditValue = dbtblDept.Rows[0]["ID"];
            }
            catch (Exception ex)
            {
                DocMessage.MsgInformation("Error loading departments: " + ex.Message);
            }
        }

        private void LoadItemForEdit(int id)
        {
            try
            {
                PosDataObject.Product objProduct = new PosDataObject.Product();
                objProduct.Connection = SystemVariables.Conn;
                DataTable dbtbl = objProduct.ShowRecord(id);

                if (dbtbl.Rows.Count > 0)
                {
                    DataRow dr = dbtbl.Rows[0];
                    txtSKU.Text = dr["SKU"].ToString();
                    txtDesc.Text = dr["Description"].ToString();

                    decimal price = 0;
                    decimal.TryParse(dr["PriceA"].ToString(), out price);
                    txtPrice.EditValue = price;

                    cmbCategory.EditValue = dr["CategoryID"];
                    cmbDept.EditValue = dr["DepartmentID"];

                    chkPOSScreen.IsChecked = dr["AddtoPOSScreen"].ToString() == "Y";
                    chkPOSCatScreen.IsChecked = dr["AddToPOSCategoryScreen"].ToString() == "Y";
                    chkActive.IsChecked = dr["ProductStatus"].ToString() == "Y";
                }
            }
            catch (Exception ex)
            {
                DocMessage.MsgInformation("Error loading item: " + ex.Message);
            }
        }

        #endregion

        #region Keypad Logic (ATM Style - Ported from Reference)

        private void KeypadBtn_Click(object sender, RoutedEventArgs e)
        {
            var btn = sender as Button;
            if (btn == null || btn.Tag == null) return;

            string input = btn.Tag.ToString();

            // Ignore dot for ATM style logic (Fixed point)
            if (input == ".") return;

            // 1. Get current value
            decimal currentVal = 0;
            if (txtPrice.EditValue != null)
            {
                decimal.TryParse(txtPrice.EditValue.ToString(), out currentVal);
            }

            // 2. Calculate New Value: (Current * 10) + (Input / 100)
            // Example: 1.00 -> Press 5 -> 10.05
            decimal digit = decimal.Parse(input);
            decimal newVal = (currentVal * 10m) + (digit / 100m);

            // 3. Update Control
            txtPrice.EditValue = newVal;

            // 4. Ensure focus, move caret to end, and CLEAR SELECTION
            RefocusPriceField();
        }

        private void KeypadBack_Click(object sender, RoutedEventArgs e)
        {
            decimal currentVal = 0;
            if (txtPrice.EditValue != null)
            {
                decimal.TryParse(txtPrice.EditValue.ToString(), out currentVal);
            }

            // Formula: Floor(Current * 10) / 100
            // Example: 10.55 -> 1.05
            decimal newVal = Math.Floor(currentVal * 10m) / 100m;

            txtPrice.EditValue = newVal;

            RefocusPriceField();
        }

        private void RefocusPriceField()
        {
            txtPrice.Focus();
            Dispatcher.BeginInvoke(new Action(() =>
            {
                txtPrice.SelectionStart = txtPrice.Text.Length;
                txtPrice.SelectionLength = 0;
            }), DispatcherPriority.Input);
        }

        #endregion

        #region Virtual Keyboard Logic

        private void CloseKeyboards()
        {
            if (fkybrd != null)
            {
                fkybrd.Close();
                fkybrd = null;
                IsAboutFullKybrdOpen = false;
            }
        }

        private void Full_GotFocus(object sender, RoutedEventArgs e)
        {
            if (Settings.UseTouchKeyboardInPOS == "N") return; // Assumes Settings exists

            var editor = sender as TextEdit;

            // Prevent keyboard for Price field (Handled by on-screen keypad)
            if (editor != null && editor.Name == "txtPrice")
            {
                CloseKeyboards();
                return;
            }

            CloseKeyboards();

            if (!IsAboutFullKybrdOpen)
            {
                fkybrd = new FullKeyboard();

                // Flush to bottom of Primary Screen
                double screenWidth = SystemParameters.PrimaryScreenWidth;
                double screenHeight = SystemParameters.PrimaryScreenHeight;

                fkybrd.Width = screenWidth;
                fkybrd.Height = 320;
                fkybrd.Left = 0;
                fkybrd.Top = screenHeight - fkybrd.Height;
                fkybrd.Topmost = true;

                fkybrd.IsWindow = true;
                fkybrd.calledform = this;
                fkybrd.Closing += FKybrd_Closing;
                fkybrd.Show();
                IsAboutFullKybrdOpen = true;
            }
        }

        private void FKybrd_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (!IsAboutFullKybrdOpen) e.Cancel = true;
            else
            {
                IsAboutFullKybrdOpen = false;
                e.Cancel = false;
            }
        }

        private void Full_LostFocus(object sender, RoutedEventArgs e)
        {
            // Optional: Close keyboard on lost focus, or keep open until explicit close
            // CloseKeyboards(); 
        }

        #endregion

        #region SKU Generation (Ported Logic)

        private string GenerateSKUFromName(string productName)
        {
            try
            {
                // 1. Clean the name
                string cleanName = productName.ToUpper().Trim().Replace(" ", "");
                if (cleanName.Length > 12) cleanName = cleanName.Substring(0, 12);

                string finalSKU = cleanName;
                int counter = 1;

                // 2. Setup duplicate checker
                PosDataObject.Product objProduct = new PosDataObject.Product();
                objProduct.Connection = SystemVariables.Conn;

                // 3. Loop until unique
                while (objProduct.DuplicateCount(finalSKU) > 0)
                {
                    finalSKU = $"{cleanName}-{counter}";
                    counter++;
                }

                return finalSKU;
            }
            catch
            {
                return DateTime.Now.ToString("yyMMddHHmm");
            }
        }

        #endregion

        #region Save & Validation

        private bool ValidateData()
        {
            if (string.IsNullOrWhiteSpace(txtDesc.Text))
            {
                DocMessage.MsgEnter("Item Name");
                txtDesc.Focus();
                return false;
            }

            if (cmbCategory.EditValue == null)
            {
                DocMessage.MsgEnter("Category");

                // Open popup to help user
                cmbCategory.Focus();
                Dispatcher.BeginInvoke(new Action(() => { cmbCategory.IsPopupOpen = true; }), DispatcherPriority.Input);

                return false;
            }

            return true;
        }

        private bool SaveData()
        {
            try
            {
                PosDataObject.Product objProduct = new PosDataObject.Product();
                objProduct.Connection = SystemVariables.Conn;
                objProduct.LoginUserID = SystemVariables.CurrentUserID;
                objProduct.TerminalName = Settings.TerminalName;
                objProduct.ID = EditingItemID;

                // --- Basic Identification & Alt SKUs ---
                string finalSKU = (EditingItemID == 0) ? GenerateSKUFromName(txtDesc.Text) : txtSKU.Text;
                objProduct.SKU = finalSKU;
                objProduct.UPC = "";
                objProduct.SKU2 = "";
                objProduct.SKU3 = "";
                objProduct.CaseUPC = "";
                objProduct.Description = txtDesc.Text.Trim();
                objProduct.BinLocation = ""; // Fixed @BinLocation error
                objProduct.PrimaryVendorID = "";
                objProduct.BookingExpFlag = "N";

                // --- Product Type & Unit of Measure ---
                int pTypeIdx = cmbProductType.SelectedIndex;
                
                objProduct.ProductType = "P";

                // Fixed @UOM error: Must be an empty string if not used
                objProduct.UOM = (objProduct.ProductType == "W") ? "LB" : "";
                objProduct.Tare = 0;
                objProduct.Tare2 = 0;
                objProduct.SplitWeight = 0;

                // --- Classifications ---
                objProduct.CategoryID = GeneralFunctions.fnInt32(cmbCategory.EditValue?.ToString() ?? "0");
                objProduct.DepartmentID = GeneralFunctions.fnInt32(cmbDept.EditValue?.ToString() ?? "0");
                objProduct.BrandID = 0;

                // --- Pricing, Cost, & Toggles ---
                double dblPrice = 0;
                if (txtPrice.EditValue != null) double.TryParse(txtPrice.EditValue.ToString(), out dblPrice);

                objProduct.PriceA = dblPrice;
                objProduct.PriceB = 0;
                objProduct.PriceC = 0;
                objProduct.PrevPriceA = 0;
                objProduct.Cost = 0;
                objProduct.DiscountedCost = 0;
                objProduct.LastCost = 0;
                objProduct.Points = 0;
                objProduct.MinimumAge = 0;

                objProduct.ProductStatus = (chkActive.IsChecked == true) ? "Y" : "N";
                objProduct.AddtoPOSScreen = (chkPOSScreen.IsChecked == true) ? "Y" : "N";
                objProduct.AddtoPOSCategoryScreen = (chkPOSCatScreen.IsChecked == true) ? "Y" : "N";
                objProduct.PromptForPrice = "N";
                objProduct.ScaleBarCode = "N";
                objProduct.FoodStampEligible = "N";
                objProduct.PrintBarCode = "Y";
                objProduct.NoPriceOnLabel = "N";
                objProduct.AllowZeroStock = "Y";
                objProduct.DisplayStockinPOS = "Y";
                objProduct.TaggedInInvoice = "N";
                objProduct.NonDiscountable = "N";
                objProduct.AddtoScaleScreen = "N";

                // --- Notes & Metadata ---
                objProduct.ProductNotes = "";
                objProduct.Notes2 = "";
                objProduct.Season = "";
                objProduct.CaseQty = 1;
                objProduct.ProductDecimalPlace = 2;
                objProduct.ExpiryDate = Convert.ToDateTime(null);
                objProduct.LabelType = -1;
                objProduct.QtyToPrint = 0;
                objProduct.PrintLabelQty = 0;

                // --- Rental & Repair ---
                objProduct.RentalPerMinute = 0; objProduct.RentalPerHour = 0; objProduct.RentalPerHalfDay = 0;
                objProduct.RentalPerDay = 0; objProduct.RentalPerWeek = 0; objProduct.RentalPerMonth = 0;
                objProduct.RentalDeposit = 0; objProduct.RentalPrompt = "N"; objProduct.RentalMinHour = 0;
                objProduct.RentalMinAmount = 0; objProduct.RepairCharge = 0; objProduct.RepairPromptForCharge = "N";
                objProduct.RepairPromptForTag = "N"; objProduct.MinimumServiceTime = 0;

                // --- Inventory Management ---
                objProduct.QtyOnHand = 0;
                objProduct.ReorderQty = 0;
                objProduct.NormalQty = 0;
                objProduct.QtyOnLayaway = 0;
                objProduct.AddJournal = false;
                objProduct.ChangeInventory = false;
                objProduct.IsNewCategory = (EditingItemID == 0);
                objProduct.ChangeProductType = "";

                // --- UI Styles (Crucial for DB Insert) ---
                objProduct.POSBackground = "Color";
                objProduct.POSScreenColor = "";
                objProduct.POSScreenStyle = "";
                objProduct.POSFontType = "Tahoma";
                objProduct.POSFontSize = 9;
                objProduct.POSFontColor = "#000000";
                objProduct.IsBold = "N";
                objProduct.IsItalics = "N";

                objProduct.ScaleBackground = "Skin";
                objProduct.ScaleScreenColor = "0";
                objProduct.ScaleScreenStyle = "DevExpress Skin";
                objProduct.ScaleFontType = "Arial";
                objProduct.ScaleFontSize = 8;
                objProduct.ScaleFontColor = "0";
                objProduct.ScaleIsBold = "N";
                objProduct.ScaleIsItalics = "N";

                // --- DataTables & Photos ---
                objProduct.TaxDataTable = CreateEmptyTaxTable();
                objProduct.VendorDataTable = null;
                objProduct.PrinterDataTable = null;
                objProduct.RentTaxDataTable = null;
                objProduct.RepairTaxDataTable = null;
                objProduct.ProductPhoto = null;
                objProduct.PhotoFilePath = "";
                objProduct.ShopifyImageExportFlag = "N";
                objProduct.LinkSKU = 0;
                objProduct.BreakPackRatio = 0;
                AppEvents.RaisePOSButtonsReloadRequested();
                // --- Final Execution ---
                string strError = objProduct.PostData_WPF();
                if (string.IsNullOrEmpty(strError))
                {
                    NewItemID = objProduct.ID;
                    return true;
                }
                else
                {
                    DocMessage.MsgInformation("Error saving item: " + strError);
                    return false;
                }
            }
            catch (Exception ex)
            {
                DocMessage.MsgInformation("System Error: " + ex.Message);
                return false;
            }
        }

        private DataTable CreateEmptyTaxTable()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("ID", typeof(int));
            dt.Columns.Add("TaxName", typeof(string));
            dt.Columns.Add("TaxRate", typeof(double));
            return dt;
        }

        

        private void btnOK_Click(object sender, RoutedEventArgs e)
        {
            if (ValidateData())
            {
                if (SaveData())
                {
                    // Reload POS buttons if needed
                    if (chkPOSCatScreen.IsChecked == true)
                    {
                        AppEvents.RaisePOSButtonsReloadRequested();
                    }

                    this.DialogResult = true;
                    CloseKeyboards();
                    this.Close();
                }
            }
        }

        private void btnCancel_Click(object sender, RoutedEventArgs e)
        {
            _isClosing = true;
            CloseKeyboards();
            //this.DialogResult = false;
            this.Close();
        }

        #endregion

        #region UI Event Handlers (Popups & Category Add)

        private void CmbCategory_PreviewMouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            var editor = sender as LookUpEditBase;
            if (editor != null)
            {
                editor.IsPopupOpen = true;
                editor.ShowPopup();
                e.Handled = true;
            }
        }

        private void addCategorybtn_click(object sender, RoutedEventArgs e)
        {
            try
            {
                this.Hide();

                // Assuming frm_CategoryDlg2 exists in OfflineRetailV2 namespace
                frm_CategoryDlg2 catDlg = new frm_CategoryDlg2();
                catDlg.ShowDialog();

                this.Show();
                PopulateCategory();

                // Auto-select new category (Max ID)
                DataTable dt = cmbCategory.ItemsSource as DataTable;
                if (dt != null && dt.Rows.Count > 0)
                {
                    DataRow maxRow = dt.AsEnumerable()
                        .OrderByDescending(r => GeneralFunctions.fnInt32(r["ID"].ToString()))
                        .FirstOrDefault();

                    if (maxRow != null) cmbCategory.EditValue = maxRow["ID"];
                }
            }
            catch (Exception ex)
            {
                this.Show();
                DocMessage.MsgInformation($"Error opening category form: {ex.Message}");
            }
        }

        private void btnInfoMainScreen_Click(object sender, RoutedEventArgs e)
        {
            popupHotKey.IsOpen = true;
        }

        private void btnInfoCategory_Click(object sender, RoutedEventArgs e)
        {
            popupCategory.IsOpen = true;
        }

        private void btnAdvance_Click(object sender, RoutedEventArgs e)
        {
          
        }

        #endregion

        private void btnOK_Click_1(object sender, RoutedEventArgs e)
        {
            if (ValidateData())
            {
                if (SaveData())
                {
                    if (chkPOSCatScreen.IsChecked == true)
                    {
                        AppEvents.RaisePOSButtonsReloadRequested();
                    }

                    CloseKeyboards();

                    // Check if the window was opened with ShowDialog()
                    if (ComponentDispatcher.IsThreadModal)
                    {
                        this.DialogResult = true; // This will close the window automatically
                    }
                    else
                    {
                        this.Close(); // Use this if the window was opened with .Show()
                    }
                }
            }
        }

        private void btnCancel_Click_1(object sender, RoutedEventArgs e)
        {
            _isClosing = true;
            CloseKeyboards();

            if (ComponentDispatcher.IsThreadModal)
            {
                this.DialogResult = false;
            }
            else
            {
                this.Close();
            }
        }
        private void btnAdvance_Click_1(object sender, RoutedEventArgs e)
        {
            try
            {
                AddProductWindow advWindow = new AddProductWindow();
                advWindow.ID = this.EditingItemID;

                // --- Data Passing (Existing Logic) ---
                if (!string.IsNullOrEmpty(txtDesc.Text)) advWindow.txtDesc.Text = txtDesc.Text;
                if (!string.IsNullOrEmpty(txtSKU.Text) && txtSKU.Text != "Auto-Generated") advWindow.txtSKU.Text = txtSKU.Text;
                if (cmbCategory.EditValue != null) advWindow.cmbCategory.EditValue = cmbCategory.EditValue;
                if (cmbDept.EditValue != null) advWindow.cmbDept.EditValue = cmbDept.EditValue;
                advWindow.chkPOSScreen.IsChecked = chkPOSScreen.IsChecked;
                advWindow.chkPOSCatScreen.IsChecked = chkPOSCatScreen.IsChecked;
                // --- Pass Price to specific numeric controls ---
                if (txtPrice.EditValue != null)
                {
                    advWindow.numPriceA.EditValue = txtPrice.EditValue;
                    advWindow.numDcost.EditValue = txtPrice.EditValue; // Setting cost to same as price per your request
                }

                // Hide current window to transition smoothly
                this.Hide();
                CloseKeyboards();

                // Show Advanced Window as a Dialog
                advWindow.ShowDialog();

                // --- Logic after Advanced Window Closes ---
                if (advWindow.IsSaved)
                {
                    // The user clicked SAVE in the Advanced Window
                    this.NewItemID = advWindow.ID;

                    // FIX: Don't set DialogResult here. 
                    // Instead, set boolPostData and close directly.
                    //this.boolPostData = true;

                    // Re-show briefly if needed to maintain window hierarchy, or just close
                    //this.Show();
                    this.Close();
                }
                else
                {
                    // The user clicked CANCEL, so bring this one back
                    this.Show();
                }
            }
            catch (Exception ex)
            {
                this.Show();
                DocMessage.MsgInformation("Error switching to advanced view: " + ex.Message);
            }
        }
    }
}