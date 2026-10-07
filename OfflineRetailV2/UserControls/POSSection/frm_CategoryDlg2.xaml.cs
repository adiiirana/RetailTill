using DevExpress.Xpf.Editors; // Required for handling DevExpress controls like ToggleSwitch
using OfflineRetailV2.Data; // Assuming this namespace contains your data objects and helpers
using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows;
using System.Windows.Forms; // Required for Screen.AllScreens
using System.Drawing;       // For Rectangle type
using System.Windows.Input;

namespace OfflineRetailV2.UserControls.POSSection
{
    /// <summary>
    /// Interaction logic for frm_CategoryDlg.xaml
    /// </summary>
    public partial class frm_CategoryDlg2 : Window
    {
        // --- Fields and Properties to keep ---
        private int intID;
        private int intNewID;
        private bool boolControlChanged;
        private bool blDataSaved = false;
        public int PreselectedCategoryID { get; set; }
        public event Action OnDataSaved;

        private bool blOnScreenCall = false; // Kept for Save logic context

        // Fields for keyboard logic (kept for compatibility with remaining KB methods)
        NumKeyboard nkybrd;
        bool IsAboutNumKybrdOpen = false;

        FullKeyboard fkybrd;
        bool IsAboutFullKybrdOpen = false;

        // Kept properties for external access (essential for dialog operation)
        public bool DataSaved
        {
            get { return blDataSaved; }
            set { blDataSaved = value; }
        }

        public bool OnScreenCall
        {
            get { return blOnScreenCall; }
            set { blOnScreenCall = value; }
        }

        public int ID
        {
            get { return intID; }
            set { intID = value; }
        }
        public int NewID
        {
            get { return intNewID; }
            set { intNewID = value; }
        }

        // The BrowseForm property is kept in case it's used elsewhere, but its setter/getter is minimal.
        private frm_CategoryBrwUC frmBrowse;
        public frm_CategoryBrwUC BrowseForm
        {
            get
            {
                if (frmBrowse == null)
                    frmBrowse = new frm_CategoryBrwUC();
                return frmBrowse;
            }
            set
            {
                frmBrowse = value;
            }
        }


        // --- Constructor and General Methods ---
        public frm_CategoryDlg2()
        {
            InitializeComponent();
            // Assuming ModalWindow.CloseCommand is still used for the close button/esc key
            // NOTE: This requires 'CommandBase' to be defined and 'ModalWindow' to be the name in XAML
             ModalWindow.CloseCommand = new CommandBase(OnCloseCOmmand);
        }

        private void OnCloseCOmmand(object obj)
        {
            //CloseKeyboards() call removed as keyboards logic is removed
            Close();
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (boolControlChanged)
            {
                //MessageBoxResult DlgResult = new MessageBoxResult();
                // Using a minimal MessageBox call, assuming DocMessage.MsgConfirmation is removed/replaced
                //DlgResult = DocMessage.MsgInformation(Properties.Resources.strSaveChanges);

                
                    if (IsValidAll())
                    {
                        if (SaveData())
                        {
                            // Removed logic related to boolControlChangedItem (product-level updates)
                            boolControlChanged = false;
                            if (!blOnScreenCall) BrowseForm.FetchData();
                        }
                        else
                            e.Cancel = true;
                    }
                    else
                        e.Cancel = true;
                

                
            }
        }

        // --- Validation, Data Load, and Save Logic ---

