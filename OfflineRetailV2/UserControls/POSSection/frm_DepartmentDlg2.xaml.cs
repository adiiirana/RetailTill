using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using OfflineRetailV2.Data;
using System.Data;
using System.Data.SqlClient;

namespace OfflineRetailV2.UserControls.POSSection
{
    /// <summary>
    /// Interaction logic for frm_DepartmentDlg2.xaml
    /// </summary>
    public partial class frm_DepartmentDlg2 : Window
    {
        private frm_DepartmentBrwUC frmBrowse;
        private int intID;
        private int intNewID;
        private bool boolControlChanged;
        private bool blOnScreenCall = false;
        private bool blDataSaved = false;
        private string RegisterModule = "";
        private bool bPrevScaleDept = false;
        FullKeyboard fkybrd;
        bool IsAboutFullKybrdOpen = false;

        public frm_DepartmentDlg2()
        {
            InitializeComponent();
            if (Settings.CloseoutExport == "N")
            {
                pGL.Visibility = Visibility.Collapsed;
                Height = 250;
            }
            ModalWindow.CloseCommand = new CommandBase(OnCloseCOmmand);
        }

        private void OnCloseCOmmand(object obj)
        {
            CloseKeyboards();
            Close();
        }

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

        public frm_DepartmentBrwUC BrowseForm
        {
            get
            {
                if (frmBrowse == null)
                    frmBrowse = new frm_DepartmentBrwUC();
                return frmBrowse;
            }
            set
            {
                frmBrowse = value;
            }
        }

        // Populates the DevExpress LookUpEdit with active Tax configurations
        public void PopulateTaxVAT()
        {
            PosDataObject.Tax objTax = new PosDataObject.Tax();
            objTax.Connection = SystemVariables.Conn;
            DataTable dbtblTax = new DataTable();

            dbtblTax = objTax.ShowTaxCombo();

            cmbVAT.ItemsSource = dbtblTax;
            cmbVAT.DisplayMember = "TaxName";
            cmbVAT.ValueMember = "TaxID";
            dbtblTax.Dispose();

            // REMOVE THIS LINE:
            // cmbVAT.EditValue = null; 
        }

        public void PopulateSalesGL()
        {
            PosDataObject.GLedger objEmployee = new PosDataObject.GLedger();
            objEmployee.Connection = SystemVariables.Conn;
            DataTable dbtbl = new DataTable();
            dbtbl = objEmployee.LookupGL("");

            cmbGL1.ItemsSource = dbtbl;
            cmbGL1.DisplayMember = "Lookup";
            cmbGL1.ValueMember = "ID";
            dbtbl.Dispose();
            cmbGL1.EditValue = null;
        }

        public void PopulateCostGL()
        {
            PosDataObject.GLedger objEmployee = new PosDataObject.GLedger();
            objEmployee.Connection = SystemVariables.Conn;
            DataTable dbtbl = new DataTable();
            dbtbl = objEmployee.LookupGL("");

            cmbGL2.ItemsSource = dbtbl;
            cmbGL2.DisplayMember = "Lookup";
            cmbGL2.ValueMember = "ID";
            dbtbl.Dispose();
            cmbGL2.EditValue = null;
        }

        public void PopulatePayableGL()
        {
            PosDataObject.GLedger objEmployee = new PosDataObject.GLedger();
            objEmployee.Connection = SystemVariables.Conn;
            DataTable dbtbl = new DataTable();
            dbtbl = objEmployee.LookupGL("");

            cmbGL3.ItemsSource = dbtbl;

            cmbGL3.DisplayMember = "Lookup";
            cmbGL3.ValueMember = "ID";
            dbtbl.Dispose();
            cmbGL3.EditValue = null;
        }

        public void PopulateInventoryGL()
        {
            PosDataObject.GLedger objEmployee = new PosDataObject.GLedger();
            objEmployee.Connection = SystemVariables.Conn;
            DataTable dbtbl = new DataTable();
            dbtbl = objEmployee.LookupGL("");

            cmbGL4.ItemsSource = dbtbl;

            cmbGL4.DisplayMember = "Lookup";
            cmbGL4.ValueMember = "ID";
            dbtbl.Dispose();
            cmbGL4.EditValue = null;
        }