        private int DuplicateCount()
        {
            PosDataObject.Category objCategory = new PosDataObject.Category();
            objCategory.Connection = SystemVariables.Conn;
            return objCategory.DuplicateCount(txtID.Text.Trim());
        }
        private async void Num_GotFocus(object sender, RoutedEventArgs e)
        {
            if (Settings.UseTouchKeyboardInPOS == "N") return;
            CloseKeyboards();

            // Select all text after focusing (for numeric fields)
            Dispatcher.BeginInvoke(new Action(() =>
                (sender as DevExpress.Xpf.Editors.TextEdit)?.SelectAll()));

            if (!IsAboutNumKybrdOpen)
            {
                nkybrd = new NumKeyboard
                {
                    Height = 270,
                    Width = 385,
                    IsWindow = true,
                    CalledForm = this,
                    Topmost = true,
                    ShowInTaskbar = false,
                    WindowStartupLocation = WindowStartupLocation.Manual
                };

                // Show the window first (so it has a valid handle and layout)
                nkybrd.Show();

                // Force layout update before positioning
                await nkybrd.Dispatcher.InvokeAsync(() => nkybrd.UpdateLayout());

                // --- Detect your main POS window (POSControl) ---
                // Find the parent window that contains the POSControl user control
                Window parentWindow = Window.GetWindow(System.Windows.Application.Current.MainWindow);
                if (parentWindow == null)
                    parentWindow = System.Windows.Application.Current.MainWindow;


                // --- Compute correct working area ---
                if (parentWindow != null)
                {
                    // Use your existing DPI-aware helper
                    Rect workArea = OfflineRetailV2.Data.ScreenHelper.GetWorkAreaForWindow(parentWindow);

                    // Center horizontally and bottom align (10px above taskbar)
                    nkybrd.Left = workArea.Left + (workArea.Width - nkybrd.Width) / 2;
                    nkybrd.Top = workArea.Bottom - nkybrd.Height - 10;
                }
                else
                {
                    // Fallback to primary monitor if all else fails
                    Rect fallback = OfflineRetailV2.Data.ScreenHelper.GetWorkAreaForWindow(this);
                    nkybrd.Left = fallback.Left + (fallback.Width - nkybrd.Width) / 2;
                    nkybrd.Top = fallback.Bottom - nkybrd.Height - 10;
                }

                nkybrd.Closing += NKybrd_Closing;
                IsAboutNumKybrdOpen = true;
            }
        }
        private void NKybrd_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (!IsAboutNumKybrdOpen)
            {
                e.Cancel = true;
            }
            else
            {
                IsAboutNumKybrdOpen = false;
                e.Cancel = false;
            }
        }

        private void Num_LostFocus(object sender, RoutedEventArgs e)
        {
            CloseKeyboards();
        }

        private bool IsValidAll()
        {
            //if (txtID.Text.Trim() == "")
            //{
            //    // Replaced DocMessage call with simple MessageBox, assuming Properties.Resources is still available
            //    DocMessage.MsgInformation((Properties.Resources.Category_ID));
            //    // GeneralFunctions.SetFocus(txtID); // SetFocus call removed
            //    return false;
            //}

            //if (intID == 0)
            //{
            //    if (DuplicateCount() == 1)
            //    {
            //        DocMessage.MsgInformation(Properties.Resources.Duplicate_Category_ID);
            //        // GeneralFunctions.SetFocus(txtID); // SetFocus call removed
            //        return false;
            //    }
            //}

            if (txtDescription.Text.Trim() == "")
            {
                DocMessage.MsgInformation(Properties.Resources.Category_Description);
                // GeneralFunctions.SetFocus(txtDescription); // SetFocus call removed
                return false;
            }

            // Removed validation for txtDisplayOrder and txtProducts as those fields were removed from XAML

            return true;
        }

        private void CloseKeyboards()
        {
            if (fkybrd != null)
            {
                fkybrd.Close();
            }
            if (nkybrd != null)
            {
                nkybrd.Close();
            }
        }
        private void Full_LostFocus(object sender, RoutedEventArgs e)
        {
            CloseKeyboards();
        }