        private bool IsValidAll()
        {
            if (txtID.Text.Trim() == "")
            {
                DocMessage.MsgEnter(Properties.Resources.Department_ID);
                GeneralFunctions.SetFocus(txtID);
                return false;
            }

            if (txtDescription.Text.Trim() == "")
            {
                DocMessage.MsgEnter("Department Name");
                GeneralFunctions.SetFocus(txtDescription);
                return false;
            }

            if (Settings.CloseoutExport == "Y")
            {
                if (cmbGL1.EditValue == null)
                {
                    DocMessage.MsgInformation(Properties.Resources.Select_Sales_GL);
                    GeneralFunctions.SetFocus(cmbGL1);
                    return false;
                }

                if (cmbGL2.EditValue == null)
                {
                    DocMessage.MsgInformation(Properties.Resources.Select_Cost_GL);
                    GeneralFunctions.SetFocus(cmbGL2);
                    return false;
                }

                if (cmbGL3.EditValue == null)
                {
                    DocMessage.MsgInformation(Properties.Resources.Select_Payable_GL);
                    GeneralFunctions.SetFocus(cmbGL3);
                    return false;
                }

                if (cmbGL4.EditValue == null)
                {
                    DocMessage.MsgInformation(Properties.Resources.Select_Inventory_GL);
                    GeneralFunctions.SetFocus(cmbGL4);
                    return false;
                }
            }

            if (intID == 0)
            {
                if (DuplicateCount() == 1)
                {
                    DocMessage.MsgInformation(Properties.Resources.Duplicate_Department_ID);
                    GeneralFunctions.SetFocus(txtID);
                    return false;
                }
            }
            return true;
        }

        private bool SaveData()
        {
            string strError = "";
            PosDataObject.Department objDepartment = new PosDataObject.Department();
            objDepartment.Connection = SystemVariables.Conn;
            objDepartment.LoginUserID = SystemVariables.CurrentUserID;
            objDepartment.GeneralCode = txtID.Text.Trim();
            objDepartment.GeneralDesc = txtDescription.Text.Trim();
            objDepartment.isDepartmentSale = chkDepartmentSale.IsChecked == true;

            objDepartment.ID = intID;

            objDepartment.FoodStamp = "N";
            objDepartment.ScaleFlag = chkScale.IsChecked == true ? "Y" : "N";
            objDepartment.ScaleScreenVisible = chkAddToScale.IsChecked == true ? "Y" : "N";

            if (intID == 0)
            {
                if (chkScale.IsChecked == true)
                {
                    objDepartment.ScaleDisplayOrder = FetchMaxScaleDisPlayOrder();
                }
                else
                {
                    objDepartment.ScaleDisplayOrder = 0;
                }
            }
            else
            {
                if ((chkScale.IsChecked == true) && (bPrevScaleDept))
                {
                    objDepartment.ScaleDisplayOrder = GeneralFunctions.fnInt32(txtDisplayOrder.Text);
                }

                if ((chkScale.IsChecked == true) && (!bPrevScaleDept))
                {
                    objDepartment.ScaleDisplayOrder = FetchMaxScaleDisPlayOrder();
                }

                if ((!chkScale.IsChecked == true) && (bPrevScaleDept))
                {
                    objDepartment.ScaleDisplayOrder = 0;
                }

                if ((!chkScale.IsChecked == true) && (!bPrevScaleDept))
                {
                    objDepartment.ScaleDisplayOrder = 0;
                }
            }

            if (Settings.CloseoutExport == "Y")
            {
                objDepartment.LinkSalesGL = GeneralFunctions.fnInt32(cmbGL1.EditValue);
                objDepartment.LinkCostGL = GeneralFunctions.fnInt32(cmbGL2.EditValue);
                objDepartment.LinkPayableGL = GeneralFunctions.fnInt32(cmbGL3.EditValue);
                objDepartment.LinkInventoryGL = GeneralFunctions.fnInt32(cmbGL4.EditValue);
            }
            else
            {
                objDepartment.LinkSalesGL = 0;
                objDepartment.LinkCostGL = 0;
                objDepartment.LinkPayableGL = 0;
                objDepartment.LinkInventoryGL = 0;
            }

            // 1. Commit the base department master data using standard procedures
            if (intID == 0)
            {
                strError = objDepartment.InsertData();
                NewID = objDepartment.ID;
            }
            else
            {
                strError = objDepartment.UpdateData();

                if ((!chkScale.IsChecked == true) && (bPrevScaleDept))
                {
                    int pOrder = GeneralFunctions.fnInt32(txtDisplayOrder.Text);
                    UpdateDisplayOrder(intID, pOrder, "X");
                }
            }

            // 2. Commit polymorphic database adjustments to TaxMapping if base fields passed safely
            if (strError == "")
            {
                int targetID = intID == 0 ? NewID : intID;

                SqlConnection conn = SystemVariables.Conn;
                bool shouldCloseConn = false;

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                    shouldCloseConn = true;
                }

                SqlTransaction taxTransaction = conn.BeginTransaction();

                try
                {
                    // Clear out old tax mappings for this department record footprint
                    string sqlDelete = "DELETE FROM TaxMapping WHERE MappingType = 'Department' AND MappingID = @MappingID";
                    using (SqlCommand cmdDelete = new SqlCommand(sqlDelete, conn, taxTransaction))
                    {
                        cmdDelete.Parameters.AddWithValue("@MappingID", targetID);
                        cmdDelete.ExecuteNonQuery();
                    }

                    // Insert the freshly picked tax assignment row if selected
                    if (cmbVAT.EditValue != null && GeneralFunctions.fnInt32(cmbVAT.EditValue) > 0)
                    {
                        int selectedTaxID = GeneralFunctions.fnInt32(cmbVAT.EditValue);
                        string sqlInsert = @"INSERT INTO TaxMapping (TaxID, MappingType, MappingID, CreatedBy, CreatedOn, LastChangedBy, LastChangedOn) 
                                             VALUES (@TaxID, 'Department', @MappingID, @UserID, @Now, @UserID, @Now)";

                        using (SqlCommand cmdInsert = new SqlCommand(sqlInsert, conn, taxTransaction))
                        {
                            cmdInsert.Parameters.AddWithValue("@TaxID", selectedTaxID);
                            cmdInsert.Parameters.AddWithValue("@MappingID", targetID);
                            cmdInsert.Parameters.AddWithValue("@UserID", SystemVariables.AuditUserID);
                            cmdInsert.Parameters.AddWithValue("@Now", DateTime.Now);

                            cmdInsert.ExecuteNonQuery();
                        }
                    }

                    taxTransaction.Commit();
                }
                catch (Exception ex)
                {
                    taxTransaction.Rollback();
                    strError = "Tax Mapping Error: " + ex.Message;
                }
                finally
                {
                    taxTransaction.Dispose();
                    if (shouldCloseConn) conn.Close();
                }
            }

            // 3. Evaluate finalize checks to pass status flags upward
            if (strError == "")
            {
                blDataSaved = true;
                return true;
            }
            else
            {
                DocMessage.MsgInformation(strError);
                return false;
            }
        }

        private int DuplicateCount()
        {
            PosDataObject.Department objDepartment = new PosDataObject.Department();
            objDepartment.Connection = new SqlConnection(SystemVariables.ConnectionString);
            return objDepartment.DuplicateCount(txtID.Text.Trim());
        }

        private int FetchMaxScaleDisPlayOrder()
        {
            PosDataObject.Department objCategory = new PosDataObject.Department();
            objCategory.Connection = new SqlConnection(SystemVariables.ConnectionString);
            return objCategory.MaxScaleDisplayOrder() + 1;
        }

        private int UpdateDisplayOrder(int pID, int pOrder, string pType)
        {
            PosDataObject.Department objCategory = new PosDataObject.Department();
            objCategory.Connection = SystemVariables.Conn;
            return objCategory.UpdateDepartmentDisplayOrder(pID, pOrder, pType);
        }

        // Reads the corresponding 'Department' tax map to restore select configurations in Edit mode
        private void LoadDepartmentTaxMapping()
        {
            if (intID == 0) return;

            try
            {
                using (SqlConnection conn = new SqlConnection(SystemVariables.ConnectionString))
                {
                    conn.Open();
                    string sql = "SELECT TOP 1 TaxID FROM TaxMapping WHERE MappingType = 'Department' AND MappingID = @MappingID";
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@MappingID", intID);
                        object result = cmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                        {
                            cmbVAT.EditValue = result.ToString();
                        }
                    }
                }
            }
            catch { }
        }

        public void ShowData()
        {
            PosDataObject.Department objDepartment = new PosDataObject.Department();
            objDepartment.Connection = SystemVariables.Conn;
            DataTable dbtbl = new DataTable();
            dbtbl = objDepartment.ShowRecord(intID);
            foreach (DataRow dr in dbtbl.Rows)
            {
                txtID.Text = dr["DepartmentID"].ToString();
                txtDescription.Text = dr["Description"].ToString();
                chkDepartmentSale.IsChecked = Convert.ToBoolean(dr["IsDepartmentSale"]);
                if (dr["ScaleFlag"].ToString() == "Y")
                {
                    chkScale.IsChecked = true;
                    bPrevScaleDept = true;
                }
                else
                {
                    chkScale.IsChecked = false;
                    bPrevScaleDept = false;
                }

                if (dr["ScaleScreenVisible"].ToString() == "Y")
                {
                    chkAddToScale.IsChecked = true;
                }
                else
                {
                    chkAddToScale.IsChecked = false;
                }

                txtDisplayOrder.Text = dr["ScaleDisplayOrder"].ToString();

                if (Settings.CloseoutExport == "Y")
                {
                    if (GeneralFunctions.fnInt32(dr["LinkSalesGL"].ToString()) > 0)
                    {
                        cmbGL1.EditValue = dr["LinkSalesGL"].ToString();
                    }

                    if (GeneralFunctions.fnInt32(dr["LinkCostGL"].ToString()) > 0)
                    {
                        cmbGL2.EditValue = dr["LinkCostGL"].ToString();
                    }

                    if (GeneralFunctions.fnInt32(dr["LinkPayableGL"].ToString()) > 0)
                    {
                        cmbGL3.EditValue = dr["LinkPayableGL"].ToString();
                    }

                    if (GeneralFunctions.fnInt32(dr["LinkInventoryGL"].ToString()) > 0)
                    {
                        cmbGL4.EditValue = dr["LinkInventoryGL"].ToString();
                    }
                }
            }

            dbtbl.Dispose();

            // Retrieve structural relations to reflect inside edit panel lookup matching
            LoadDepartmentTaxMapping();
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (boolControlChanged)
            {
                MessageBoxResult DlgResult = new MessageBoxResult();
                DlgResult = new MessageBoxWindow().Show(Properties.Resources.strSaveChanges, Properties.Resources.Confirm, MessageBoxButton.YesNoCancel, MessageBoxImage.Question);

                if (DlgResult == MessageBoxResult.Yes)
                {
                    if (IsValidAll())
                    {
                        if (SaveData())
                        {
                            boolControlChanged = false;
                            if (!blOnScreenCall) BrowseForm.FetchData();
                        }
                        else
                            e.Cancel = true;
                    }
                    else
                        e.Cancel = true;
                }

                if (DlgResult == MessageBoxResult.Cancel)
                    e.Cancel = true;
            }
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            fkybrd = new FullKeyboard();

            // Populates available Taxes lists safely during initial view state rendering
            PopulateTaxVAT();

            if (Settings.CloseoutExport == "Y")
            {
                PopulateSalesGL();
                PopulateCostGL();
                PopulatePayableGL();
                PopulateInventoryGL();
            }

            RegisterModule = GeneralFunctions.RegisteredModules();

            if (intID == 0)
            {
                Title.Text = Properties.Resources.Add_Department;
                txtID.Text = GenerateNextDepartmentID();
                txtID.IsEnabled = false;
                GeneralFunctions.SetFocus(txtDescription);
            }
            else
            {
                Title.Text = Properties.Resources.Edit_Department;
                txtID.IsEnabled = false;
                GeneralFunctions.SetFocus(txtDescription);
                ShowData();
            }

            boolControlChanged = false;
        }

        private void TxtID_EditValueChanged(object sender, DevExpress.Xpf.Editors.EditValueChangedEventArgs e)
        {
            boolControlChanged = true;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            boolControlChanged = false;
            CloseKeyboards();
            Close();
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            if (IsValidAll())
            {
                if (SaveData())
                {
                    boolControlChanged = false;
                    if (!blOnScreenCall) BrowseForm.FetchData();
                    CloseKeyboards();
                    Close();
                }
            }
        }

        private void TxtID_EditValueChanged(object sender, RoutedEventArgs e)
        {

        }

        private void CmbGL1_PreviewMouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            DevExpress.Xpf.Editors.ComboBoxEdit editor = sender as DevExpress.Xpf.Editors.ComboBoxEdit;

            if (editor != null)
            {
                editor.IsPopupOpen = true;
                editor.ShowPopup();
                e.Handled = true;
            }
        }

        private void CloseKeyboards()
        {
            if (fkybrd != null)
            {
                fkybrd.Close();
            }
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
                    Topmost = true,
                    ShowInTaskbar = false,
                    WindowStartupLocation = WindowStartupLocation.Manual
                };

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
                    Rect workArea = ScreenHelper.GetWorkAreaForWindow(posMain);
                    fkybrd.Left = workArea.Left + (workArea.Width - fkybrd.Width) / 2;
                    fkybrd.Top = workArea.Bottom - fkybrd.Height - 10;
                }
                else
                {
                    var primary = ScreenHelper.GetWorkAreaForWindow(System.Windows.Application.Current.MainWindow ?? this);
                    fkybrd.Left = primary.Left + (primary.Width - fkybrd.Width) / 2;
                    fkybrd.Top = primary.Bottom - fkybrd.Height - 10;
                }

                fkybrd.Closing += FKybrd_Closing;
                fkybrd.Show();
                IsAboutFullKybrdOpen = true;
            }
        }

        private string GenerateNextDepartmentID()
        {
            string newID = "1";
            try
            {
                using (SqlConnection conn = new SqlConnection(SystemVariables.ConnectionString))
                {
                    conn.Open();
                    string sql = "SELECT ISNULL(MAX(TRY_CAST(DepartmentID AS INT)), 0) FROM Dept";

                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        object result = cmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                        {
                            int maxId = Convert.ToInt32(result);
                            newID = (maxId + 1).ToString();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
            }
            return newID;
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

        private void Full_LostFocus(object sender, RoutedEventArgs e)
        {
            CloseKeyboards();
        }

        private void CmbGL1_PreviewMouseMouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {

        }
    }
}