        private void Full_GotFocus(object sender, RoutedEventArgs e)
        {
            if (Settings.UseTouchKeyboardInPOS == "N") return;
            CloseKeyboards();

            if (!IsAboutFullKybrdOpen)
            {
                fkybrd = new FullKeyboard
                {
                    Height = 320,
                    Width = 800,
                    IsWindow = true,
                    calledform = this,
                    Owner = System.Windows.Application.Current.MainWindow, // Optional
                    Topmost = true,
                    ShowInTaskbar = false,
                    WindowStartupLocation = WindowStartupLocation.Manual
                };

                // --- Detect main POS screen (POSControl) ---
                Window posMain = null;
                foreach (Window win in System.Windows.Application.Current.Windows)
                {
                    if (win is POSControl)
                    {
                        posMain = win;
                        break;
                    }
                }

                if (posMain != null)
                {
                    // Get the working area (monitor that contains POSControl)
                    Rect workArea = ScreenHelper.GetWorkAreaForWindow(posMain);

                    // Position keyboard centered horizontally, bottom-aligned
                    fkybrd.Left = workArea.Left + (workArea.Width - fkybrd.Width) / 2;
                    fkybrd.Top = workArea.Bottom - fkybrd.Height - 10; // 10px above taskbar
                }
                else
                {
                    // Fallback: use primary monitor
                    var primary = ScreenHelper.GetWorkAreaForWindow(System.Windows.Application.Current.MainWindow ?? this);
                    fkybrd.Left = primary.Left + (primary.Width - fkybrd.Width) / 2;
                    fkybrd.Top = primary.Bottom - fkybrd.Height - 10;
                }

                fkybrd.Closing += FKybrd_Closing;
                fkybrd.Show();
                IsAboutFullKybrdOpen = true;
            }
        }



        private void FKybrd_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (!IsAboutFullKybrdOpen)
            {
                e.Cancel = true;
            }
            else
            {
                IsAboutFullKybrdOpen = false;
                e.Cancel = false;
            }
        }

        // --- UPDATED SaveData with Food Stamp Logic ---
        // Paste this entire function into your frm_CategoryDlg2.xaml.cs, replacing the old SaveData()
        private bool SaveData()
        {
            // --- Logging Start (Keep for debug purposes) ---
            //MessageBox.Show("1. Starting SaveData(). ID: " + intID, "Save Debug", MessageBoxButton.OK, MessageBoxImage.Information);

            string strError = "";
            PosDataObject.Category objCategory = new PosDataObject.Category();
            objCategory.Connection = SystemVariables.Conn;
            objCategory.LoginUserID = SystemVariables.CurrentUserID;

            // --- Core Fields (Present in UI) ---
            objCategory.GeneralCode = txtID.Text.Trim();
            objCategory.GeneralDesc = txtDescription.Text.Trim();
            objCategory.ID = intID;

            // Parent Category
            objCategory.ParentCategory = cmbParentCategory.EditValue == null ? 0 : GeneralFunctions.fnInt32(cmbParentCategory.EditValue.ToString());
            objCategory.ParentCategoryLevel = GetParentCategoryLevel();

            // Active Status (chkActive)
            if (chkActive.IsChecked == true)
            {
                objCategory.ProductStatus = "Y";
            }
            else
            {
                objCategory.ProductStatus = "N";
            }

            // Food Stamp Eligibility (chkFoodStampEligible - Added in XAML)
            // This handles the previously missing @FoodStampEligible parameter, and related properties.
            string foodStampStatus = "N";

            //objCategory.FoodStamp = foodStampStatus;
            objCategory.FoodStamp= foodStampStatus;
            objCategory.FoodStampEligibleForProduct = foodStampStatus;

            // --- Default Values for Removed UI Fields (REQUIRED to avoid missing parameter errors) ---
            // The previous errors were for @FoodStampEligible (now fixed) and @POSScreenColor (fixed below)

            // POS Style/Color Fields (Default to "Color" mode with transparent color/no style)
            objCategory.POSBackground = "Color";
            objCategory.POSScreenColor = "#00000000";       // Equivalent to txtColor.Color.ToString() if blank/default
            objCategory.POSScreenStyle = "";
            objCategory.POSFontType = "";
            objCategory.POSFontSize = 0;
            objCategory.POSFontColor = "#00000000";
            objCategory.POSItemFontColor = "#00000000";

            // Display Order & Max Items (Default to 0)
            objCategory.PosDisplayOrder = 20;
            objCategory.MaxItemsforPOS = 10;

            // Font Styles (Default to N)
            objCategory.IsBold = "N";
            objCategory.IsItalics = "N";

            // Checkbox Flags (Default to N)
            objCategory.AddToPOSScreen = "Y";
            objCategory.ScaleBarCode = "N";
            objCategory.PrintBarCode = "N";
            objCategory.NoPriceOnLabel = "N";
            objCategory.AllowZeroStock = "N";
            objCategory.DisplayStockinPOS = "Y";
            objCategory.NonDiscountable = "N";
            objCategory.RepairPromptForTag = "N";

            //objCategory.;

            // Numerical/Selection Fields (Default to 0 or -1)
            objCategory.LabelType = -1;
            objCategory.MinimumAge = 0;
            objCategory.QtyToPrint = 0;

            strError = objCategory.PostData();
            intNewID = objCategory.ID;
            AppEvents.RaisePOSButtonsReloadRequested();
            //MessageBox.Show("3. PostData() returned. Error: '" + strError + "'. New ID: " + intNewID, "Save Debug", MessageBoxButton.OK, MessageBoxImage.Information);

            if (strError == "")
            {
                blDataSaved = true;
                //MessageBox.Show("4. Save successful! Returning true.", "Save Debug", MessageBoxButton.OK, MessageBoxImage.Information);
                return true;
            }
            else
            {
                //MessageBox.Show("5. Save failed! Error message: " + strError, "Save Debug - ERROR", MessageBoxButton.OK, MessageBoxImage.Error);
                return false;
            }
        }

        // --- UPDATED ShowData with Food Stamp Logic ---
        private void ShowData()
        {
            PosDataObject.Category objCategory = new PosDataObject.Category();
            objCategory.Connection = SystemVariables.Conn;
            DataTable dbtbl = objCategory.ShowRecord(intID);

            foreach (DataRow dr in dbtbl.Rows)
            {
                txtID.Text = dr["CategoryID"].ToString();
                txtDescription.Text = dr["Description"].ToString();

                // Only load ParentCategory
                cmbParentCategory.EditValue = GeneralFunctions.fnInt32(dr["ParentCategory"].ToString());
                if (dr["ProductStatus"].ToString() == "Y")
                {
                    chkActive.IsChecked = true;
                }
                else
                {
                    chkActive.IsChecked = false;
                }

                // Removed: All other fields loading
            }
        }

        private int GetParentCategoryLevel()
        {
            PosDataObject.Category objCategory = new PosDataObject.Category();
            objCategory.Connection = SystemVariables.Conn;
            return objCategory.GetParentCategoryLevel(cmbParentCategory.EditValue == null ? 0 : GeneralFunctions.fnInt32(cmbParentCategory.EditValue.ToString())) + 1;
        }

        private void populateParentCategoryLookup()
        {
            PosDataObject.Category objcat = new PosDataObject.Category();
            objcat.Connection = SystemVariables.Conn;
            DataTable dbtblPCat = objcat.LookupCategory(intID, intID == 0 ? true : false);
            cmbParentCategory.ItemsSource = dbtblPCat;
        }


        // --- Event Handlers (minimal logic retained) ---

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            // Keyboard initialization removed

            populateParentCategoryLookup();

            if (intID == 0) // New Category
            {
                //Title.Text = Properties.Resources.Add_Category;

                // ⭐ NEW: Automatically generate and assign ID, then disable the field
                txtID.Text = GenerateNextCategoryID();
                txtID.IsEnabled = false;                // ID is now read-only

                // Removed POS-related defaults
                // GeneralFunctions.SetFocus(txtDescription); // Focus should now go to description
            }
            else // Existing Category (Edit Mode)
            {
                //Title.Text = Properties.Resources.Edit_Category;
                ShowData();
                // ⭐ Ensure ID is disabled for editing too
                txtID.IsEnabled = false;
                // GeneralFunctions.SetFocus(txtDescription); // SetFocus call removed
            }
            cmbParentCategory.EditValue = PreselectedCategoryID;
            // Removed style-related logic
            boolControlChanged = false;
        }

        private void Button_Click(object sender, RoutedEventArgs e) // SAVE
        {
            if (IsValidAll())
            {
                if (SaveData())
                {
                    boolControlChanged = false;

                    // 🔔 Trigger a global signal
                    AppEvents.RaisePOSButtonsReloadRequested();

                    // Optionally, refresh local things or close the form
                    Close();
                }
            }
        }



        private void Button_Click_1(object sender, RoutedEventArgs e) // CANCEL
        {
            boolControlChanged = false;
            // CloseKeyboards(); // CloseKeyboards call removed
            Close();
        }

        private void TxtID_EditValueChanged(object sender, DevExpress.Xpf.Editors.EditValueChangedEventArgs e)
        {
            boolControlChanged = true;
        }

        private void ChkActive_Checked(object sender, RoutedEventArgs e)
        {
            boolControlChanged = true;
            // boolControlChangedItem = true; // Removed product item flag
        }

        // ⭐ NEW: Event handler for the Food Stamp ToggleSwitch
        private void ChkFoodStampEligible_Checked(object sender, RoutedEventArgs e)
        {
            boolControlChanged = true;
            // You might also need to set boolControlChangedItem = true if you reintroduce product-level updates
        }

        private void CmbParentCategory_EditValueChanged(object sender, DevExpress.Xpf.Editors.EditValueChangedEventArgs e)
        {
            boolControlChanged = true;
            // Removed lnkroot visibility logic (lnkroot removed from XAML)
            // Removed MaxPosDisplayOrder call (txtDisplayOrder removed from XAML)
        }

        private void CmbParentCategory_PreviewMouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            // Kept minimal logic to open the lookup editor
            DevExpress.Xpf.Editors.LookUpEditBase editor = sender as DevExpress.Xpf.Editors.LookUpEditBase;
            if (editor != null)
            {
                editor.IsPopupOpen = true;
                editor.ShowPopup();
                e.Handled = true;
            }
        }
        private string GenerateNextCategoryID()
        {
            string newID = "1";
            try
            {
                using (SqlConnection conn = new SqlConnection(SystemVariables.ConnectionString))
                {
                    conn.Open();
                    // TRY_CAST returns NULL for non-numeric strings like 'toacco', 
                    // allowing the MAX function to ignore them instead of crashing.
                    string sql = "SELECT MAX(TRY_CAST(CategoryID AS INT)) FROM Category";

                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        object result = cmd.ExecuteScalar();

                        if (result != null && result != DBNull.Value)
                        {
                            if (int.TryParse(result.ToString(), out int maxId))
                            {
                                newID = (maxId + 1).ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Windows.MessageBox.Show($"Error generating Category ID: {ex.Message}", "Database Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }

            return newID;
        }

        private void BtnLogin_Click(object sender, RoutedEventArgs e)
        {
            if (IsValidAll())
            {
                if (SaveData())
                {
                    boolControlChanged = false;

                    // 🔔 Trigger a global signal
                    AppEvents.RaisePOSButtonsReloadRequested();

                    // Optionally, refresh local things or close the form
                    Close();
                }
            }
        }

        private void BtnCancel_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }

        private void btnAdvance_Click(object sender, RoutedEventArgs e)
        {
            // 1. Instantiate the next form
            frm_CategoryDlg frmCat = new frm_CategoryDlg();

            // 2. Pass the data to the next form
            // Assuming the next form has an ID property to load existing data
            //frmCat.ID = intID;
            frmCat.txtDescription.Text=txtDescription.Text;
            frmCat.cmbParentCategory.SelectedIndex=cmbParentCategory.SelectedIndex;

            // If the next form is used for a new record but needs the generated ID:
            // frmCat.GeneratedID = txtID.Text; 

            // 3. Hide the current form
            this.Hide();

            // 4. Show the next form as a Dialog
            // ShowDialog() pauses execution here until frmCat is closed
            frmCat.ShowDialog();

            // 5. Check the result from the next form
            // We assume frm_CategoryDlg has a 'DataSaved' property like this one
            if (frmCat.IsSaved)
            {
                // If they clicked SAVE on the next form, close this form too
                //this.blDataSaved = true; // Sync state
                this.Close();
            }
            else
            {
                // If they clicked CANCEL or just closed the next form, show this form again
                this.Show();
            }
        }
        // Removed all other unnecessary event handlers (keyboard, tax, font, style, label type, etc.)
    }
}