using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using OfflineRetailV2.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net.NetworkInformation;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Data.SqlClient;

using System.Threading.Tasks;

namespace OfflineRetailV2.UserControls.Administrator
{

    /// <summary>
    /// Interaction logic for frm_XEPOSCloudSyncSetupDlg.xaml
    /// </summary>
    public partial class frm_XEPOSCloudSyncSetupDlg : Window
    {
        string apiBaseUrl = ConfigSettings.GetApiURL();
        private bool blFirstTimeCall;
        private bool blRegistered;
        private int intcloudID;
        private string _authToken = "";
        public int cloudId
        {
            get { return intcloudID; }
            set { intcloudID = value; }
        }
        public bool FirstTimeCall
        {
            get { return blFirstTimeCall; }
            set { blFirstTimeCall = value; }
        }
        public bool Registered
        {
            get { return blRegistered; }
            set { blRegistered = value; }
        }
        private string logF = "";
        private string logP = "";

        private string logCF = "";
        private string logCP = "";

        FullKeyboard fkybrd;
        bool IsAboutFullKybrdOpen = false;
        private bool _hasBusinessRegistration;
        private bool _hasStoreRegistration;
        private bool _localStoreRecordExists;
        private bool _storeSectionEnabled;
        private bool _isStoreConnected;
        private bool _isNewStoreSelection;
        private const int NewStorePlaceholderId = -1;
        private const string NewStorePlaceholderText = "-- Register New Store --";
        public frm_XEPOSCloudSyncSetupDlg()
        {
            InitializeComponent();
            ModalWindow.CloseCommand = new CommandBase(OnCloseCommandExecute);
            
            // Sync Business Name fields when text changes
            txtBusinessName.EditValueChanged += (s, e) => {
                if (txtBusinessNameStore.Visibility == Visibility.Visible)
                {
                    txtBusinessNameStore.Text = txtBusinessName.Text;
                }
            };
            txtBusinessNameStore.EditValueChanged += (s, e) => {
                if (txtBusinessName.Visibility == Visibility.Visible)
                {
                    txtBusinessName.Text = txtBusinessNameStore.Text;
                }
            };
        }

        private bool boolControlChanged;

        private void ApplyBusinessModeUI(bool isExistingBusiness, bool updateToggleState)
        {
            if (updateToggleState)
            {
                chkBusinessExist.Checked -= chkBusinessExist_Checked;
                chkBusinessExist.Unchecked -= chkBusinessExist_Unchecked;
                chkBusinessExist.IsChecked = isExistingBusiness;
                chkBusinessExist.Checked += chkBusinessExist_Checked;
                chkBusinessExist.Unchecked += chkBusinessExist_Unchecked;
            }

            bool canEditBusinessName = !isExistingBusiness && string.IsNullOrEmpty(_authToken) && !_isStoreConnected;
            txtBusinessName.IsEnabled = canEditBusinessName;

            btnRegisterBusiness.Content = isExistingBusiness ? "Login" : "Register Business";

            // Handle Business Name field visibility based on toggle state
            // Preserve the current value before switching
            string currentBusinessName = string.Empty;
            // Get value from whichever field currently has it
            if (!string.IsNullOrEmpty(txtBusinessName.Text))
            {
                currentBusinessName = txtBusinessName.Text;
            }
            else if (!string.IsNullOrEmpty(txtBusinessNameStore.Text))
            {
                currentBusinessName = txtBusinessNameStore.Text;
            }
            
            if (isExistingBusiness)
            {
                // When toggle is checked (already registered): Show Business Name in Store section BEFORE Store Name
                // Hide Business Name from Business Setup section
                lblBusinessName.Visibility = Visibility.Collapsed;
                txtBusinessName.Visibility = Visibility.Collapsed;
                
                // Collapse Row 0 (Business Name row) and Row 1 (spacer) in Business Setup section so Email shifts up
                if (BusinessSetupGrid != null && BusinessSetupGrid.RowDefinitions.Count > 1)
                {
                    BusinessSetupGrid.RowDefinitions[0].Height = new GridLength(0); // Collapse Business Name row
                    BusinessSetupGrid.RowDefinitions[1].Height = new GridLength(0); // Collapse spacer row
                }
                
                // Show Business Name in Register Store section (at Row 0, before Select Store at Row 2 and Store Name at Row 4)
                lblBusinessNameStore.Visibility = Visibility.Visible;
                txtBusinessNameStore.Visibility = Visibility.Visible;
                
                // Set the preserved value - use Text property for DevExpress TextEdit
                if (!string.IsNullOrEmpty(currentBusinessName))
                {
                    txtBusinessNameStore.Text = currentBusinessName;
                }
                txtBusinessNameStore.IsEnabled = false; // Read-only in Store section
                
                // Update row spacing - show spacer when Business Name is visible in Store section
                // This makes Select Store move below Business Name
                if (gcco223 != null && gcco223.RowDefinitions.Count > 1)
                {
                    gcco223.RowDefinitions[0].Height = GridLength.Auto; // Show Business Name row
                    gcco223.RowDefinitions[1].Height = new GridLength(10); // Show spacer
                }
            }
            else
            {
                // When toggle is unchecked (new business): Show Business Name in Business Setup section BEFORE Email
                // Hide Business Name from Register Store section
                lblBusinessNameStore.Visibility = Visibility.Collapsed;
                txtBusinessNameStore.Visibility = Visibility.Collapsed;
                
                // Show Business Name in Business Setup section (at Row 0, before Email at Row 2)
                lblBusinessName.Visibility = Visibility.Visible;
                txtBusinessName.Visibility = Visibility.Visible;
                
                // Show Row 0 (Business Name row) and Row 1 (spacer) in Business Setup section
                if (BusinessSetupGrid != null && BusinessSetupGrid.RowDefinitions.Count > 1)
                {
                    BusinessSetupGrid.RowDefinitions[0].Height = GridLength.Auto; // Show Business Name row
                    BusinessSetupGrid.RowDefinitions[1].Height = new GridLength(10); // Show spacer row
                }
                
                // Set the preserved value - use Text property for DevExpress TextEdit
                if (!string.IsNullOrEmpty(currentBusinessName))
                {
                    txtBusinessName.Text = currentBusinessName;
                }
                
                // Update row spacing - collapse Business Name row and spacer in Store section
                // This makes Select Store move up to where Business Name was
                if (gcco223 != null && gcco223.RowDefinitions.Count > 1)
                {
                    gcco223.RowDefinitions[0].Height = new GridLength(0); // Collapse Business Name row
                    gcco223.RowDefinitions[1].Height = new GridLength(0); // Collapse spacer
                }
            }

            UpdateBusinessControlsState();
        }

        private void SetStoreSectionEnabled(bool enable)
        {
            _storeSectionEnabled = enable;
            gcco3111.IsEnabled = enable;
            gcco223.IsEnabled = enable;

            if (!enable)
            {
                _isNewStoreSelection = false;
                cmbExistingStores.SelectedIndex = -1;
                txtStoreName.Text = string.Empty;
            }

            RefreshStoreSectionState();
        }

        private void RefreshStoreSectionState()
        {
            bool hasStoredStore = !string.IsNullOrWhiteSpace(hdStoreID.Text);
            bool allowStoreEdit = _storeSectionEnabled && !_isStoreConnected && (!hasStoredStore || _isNewStoreSelection);

            cmbExistingStores.IsEnabled = _storeSectionEnabled && !_isStoreConnected;
            txtStoreName.IsEnabled = allowStoreEdit;

            if (!_storeSectionEnabled)
            {
                btnRegisterStore.IsEnabled = false;
            }
            else
            {
                // Combined button: enable if we can register (new store) or connect (existing store)
                btnRegisterStore.IsEnabled = (_storeSectionEnabled && !_isStoreConnected) && 
                    ((allowStoreEdit && (_isNewStoreSelection || !hasStoredStore)) || 
                     (hasStoredStore && !_isNewStoreSelection));
                
                // Update button text based on state
                if (hasStoredStore && !_isNewStoreSelection && !_isStoreConnected)
                {
                    btnRegisterStore.Content = "Connect Store";
                }
                else if (allowStoreEdit && (_isNewStoreSelection || !hasStoredStore))
                {
                    btnRegisterStore.Content = "Register & Connect Store";
                }
            }
        }

        private void ApplyConnectedState(bool isConnected)
        {
            _isStoreConnected = isConnected;
            
            // Disable individual controls instead of MainContentGrid to keep logout button enabled
            if (BusinessSetupGrid != null)
            {
                BusinessSetupGrid.IsEnabled = !isConnected;
            }

            if (chkBusinessExist != null)
            {
                chkBusinessExist.IsEnabled = !isConnected;
            }

            // Disable individual controls in the store section, but keep logout button enabled
            if (txtBusinessNameStore != null)
            {
                txtBusinessNameStore.IsEnabled = !isConnected;
            }
            if (cmbExistingStores != null)
            {
                cmbExistingStores.IsEnabled = !isConnected;
                if (isConnected && int.TryParse(hdStoreID.Text, out var selectedStoreId))
                {
                    cmbExistingStores.SelectedValue = selectedStoreId;
                }
            }
            if (txtStoreName != null)
            {
                txtStoreName.IsEnabled = !isConnected;
            }

            if (btnRegisterStore != null)
            {
                btnRegisterStore.Visibility = isConnected ? Visibility.Collapsed : Visibility.Visible;
                btnRegisterStore.IsEnabled = !isConnected;
            }

            // Logout button should always be enabled when visible
            if (btnLogout != null)
            {
                btnLogout.Visibility = isConnected ? Visibility.Visible : Visibility.Collapsed;
                btnLogout.IsEnabled = true; // Always enabled when visible
            }

            RefreshStoreSectionState();
            UpdateBusinessControlsState();
        }

        private void ClearBusinessAndStoreData()
        {
            using (var connection = new SqlConnection(SystemVariables.ConnectionString))
            {
                if (connection.State != ConnectionState.Open)
                {
                    connection.Open();
                }

                using (var transaction = connection.BeginTransaction())
                {
                    using (var deleteStore = new SqlCommand("DELETE FROM StoreInfo", connection, transaction))
                    {
                        deleteStore.ExecuteNonQuery();
                    }

                    using (var deleteBusiness = new SqlCommand("DELETE FROM BusinessInfo", connection, transaction))
                    {
                        deleteBusiness.ExecuteNonQuery();
                    }

                    transaction.Commit();
                }
            }

            _localStoreRecordExists = false;
        }

        private void UpdateBusinessControlsState()
        {
            bool allowCredentialsEdit = string.IsNullOrEmpty(_authToken) && !_isStoreConnected;

            txtEmail.IsEnabled = allowCredentialsEdit;
            txtPassword.IsEnabled = allowCredentialsEdit;
            btnRegisterBusiness.IsEnabled = allowCredentialsEdit;

            if (!allowCredentialsEdit)
            {
                txtBusinessName.IsEnabled = false;
                // Update button text to "Logged In" after successful login
                if (!string.IsNullOrEmpty(_authToken))
                {
                    btnRegisterBusiness.Content = "Logged In";
                }
            }
        }

        private void OnCloseCommandExecute(object obj)
        {
            Close();
        }

        private void EnsureStoreTableInitialized()
        {
            if (_storeTable == null)
            {
                _storeTable = new DataTable();
                _storeTable.Columns.Add("id", typeof(int));
                _storeTable.Columns.Add("store_name", typeof(string));
                _storeTable.Columns.Add("store_code", typeof(string));
            }
            EnsurePlaceholderRow();
        }

        private void EnsurePlaceholderRow()
        {
            if (_storeTable == null || _storeTable.Columns.Count == 0) return;

            DataRow placeholderRow = null;
            var rows = _storeTable.Select($"id = {NewStorePlaceholderId}");
            if (rows.Length > 0)
            {
                placeholderRow = rows[0];
            }

            if (placeholderRow == null)
            {
                placeholderRow = _storeTable.NewRow();
                placeholderRow["id"] = NewStorePlaceholderId;
                placeholderRow["store_name"] = NewStorePlaceholderText;
                placeholderRow["store_code"] = string.Empty;
                _storeTable.Rows.InsertAt(placeholderRow, 0);
            }
            else
            {
                var index = _storeTable.Rows.IndexOf(placeholderRow);
                if (index > 0)
                {
                    var values = placeholderRow.ItemArray;
                    _storeTable.Rows.RemoveAt(index);
                    var newPlaceholder = _storeTable.NewRow();
                    newPlaceholder.ItemArray = values;
                    _storeTable.Rows.InsertAt(newPlaceholder, 0);
                }
            }
        }

        private void EnsureStoreInDropdown(int storeId, string storeName, string storeCode, bool selectStore = false)
        {
            EnsureStoreTableInitialized();

            var existingRows = _storeTable.Select($"id = {storeId}");
            if (existingRows.Length == 0)
            {
                _storeTable.Rows.Add(storeId, storeName, storeCode);
            }
            else
            {
                existingRows[0]["store_name"] = storeName;
                existingRows[0]["store_code"] = storeCode;
            }

            EnsurePlaceholderRow();

            cmbExistingStores.ItemsSource = _storeTable.DefaultView;
            cmbExistingStores.DisplayMemberPath = "store_name";
            cmbExistingStores.SelectedValuePath = "id";

            if (selectStore)
            {
                cmbExistingStores.SelectedValue = storeId;
            }
        }

        private string FormatApiError(string rawContent, string fallbackMessage)
        {
            if (string.IsNullOrWhiteSpace(rawContent))
            {
                return fallbackMessage;
            }

            try
            {
                var token = JToken.Parse(rawContent);
                if (token?.Type == JTokenType.Object)
                {
                    string message = token.Value<string>("message");
                    string detailedError = null;

                    var errorsObject = token["errors"] as JObject;
                    if (errorsObject != null)
                    {
                        var firstErrorProperty = errorsObject.Properties().FirstOrDefault();
                        if (firstErrorProperty != null)
                        {
                            if (firstErrorProperty.Value is JArray errorArray && errorArray.Count > 0)
                            {
                                detailedError = errorArray[0]?.ToString();
                            }
                            else
                            {
                                detailedError = firstErrorProperty.Value?.ToString();
                            }
                        }
                    }

                    var parts = new List<string>();
                    if (!string.IsNullOrWhiteSpace(message))
                    {
                        parts.Add(message.Trim());
                    }
                    if (!string.IsNullOrWhiteSpace(detailedError) &&
                        !parts.Any(p => string.Equals(p, detailedError, StringComparison.OrdinalIgnoreCase)))
                    {
                        parts.Add(detailedError.Trim());
                    }

                    if (parts.Count > 0)
                    {
                        return string.Join(" ", parts);
                    }
                }
            }
            catch
            {
                // ignore parsing errors, fall back to default
            }

            return fallbackMessage;
        }

      
        private bool SetCloudConn()
        {
            string strconn = Settings.XEPOSCloudConnectionParameter;
            String ConnStr = "";
            System.Data.SqlClient.SqlConnection Conn;
            try
            {
                ConnStr = strconn;
                Conn = new System.Data.SqlClient.SqlConnection(ConnStr);
                SystemVariables.rmConn = Conn;
                Conn.Open();
                Conn.Close();
                return true;
            }
            catch
            {
                return false;
            }
        }

        
        private void BtnClientLogin_Click(object sender, RoutedEventArgs e)
        {

            if (txtPassword.Text.Trim() == "")
            {
                DocMessage.MsgEnter(Properties.Resources.Password);
                GeneralFunctions.SetFocus(txtPassword);
                return;
            }

            Cursor = Cursors.Wait;
        }
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            fkybrd = new FullKeyboard();
            LoadFormData();
        }

        private void LoadFormData()
        {
            //Title.Text = Properties.Resources.XEPOS_Cloud_Setup;
            string strRegisteredModule = GeneralFunctions.RegisteredModules();
            var businessExists = ShowData();
            if (!businessExists)
            {
                SetStoreSectionEnabled(false);
            }

            boolControlChanged = false;
            UpdateBusinessControlsState();
        }
        private bool ShowStoreData()
        {
            PosDataObject.Setup objSetup = new PosDataObject.Setup();
            objSetup.Connection = SystemVariables.Conn;
            DataTable dt = objSetup.FetchStoreInfo();
            if (dt == null)
            {
                _localStoreRecordExists = false;
                _hasStoreRegistration = false;
                ApplyConnectedState(false);
                RefreshStoreSectionState();
                return false;
            }
            _localStoreRecordExists = dt.Rows.Count > 0;
            if (_localStoreRecordExists)
            {
                _hasStoreRegistration = true;
                _isNewStoreSelection = false;
                var row = dt.Rows[0];
                string storeCode = row["StoreCode"].ToString();
                txtStoreName.Text = row["StoreName"].ToString();
                hdStoreID.Text = row["CloudId"].ToString();

                if (int.TryParse(hdStoreID.Text, out var storeIdValue))
                {
                    EnsureStoreInDropdown(storeIdValue, txtStoreName.Text.Trim(), storeCode, true);
                }

                bool isConnected = false;
                if (dt.Columns.Contains("isConnect"))
                {
                    var value = row["isConnect"];
                    if (value != DBNull.Value)
                    {
                        isConnected = Convert.ToBoolean(value);
                    }
                }

                ApplyConnectedState(isConnected);
            }
            else
            {
                hdStoreID.Text = string.Empty;
                txtStoreName.Text = string.Empty;
                _hasStoreRegistration = false;
                _localStoreRecordExists = false;
                 _isNewStoreSelection = true;
                ApplyConnectedState(false);
                if (_authToken == "")
                {
                    _ = LoginAsync();
                }
                if (gcco223.IsEnabled)
                {
                    this.txtStoreName.Focus();
                }

                EnsureStoreTableInitialized();
                cmbExistingStores.ItemsSource = _storeTable.DefaultView;
                cmbExistingStores.DisplayMemberPath = "store_name";
                cmbExistingStores.SelectedValuePath = "id";
                cmbExistingStores.SelectedValue = NewStorePlaceholderId;
            }

            RefreshStoreSectionState();
            return _hasStoreRegistration;
        }
        public class TokenResponse
        {
            public string Message { get; set; }
            public User User { get; set; }
            public string Access_Token { get; set; }
            public string TokenType { get; set; }
        }

        public class User
        {
            public int Id { get; set; }
            public string Name { get; set; }
            public string Email { get; set; }
            public DateTime EmailVerifiedAt { get; set; }
            public DateTime CreatedAt { get; set; }
            public DateTime UpdatedAt { get; set; }
        }
        public class StoreResponseDto
        {
            public bool Success { get; set; }
            public string Message { get; set; }
            public StoreDataDto Data { get; set; }
        }

        public class StoreDataDto
        {
            public string ThirdPartyId { get; set; }
            public int StoreCode { get; set; }
            public string StoreName { get; set; }
            public DateTime UpdatedAt { get; set; }
            public DateTime CreatedAt { get; set; }
            public int Id { get; set; }
        }
        private async Task<bool> SaveStoreDataAsync()
        {
            if (!gcco223.IsEnabled)
            {
                DocMessage.MsgWarning("Please complete business registration before registering a store.");
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtStoreName.Text))
            {
                DocMessage.MsgWarning("Store name is required.");
                return false;
            }

            Cursor = Cursors.Wait;
            try
            {
                var selectedStore = cmbExistingStores.SelectedItem as DataRowView;
                var selectedStoreId = selectedStore != null ? Convert.ToInt32(selectedStore["id"]) : NewStorePlaceholderId;
                var isNewStoreSelection = selectedStore == null || selectedStoreId == NewStorePlaceholderId;

                if (isNewStoreSelection)
                {
                    if (string.IsNullOrEmpty(_authToken))
                    {
                        DocMessage.MsgWarning("Please login before registering a store.");
                        await LoginAsync();
                        return false;
                    }

                    //using var client = new HttpClient();
                    using (var client = new HttpClient())
                    {
                        var apiUrl = apiBaseUrl + "/stores";
                        //var apiUrl = "https://api-retail.xepos.net/api/v1/stores";

                        var registerStorePayload = new
                        {
                            third_party_id = hdID.Text,
                            //store_code = txtStoreName.Text.Trim().Replace(" ", "").ToUpper(), // Generate store code from store name
                            store_name = txtStoreName.Text.Trim(),
                            Address = "",
                            City = "",
                            State = "",
                            ZipCode = "",
                            Phone = "",
                            Email = "",
                            ManagerName = "",
                            Enabled = "Y",
                            is_web = false
                        };

                        var jsonContent = new StringContent(
                            JsonConvert.SerializeObject(registerStorePayload),
                            Encoding.UTF8,
                            "application/json");
                        client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", _authToken);
                        client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                        var response = await client.PostAsync(apiUrl, jsonContent);
                        if (!response.IsSuccessStatusCode)
                        {
                            var errorMessage = await response.Content.ReadAsStringAsync();
                            var friendly = FormatApiError(errorMessage, "Store registration failed. Please review the details and try again.");
                            DocMessage.MsgError(friendly);
                            return false;
                        }

                        var result = await response.Content.ReadAsStringAsync();
                        var apiResponseResult = JsonConvert.DeserializeObject<StoreResponseDto>(result);
                        if (apiResponseResult?.Data == null)
                        {
                            DocMessage.MsgError("Store registration failed. Unexpected response from server.");
                            return false;
                        }

                        string generatedStoreCode = txtStoreName.Text.Trim().Replace(" ", "").ToUpper();
                        string businessName = !string.IsNullOrWhiteSpace(txtBusinessName.Text)
                            ? txtBusinessName.Text.Trim()
                            : (txtBusinessNameStore.Text ?? string.Empty).Trim();
                        var objSetup = new PosDataObject.Setup
                        {
                            Connection = SystemVariables.Conn,
                            Company = businessName,
                            Businessname = businessName,
                            CloudId = apiResponseResult.Data.Id,
                            StoreCode = generatedStoreCode,
                            StoreName = txtStoreName.Text.Trim(),
                            Address1 = "",
                            Address2 = "",
                            City = "",
                            State = "",
                            PostalCode = "",
                            Phone = "",
                            EMail = txtEmail.Text.Trim(),
                            ManagerName = "",
                            Enable = "Y",
                            LoginUserID = SystemVariables.CurrentUserID
                        };

                        hdStoreID.Text = apiResponseResult.Data.Id.ToString();

                        var storeSaveResult = objSetup.InsertStoreRegistration();
                        if (!string.IsNullOrEmpty(storeSaveResult))
                        {
                            DocMessage.MsgError("Store registered remotely but failed to save locally: " + storeSaveResult);
                            return false;
                        }

                        objSetup.ID = Convert.ToInt32(hdID.Text);
                        objSetup.Token = _authToken;
                        objSetup.BaseURL = apiBaseUrl;
                        objSetup.UpdateBusinessRegistration();

                        _hasStoreRegistration = true;
                        _isNewStoreSelection = false;
                        _localStoreRecordExists = true;
                        EnsureStoreInDropdown(apiResponseResult.Data.Id, txtStoreName.Text.Trim(), generatedStoreCode, true);
                        ShowStoreData();
                        DocMessage.MsgInformation("Store registered successfully.");
                        return true;
                    }
                }
                else
                {
                    string storeCode = selectedStore != null ? selectedStore["store_code"].ToString() : txtStoreName.Text.Trim().Replace(" ", "").ToUpper();
                    string businessName = !string.IsNullOrWhiteSpace(txtBusinessName.Text)
                        ? txtBusinessName.Text.Trim()
                        : (txtBusinessNameStore.Text ?? string.Empty).Trim();
                    var objSetup = new PosDataObject.Setup
                    {
                        Connection = SystemVariables.Conn,
                        Company = businessName,
                        Businessname = businessName,
                        CloudId = selectedStoreId,
                        StoreCode = storeCode,
                        StoreName = txtStoreName.Text.Trim(),
                        Address1 = "",
                        Address2 = "",
                        City = "",
                        State = "",
                        PostalCode = "",
                        Phone = "",
                        EMail = txtEmail.Text.Trim(),
                        ManagerName = "",
                        Enable = "Y",
                        LoginUserID = SystemVariables.CurrentUserID
                    };

                    var storeSaveResult = objSetup.InsertStoreRegistration();
                    if (!string.IsNullOrEmpty(storeSaveResult))
                    {
                        DocMessage.MsgError("Failed to save selected store: " + storeSaveResult);
                        return false;
                    }

                    _hasStoreRegistration = true;
                    _isNewStoreSelection = false;
                    _localStoreRecordExists = true;
                    ShowStoreData();
                    DocMessage.MsgInformation("Store selection saved successfully.");

                    EnsureStoreInDropdown(
                        objSetup.CloudId,
                        txtStoreName.Text.Trim(),
                        storeCode,
                        true);

                    return true;
                }
            }
            catch (Exception ex)
            {
                DocMessage.MsgError("Store registration failed: " + ex.Message);
                return false;
            }
            finally
            {
                Cursor = Cursors.Arrow;
            }
        }
        private bool ShowData()
        {
            PosDataObject.Setup objSetup = new PosDataObject.Setup();
            objSetup.Connection = SystemVariables.Conn;
            DataTable dt = objSetup.FetchBusinessRegistration();
            _hasBusinessRegistration = dt.Rows.Count > 0;

            if (_hasBusinessRegistration)
            {
                hdID.Text = dt.Rows[0]["CloudId"].ToString();
                string businessName = dt.Rows[0]["Businessname"].ToString();
                txtBusinessName.Text = businessName;
                txtBusinessNameStore.Text = businessName; // Sync both fields
                txtEmail.Text = dt.Rows[0]["Email"].ToString();
                txtPassword.Text = dt.Rows[0]["Password"].ToString();               
                //txtConfirmPassword.Text = dt.Rows[0]["Password"].ToString();
                cloudId = Convert.ToInt32(dt.Rows[0]["CloudId"]);               
                ApplyBusinessModeUI(true, true); // This will show Business Name in Store section
                SetStoreSectionEnabled(true);
                bool storeExists = ShowStoreData();
                if (storeExists)
                {
                    if (int.TryParse(hdStoreID.Text, out var storeId) && storeId > 0)
                    {
                        cmbExistingStores.SelectedValue = storeId;
                    }
                }
                else
                {
                    _ = GetExistingStoreAsync();
                }
            }
            else
            {                
                hdID.Text = string.Empty;
                txtBusinessName.Text = string.Empty;
                txtBusinessNameStore.Text = string.Empty;
                txtEmail.Text = string.Empty;
                txtPassword.Text = string.Empty;
                ApplyBusinessModeUI(false, true); // This will show Business Name in Business Setup section
                SetStoreSectionEnabled(false);
                txtBusinessName.Focus();
            }

            UpdateBusinessControlsState();
            return _hasBusinessRegistration;
        }
        private void chkBusinessExist_Checked(object sender, RoutedEventArgs e)
        {
            // When toggle is checked: Business Name moves to Store section
            // Explicitly hide from Business Setup FIRST and collapse rows
            lblBusinessName.Visibility = Visibility.Collapsed;
            txtBusinessName.Visibility = Visibility.Collapsed;
            if (BusinessSetupGrid != null && BusinessSetupGrid.RowDefinitions.Count > 1)
            {
                BusinessSetupGrid.RowDefinitions[0].Height = new GridLength(0);
                BusinessSetupGrid.RowDefinitions[1].Height = new GridLength(0);
            }
            
            // Then show in Store section and expand rows
            lblBusinessNameStore.Visibility = Visibility.Visible;
            txtBusinessNameStore.Visibility = Visibility.Visible;
            if (gcco223 != null && gcco223.RowDefinitions.Count > 1)
            {
                gcco223.RowDefinitions[0].Height = GridLength.Auto;
                gcco223.RowDefinitions[1].Height = new GridLength(10);
            }
            
            // Apply the rest of the UI changes
            ApplyBusinessModeUI(true, false);
            SetStoreSectionEnabled(false);
            UpdateBusinessControlsState();
        }

        private void chkBusinessExist_Unchecked(object sender, RoutedEventArgs e)
        {
            // When toggle is unchecked: Business Name moves to Business Setup section
            // Explicitly hide from Store section FIRST and collapse rows
            lblBusinessNameStore.Visibility = Visibility.Collapsed;
            txtBusinessNameStore.Visibility = Visibility.Collapsed;
            if (gcco223 != null && gcco223.RowDefinitions.Count > 1)
            {
                gcco223.RowDefinitions[0].Height = new GridLength(0);
                gcco223.RowDefinitions[1].Height = new GridLength(0);
            }
            
            // Then show in Business Setup section and expand rows
            lblBusinessName.Visibility = Visibility.Visible;
            txtBusinessName.Visibility = Visibility.Visible;
            if (BusinessSetupGrid != null && BusinessSetupGrid.RowDefinitions.Count > 1)
            {
                BusinessSetupGrid.RowDefinitions[0].Height = GridLength.Auto;
                BusinessSetupGrid.RowDefinitions[1].Height = new GridLength(10);
            }
            
            // Apply the rest of the UI changes
            ApplyBusinessModeUI(false, false);
            SetStoreSectionEnabled(false);
            UpdateBusinessControlsState();
        }
        private void BtnOK_Click(object sender, RoutedEventArgs e)
        {
            Cursor = Cursors.Wait;
            try
            {
                if (ValidAll())
                {
                    if (SaveData())
                    {
                        Settings.LoadSettingsVariables();
                        if (Settings.DefautInternational == "N")
                            GeneralFunctions.SetCurrencyNDateformat();
                        boolControlChanged = false;
                        CloseKeyboards();
                        DialogResult = true;
                    }
                }
            }
            finally
            {
                Cursor = Cursors.Arrow;
            }
        }

        private void BtnCancel_Click(object sender, RoutedEventArgs e)
        {
            boolControlChanged = false;
            CloseKeyboards();
            DialogResult = false;
        }

        private bool SaveData()
        {

            return true;
        }

        private bool ValidAll()
        {
            return true;
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (boolControlChanged)
            {
                MessageBoxResult DlgResult = new MessageBoxResult();
                DlgResult = DocMessage.MsgSaveChanges();

                if (DlgResult == MessageBoxResult.Yes)
                {
                    if (ValidAll())
                    {
                        if (SaveData())
                        {                           
                            boolControlChanged = false;
                        }
                        else
                            e.Cancel = true;
                    }
                    else
                    {
                        e.Cancel = true;
                    }
                }
                if (DlgResult == MessageBoxResult.Cancel) e.Cancel = true;
            }
        }

        private void Rep2_PreviewMouseLeftButtonDown(object sender, MouseButtonEventArgs e)
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
            if (Settings.UseTouchKeyboardInAdmin == "N") return;
            CloseKeyboards();

            if (!IsAboutFullKybrdOpen)
            {
                fkybrd = new FullKeyboard();

                var location = (sender as DevExpress.Xpf.Editors.TextEdit).PointToScreen(new Point(0, 0));
                fkybrd.Left = GeneralFunctions.fnInt32((SystemParameters.WorkArea.Width - 800) / 2);
                if (location.Y + 35 + 320 > System.Windows.SystemParameters.WorkArea.Height)
                {
                    fkybrd.Top = location.Y - 35 - 320;
                }
                else
                {
                    fkybrd.Top = location.Y + 35;
                }

                fkybrd.Height = 320;
                fkybrd.Width = 800;
                fkybrd.IsWindow = true;
                fkybrd.calledform = this;
                fkybrd.Closing += new System.ComponentModel.CancelEventHandler(FKybrd_Closing);
                fkybrd.Show();
                IsAboutFullKybrdOpen = true;
            }

        }

        private void Full_GotFocusPswd(object sender, RoutedEventArgs e)
        {
            if (Settings.UseTouchKeyboardInAdmin == "N") return;
            CloseKeyboards();

            if (!IsAboutFullKybrdOpen)
            {
                fkybrd = new FullKeyboard();

                var location = (sender as DevExpress.Xpf.Editors.PasswordBoxEdit).PointToScreen(new Point(0, 0));
                fkybrd.Left = GeneralFunctions.fnInt32((SystemParameters.WorkArea.Width - 800) / 2);
                if (location.Y + 35 + 320 > System.Windows.SystemParameters.WorkArea.Height)
                {
                    fkybrd.Top = location.Y - 35 - 320;
                }
                else
                {
                    fkybrd.Top = location.Y + 35;
                }

                fkybrd.Height = 320;
                fkybrd.Width = 800;
                fkybrd.IsWindow = true;
                fkybrd.calledform = this;
                fkybrd.Closing += new System.ComponentModel.CancelEventHandler(FKybrd_Closing);
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

        private void Full_LostFocus(object sender, RoutedEventArgs e)
        {
            CloseKeyboards();
        }

        #region Log

        private string LogFileName()
        {
            return "log_" + DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString().PadLeft(2, '0') + DateTime.Now.Day.ToString().PadLeft(2, '0') + "_"
                   + DateTime.Now.Hour.ToString().PadLeft(2, '0') + DateTime.Now.Minute.ToString().PadLeft(2, '0') + DateTime.Now.Second.ToString().PadLeft(2, '0') + ".txt";
        }

        private string LogFilePath()
        {
            string strfilename = "";
            string strdirpath = "";
            string userpath = "";


            userpath = Environment.GetFolderPath(Environment.SpecialFolder.CommonDocuments);//System.AppDomain.CurrentDomain.BaseDirectory;

            // userpath = Assembly.GetExecutingAssembly().Location;

            //  userpath = userpath.Replace("SchedulerSetup.exe", "");
            if (userpath.EndsWith("\\"))
            {
                userpath = userpath + "XEPOSRetail2020\\Logs";
            }
            else
            {
                userpath = userpath + "\\XEPOSRetail2020\\Logs";
            }

            if (!System.IO.Directory.Exists(userpath))
            {
                Directory.CreateDirectory(userpath);
                strfilename = userpath + "\\" + logF;
            }
            else
            {
                strfilename = userpath + "\\" + logF;
            }


            logP = strfilename;
            return strfilename;
        }

        private void WriteToLogFile(string txt)
        {
            if (logF == "") logF = LogFileName();
            string logP = LogFilePath();

            FileStream fileStrm;
            if (System.IO.File.Exists(logP)) fileStrm = new FileStream(logP, FileMode.Append, FileAccess.Write);
            else fileStrm = new FileStream(logP, FileMode.OpenOrCreate, FileAccess.Write);

            StreamWriter sw = new StreamWriter(fileStrm);
            sw.WriteLine(txt);
            sw.Close();
            fileStrm.Close();
        }




        private string LogFileNameCloud()
        {
            return DateTime.Now.Day.ToString().PadLeft(2, '0') + DateTime.Now.Month.ToString().PadLeft(2, '0') + DateTime.Now.Year.ToString() + ".txt";
        }

        private string LogFilePathCloud()
        {
            string strfilename = "";
            string strdirpath = "";
            string userpath = "";


            userpath = Environment.GetFolderPath(Environment.SpecialFolder.CommonDocuments);


            if (userpath.EndsWith("\\"))
            {
                userpath = userpath + "XEPOSRetail2020\\Cloud";
            }
            else
            {
                userpath = userpath + "\\XEPOSRetail2020\\Cloud";
            }

            if (!System.IO.Directory.Exists(userpath))
            {
                Directory.CreateDirectory(userpath);
                strfilename = userpath + "\\" + logCF;
            }
            else
            {
                strfilename = userpath + "\\" + logCF;
            }


            logCP = strfilename;
            return strfilename;
        }

        private void WriteToCloudFile(string txt)
        {
            if (logCF == "") logCF = LogFileNameCloud();
            string logCP = LogFilePathCloud();

            FileStream fileStrm;
            if (System.IO.File.Exists(logCP)) fileStrm = new FileStream(logCP, FileMode.Append, FileAccess.Write);
            else fileStrm = new FileStream(logCP, FileMode.OpenOrCreate, FileAccess.Write);

            string datetimeprefix = DateTime.Now.Day.ToString().PadLeft(2, '0') + DateTime.Now.Month.ToString().PadLeft(2, '0') + DateTime.Now.Year.ToString() + "-"
                  + DateTime.Now.Hour.ToString().PadLeft(2, '0') + DateTime.Now.Minute.ToString().PadLeft(2, '0') + DateTime.Now.Second.ToString().PadLeft(2, '0');

            if (txt != "") txt = datetimeprefix + " : " + txt;
            StreamWriter sw = new StreamWriter(fileStrm);
            sw.WriteLine(txt);
            sw.Close();
            fileStrm.Close();
        }

        #endregion
        public class ApiResponse
        {
            [JsonProperty("message")]
            public string Message { get; set; }
            [JsonProperty("user")]
            public UserInfo User { get; set; }
            [JsonProperty("access_token")]
            public string Access_Token { get; set; }
            [JsonProperty("token_type")]
            public string Token_Type { get; set; }
        }

        public class UserInfo
        {
            [JsonProperty("id")]
            public int Id { get; set; }
            [JsonProperty("name")]
            public string Name { get; set; }
            [JsonProperty("email")]
            public string Email { get; set; }
            [JsonProperty("created_at")]
            public DateTime Created_At { get; set; }
            [JsonProperty("updated_at")]
            public DateTime Updated_At { get; set; }
        }
        public class CreateUserDto
        {
            public string name { get; set; }
            public string email { get; set; }
            public string password { get; set; }
            public string password_confirmation { get; set; }
        }
        // Add this at the class level (static so it persists)
        private static DataTable _storeTable;

        // Modified method
        private async Task GetExistingStoreAsync(bool forceRefresh = false)
        {
            try
            {
                // Only fetch once (if static table not yet loaded)
                if (forceRefresh || _storeTable == null || _storeTable.Rows.Count == 1)
                {
                    using (var _httpClient = new HttpClient())
                    {
                        _httpClient.DefaultRequestHeaders.Clear();
                        _httpClient.DefaultRequestHeaders.Add("Accept", "application/json");
                        _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", _authToken);

                        var apiUrl = apiBaseUrl + "/stores";
                        var response = await _httpClient.GetAsync(apiUrl);

                        if (response.IsSuccessStatusCode)
                        {
                            var jsonResponse = await response.Content.ReadAsStringAsync();
                            
                            // Configure JSON deserializer to handle null values
                            var settings = new JsonSerializerSettings
                            {
                                NullValueHandling = NullValueHandling.Ignore,
                                DefaultValueHandling = DefaultValueHandling.Ignore
                            };
                            
                            StoresApiResponse apiResult = null;
                            try
                            {
                                apiResult = JsonConvert.DeserializeObject<StoresApiResponse>(jsonResponse, settings);
                            }
                            catch (JsonException ex)
                            {
                                WriteToCloudFile("Error deserializing stores response: " + ex.Message + " - Response: " + jsonResponse);
                                Console.WriteLine("Error deserializing stores: " + ex.Message);
                                return;
                            }
                            
                            var stores = apiResult?.data?.data ?? new List<Store>();

                            // Initialize DataTable structure
                            _storeTable = new DataTable();
                            _storeTable.Columns.Add("id", typeof(int));
                            _storeTable.Columns.Add("store_name", typeof(string));
                            _storeTable.Columns.Add("store_code", typeof(string));

                            // Fill DataTable - handle null store_code values
                            foreach (var store in stores)
                            {
                                try
                                {
                                    // Convert store_code to string, handling null values
                                    string storeCodeValue = store.store_code?.ToString() ?? string.Empty;
                                    string storeName = store.store_name ?? string.Empty;
                                    _storeTable.Rows.Add(store.id, storeName, storeCodeValue);
                                }
                                catch (Exception ex)
                                {
                                    WriteToCloudFile("Error adding store to table: " + ex.Message + " - Store ID: " + store.id);
                                    Console.WriteLine("Error adding store: " + ex.Message);
                                }
                            }

                            EnsurePlaceholderRow();
                        }
                        else
                        {
                            _authToken = "";
                            Console.WriteLine("Failed to fetch stores. Status code: " + response.StatusCode);
                        }
                    }
                }

                if (_storeTable != null)
                {
                    var previousSelection = cmbExistingStores.SelectedValue;
                    cmbExistingStores.ItemsSource = _storeTable.DefaultView;
                    // Set the display member (what the user will see)
                    cmbExistingStores.DisplayMemberPath = "store_name";
                    // Set the value member (the underlying value of the selected item)
                    cmbExistingStores.SelectedValuePath = "id";

                    if (int.TryParse(hdStoreID.Text, out var storeId) && storeId > 0)
                    {
                        cmbExistingStores.SelectedValue = storeId;
                    }
                    else if (previousSelection != null)
                    {
                        cmbExistingStores.SelectedValue = previousSelection;
                    }
                }


            }
            catch (Exception ex)
            {
                Console.WriteLine("Exception: " + ex.Message);
            }
        }

        private string InsertEmployeeFromCloudUser(UserInfo user)
        {
            if (user == null || user.Id <= 0)
            {
                return "Cloud user data was not returned from registration.";
            }

            try
            {
                EnsureEmployeeTypeColumnExists();

                string firstName;
                string lastName;
                SplitCloudUserName(user.Name, out firstName, out lastName);

                string employeeId = BuildCloudEmployeeId(user.Id);
                string email = (user.Email ?? string.Empty).Trim();
                if (email.Length > 60)
                {
                    email = email.Substring(0, 60);
                }

                PosDataObject.Employee objEmployee = new PosDataObject.Employee();
                objEmployee.Connection = SystemVariables.Conn;

                if (objEmployee.DuplicateCount(employeeId) > 0)
                {
                    WriteToCloudFile("Cloud employee already exists for EmployeeID=" + employeeId);
                    return "";
                }

                int profileId = 0;
                int empShift = 0;
                double empRate = 0;
                string includeInAppointmentBook = "N";
                string forcedPasscode = "N";
                string locked = "N";
                string adminPassword = "";
                string emergencyContact = "";
                string address1 = "";
                string address2 = "";
                string city = "";
                string state = "";
                string zip = "";
                string phone1 = "";
                string phone2 = "";
                string emergencyPhone = "";
                string ssNumber = "";
                string storeCode = Settings.StoreCode ?? "";

                ApplyExistingEmployeeDefaults(
                    ref profileId, ref empShift, ref empRate,
                    ref includeInAppointmentBook, ref forcedPasscode, ref locked, ref adminPassword,
                    ref emergencyContact, ref address1, ref address2, ref city, ref state, ref zip,
                    ref phone1, ref phone2, ref emergencyPhone, ref ssNumber, ref storeCode);

                if (profileId <= 0)
                {
                    profileId = GetFirstSecurityGroupId();
                }
                if (empShift <= 0)
                {
                    empShift = GetFirstShiftId();
                }

                // Re-bind connection after DuplicateCount / lookups may have closed it.
                objEmployee.Connection = SystemVariables.Conn;

                objEmployee.LoginUserID = SystemVariables.CurrentUserID;
                objEmployee.EmployeeID = employeeId;
                objEmployee.FirstName = Truncate(firstName, 20);
                objEmployee.LastName = Truncate(lastName, 20);
                objEmployee.EMail = email;
                objEmployee.EmergencyContact = emergencyContact ?? "";
                objEmployee.Address1 = address1 ?? "";
                objEmployee.Address2 = address2 ?? "";
                objEmployee.City = city ?? "";
                objEmployee.State = state ?? "";
                objEmployee.Zip = zip ?? "";
                objEmployee.Phone1 = phone1 ?? "";
                objEmployee.Phone2 = phone2 ?? "";
                objEmployee.EmergencyPhone = emergencyPhone ?? "";
                objEmployee.SSNumber = ssNumber ?? "";
                objEmployee.EmpPassword = "1111";
                objEmployee.ProfileID = profileId;
                objEmployee.ProfileCRC = 111;
                objEmployee.EmpShift = empShift;
                objEmployee.EmpRate = empRate;
                objEmployee.IncludeInAppointmentBook = string.IsNullOrWhiteSpace(includeInAppointmentBook) ? "N" : includeInAppointmentBook;
                objEmployee.ForcedPasscode = string.IsNullOrWhiteSpace(forcedPasscode) ? "N" : forcedPasscode;
                objEmployee.Locked = string.IsNullOrWhiteSpace(locked) ? "N" : locked;
                objEmployee.AdminPassword = adminPassword ?? "";
                objEmployee.AdminPasswordModifiedOn = Convert.ToDateTime(null);
                objEmployee.EmployeePhoto = null;
                objEmployee.ThisStoreCode = storeCode ?? "";
                objEmployee.EmployeeType = "cloud";
                objEmployee.IsPost = true;
                objEmployee.CloudId = GetCloudIdFromEmployeeId(employeeId, user.Id);

                string insertErr = objEmployee.InsertData();
                if (string.IsNullOrEmpty(insertErr))
                {
                    WriteToCloudFile("Cloud employee created: EmployeeID=" + employeeId + ", CloudId=" + objEmployee.CloudId + ", isPost=1, Name=" + firstName + " " + lastName + ", Email=" + email);
                }
                return insertErr;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

        private void EnsureEmployeeTypeColumnExists()
        {
            try
            {
                using (var connection = new SqlConnection(SystemVariables.ConnectionString))
                {
                    connection.Open();
                    using (var checkCmd = new SqlCommand(
                        "SELECT COL_LENGTH('dbo.Employee', 'EmployeeType')", connection))
                    {
                        object result = checkCmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                        {
                            return;
                        }
                    }

                    using (var alterCmd = new SqlCommand(
                        "ALTER TABLE [dbo].[Employee] ADD [EmployeeType] NVARCHAR(10) NULL CONSTRAINT DF_Employee_EmployeeType DEFAULT ('till')",
                        connection))
                    {
                        alterCmd.ExecuteNonQuery();
                    }

                    using (var updateCmd = new SqlCommand(
                        "UPDATE [dbo].[Employee] SET [EmployeeType] = 'till' WHERE [EmployeeType] IS NULL OR LTRIM(RTRIM([EmployeeType])) = ''",
                        connection))
                    {
                        updateCmd.ExecuteNonQuery();
                    }
                }

                PosDataObject.Employee.ResetEmployeeTypeColumnCache();
            }
            catch (Exception ex)
            {
                WriteToCloudFile("EnsureEmployeeTypeColumnExists failed: " + ex.Message);
            }
        }

        private static void SplitCloudUserName(string fullName, out string firstName, out string lastName)
        {
            firstName = "";
            lastName = "Cloud";

            if (string.IsNullOrWhiteSpace(fullName))
            {
                firstName = "Cloud";
                return;
            }

            string[] parts = fullName.Trim().Split(new[] { ' ' }, 2, StringSplitOptions.RemoveEmptyEntries);
            firstName = parts[0];
            if (parts.Length > 1 && !string.IsNullOrWhiteSpace(parts[1]))
            {
                lastName = parts[1].Trim();
            }
        }

        private static string BuildCloudEmployeeId(int cloudUserId)
        {
            string employeeId = "C" + cloudUserId;
            if (employeeId.Length > 12)
            {
                employeeId = cloudUserId.ToString();
                if (employeeId.Length > 12)
                {
                    employeeId = employeeId.Substring(employeeId.Length - 12);
                }
            }
            return employeeId;
        }

        private static int GetCloudIdFromEmployeeId(string employeeId, int fallbackCloudUserId)
        {
            if (!string.IsNullOrWhiteSpace(employeeId)
                && employeeId.StartsWith("C", StringComparison.OrdinalIgnoreCase)
                && int.TryParse(employeeId.Substring(1), out int parsedCloudId))
            {
                return parsedCloudId;
            }

            return fallbackCloudUserId;
        }

        private static string Truncate(string value, int maxLength)
        {
            if (string.IsNullOrEmpty(value))
            {
                return "";
            }
            return value.Length <= maxLength ? value : value.Substring(0, maxLength);
        }

        private void ApplyExistingEmployeeDefaults(
            ref int profileId, ref int empShift, ref double empRate,
            ref string includeInAppointmentBook, ref string forcedPasscode, ref string locked, ref string adminPassword,
            ref string emergencyContact, ref string address1, ref string address2, ref string city, ref string state, ref string zip,
            ref string phone1, ref string phone2, ref string emergencyPhone, ref string ssNumber, ref string storeCode)
        {
            const string sql = @"SELECT TOP 1 ProfileID, EmpShift, EmpRate, IncludeInAppointmentBook, ForcedPasscode, Locked,
                AdminPassword, EmergencyContact, Address1, Address2, City, State, Zip, Phone1, Phone2, EmergencyPhone, SSNumber,
                IssueStore, OperateStore
                FROM Employee ORDER BY ID";

            try
            {
                using (var connection = new SqlConnection(SystemVariables.ConnectionString))
                using (var command = new SqlCommand(sql, connection))
                {
                    connection.Open();
                    using (var reader = command.ExecuteReader())
                    {
                        if (!reader.Read())
                        {
                            return;
                        }

                        profileId = reader["ProfileID"] == DBNull.Value ? 0 : Convert.ToInt32(reader["ProfileID"]);
                        empShift = reader["EmpShift"] == DBNull.Value ? 0 : Convert.ToInt32(reader["EmpShift"]);
                        empRate = reader["EmpRate"] == DBNull.Value ? 0 : Convert.ToDouble(reader["EmpRate"]);
                        includeInAppointmentBook = reader["IncludeInAppointmentBook"] == DBNull.Value ? "N" : reader["IncludeInAppointmentBook"].ToString();
                        forcedPasscode = reader["ForcedPasscode"] == DBNull.Value ? "N" : reader["ForcedPasscode"].ToString();
                        locked = reader["Locked"] == DBNull.Value ? "N" : reader["Locked"].ToString();
                        adminPassword = reader["AdminPassword"] == DBNull.Value ? "" : reader["AdminPassword"].ToString();
                        emergencyContact = reader["EmergencyContact"] == DBNull.Value ? "" : reader["EmergencyContact"].ToString();
                        address1 = reader["Address1"] == DBNull.Value ? "" : reader["Address1"].ToString();
                        address2 = reader["Address2"] == DBNull.Value ? "" : reader["Address2"].ToString();
                        city = reader["City"] == DBNull.Value ? "" : reader["City"].ToString();
                        state = reader["State"] == DBNull.Value ? "" : reader["State"].ToString();
                        zip = reader["Zip"] == DBNull.Value ? "" : reader["Zip"].ToString();
                        phone1 = reader["Phone1"] == DBNull.Value ? "" : reader["Phone1"].ToString();
                        phone2 = reader["Phone2"] == DBNull.Value ? "" : reader["Phone2"].ToString();
                        emergencyPhone = reader["EmergencyPhone"] == DBNull.Value ? "" : reader["EmergencyPhone"].ToString();
                        ssNumber = reader["SSNumber"] == DBNull.Value ? "" : reader["SSNumber"].ToString();

                        string issueStore = reader["IssueStore"] == DBNull.Value ? "" : reader["IssueStore"].ToString();
                        if (!string.IsNullOrWhiteSpace(issueStore))
                        {
                            storeCode = issueStore;
                        }
                        else if (string.IsNullOrWhiteSpace(storeCode))
                        {
                            string operateStore = reader["OperateStore"] == DBNull.Value ? "" : reader["OperateStore"].ToString();
                            if (!string.IsNullOrWhiteSpace(operateStore))
                            {
                                storeCode = operateStore;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                WriteToCloudFile("Failed to load employee defaults: " + ex.Message);
            }
        }

        private int GetFirstSecurityGroupId()
        {
            try
            {
                PosDataObject.Security objSecurity = new PosDataObject.Security();
                objSecurity.Connection = SystemVariables.Conn;
                DataTable profiles = objSecurity.FetchData();
                if (profiles != null && profiles.Rows.Count > 0)
                {
                    return GeneralFunctions.fnInt32(profiles.Rows[0]["ID"].ToString());
                }
            }
            catch (Exception ex)
            {
                WriteToCloudFile("Failed to load security profile default: " + ex.Message);
            }
            return 0;
        }

        private int GetFirstShiftId()
        {
            try
            {
                PosDataObject.Shift objShift = new PosDataObject.Shift();
                objShift.Connection = SystemVariables.Conn;
                DataTable shifts = objShift.FetchData();
                if (shifts != null && shifts.Rows.Count > 0)
                {
                    return GeneralFunctions.fnInt32(shifts.Rows[0]["ID"].ToString());
                }
            }
            catch (Exception ex)
            {
                WriteToCloudFile("Failed to load shift default: " + ex.Message);
            }
            return 0;
        }

        private async void btnRegisterBusiness_Click(object sender, RoutedEventArgs e)
        {
            var isLoginAction = string.Equals(btnRegisterBusiness.Content?.ToString(), "Login", StringComparison.OrdinalIgnoreCase);

            if (isLoginAction)
            {
                if (string.IsNullOrWhiteSpace(txtEmail.Text) || string.IsNullOrWhiteSpace(txtPassword.Text))
                {
                    DocMessage.MsgWarning("Please enter both email and password to login.");
                    return;
                }

                await LoginAsync(true);
            }
            else
            {
                if (string.IsNullOrWhiteSpace(txtBusinessName.Text))
                {
                    DocMessage.MsgWarning("Business name is required.");
                    return;
                }
                if (string.IsNullOrWhiteSpace(txtEmail.Text))
                {
                    DocMessage.MsgWarning("Email is required.");
                    return;
                }
                if (string.IsNullOrWhiteSpace(txtPassword.Text))
                {
                    DocMessage.MsgWarning("Password is required.");
                    return;
                }

                Cursor = Cursors.Wait;
                var client = new HttpClient();
                var apiUrl = apiBaseUrl+"/register";
                //var apiUrl = "https://api-retail.xepos.net/api/v1/register"; // Ensure this is the correct login API URL

                // Register Business Data
                var registerBusiness = new
                {
                    name = txtBusinessName.Text.Trim(),
                    email = txtEmail.Text.Trim(),
                    password = txtPassword.Text.Trim(),
                    password_confirmation = txtPassword.Text.Trim()
                };

                var jsonContent = new StringContent(
                    JsonConvert.SerializeObject(registerBusiness),
                    Encoding.UTF8,
                    "application/json"
                );

                // Set the headers for the login request
                client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));

                try
                {
                    // Send POST request to the login API
                    var response = await client.PostAsync(apiUrl, jsonContent);

                    //// Check if the request was successful
                    if (response.IsSuccessStatusCode)
                    {
                        var result = await response.Content.ReadAsStringAsync();
                        var apiResponseResult = JsonConvert.DeserializeObject<ApiResponse>(result);
                        if (apiResponseResult == null)
                        {
                            DocMessage.MsgError("Business registration succeeded but the cloud response could not be read.");
                            return;
                        }

                        // Fallback if user payload did not deserialize
                        if (apiResponseResult.User == null || apiResponseResult.User.Id <= 0)
                        {
                            try
                            {
                                var jo = JObject.Parse(result);
                                var userToken = jo["user"] ?? jo["User"];
                                if (userToken != null)
                                {
                                    apiResponseResult.User = userToken.ToObject<UserInfo>();
                                }
                            }
                            catch (Exception parseEx)
                            {
                                WriteToCloudFile("Failed to parse register user payload: " + parseEx.Message + " Response: " + result);
                            }
                        }

                        if (apiResponseResult.User == null || apiResponseResult.User.Id <= 0)
                        {
                            DocMessage.MsgError("Business registration succeeded but cloud user data was missing. Employee was not created.");
                            WriteToCloudFile("Register response missing user: " + result);
                            return;
                        }

                        if (string.IsNullOrWhiteSpace(apiResponseResult.User.Name))
                        {
                            apiResponseResult.User.Name = txtBusinessName.Text.Trim();
                        }
                        if (string.IsNullOrWhiteSpace(apiResponseResult.User.Email))
                        {
                            apiResponseResult.User.Email = txtEmail.Text.Trim();
                        }

                        PosDataObject.Setup objSetup = new PosDataObject.Setup();
                        objSetup.Connection = SystemVariables.Conn;
                        objSetup.Businessname = txtBusinessName.Text.Trim();
                        objSetup.BusEmail = txtEmail.Text.Trim();
                        objSetup.Password = txtPassword.Text.Trim();
                        objSetup.LoginUserID = SystemVariables.CurrentUserID;
                        objSetup.CloudId = apiResponseResult.User.Id;
                        objSetup.Token = apiResponseResult.Access_Token;
                        objSetup.BaseURL = apiBaseUrl;
                        string strErr = objSetup.InsertBusinessRegistration();
                        if (strErr == "")
                        {
                            hdID.Text = apiResponseResult.User.Id.ToString();
                            cloudId = apiResponseResult.User.Id;
                            _authToken = apiResponseResult.Access_Token ?? string.Empty;
                        _hasBusinessRegistration = true;
                        _authToken = apiResponseResult.Access_Token ?? string.Empty;

                        string empErr = InsertEmployeeFromCloudUser(apiResponseResult.User);
                        if (!string.IsNullOrEmpty(empErr))
                        {
                            WriteToCloudFile("Cloud user employee insert failed: " + empErr);
                            DocMessage.MsgWarning("Business registered, but cloud employee could not be saved: " + empErr);
                        }

                        ApplyBusinessModeUI(true, true);
                        SetStoreSectionEnabled(true);
                        _storeTable = null;
                        DocMessage.MsgInformation("Business registered successfully.");
                        UpdateBusinessControlsState(); // Update button text to "Logged In"
                        ShowStoreData();
                        await GetExistingStoreAsync(true);
                        }
                        else
                        {
                            DocMessage.MsgError("Business registered but failed to save locally: " + strErr);
                        }

                    }
                    else
                    {
                        // Log the error status
                        var errorMessage = await response.Content.ReadAsStringAsync();
                        var friendly = FormatApiError(errorMessage, "Business registration failed. Please check the details and try again.");
                        DocMessage.MsgError(friendly);
                    }
                }
                catch (Exception ex)
                {
                    DocMessage.MsgError("Business registration failed: " + ex.Message);
                }
                finally
                {
                    Cursor = Cursors.Arrow;
                }
            }
        }
        
        private async Task LoginAsync(bool showSuccessMessage = false)
        {

            try
            {
                Cursor = Cursors.Wait;
            var client = new HttpClient();
                var apiUrl = apiBaseUrl + "/login";
                //var apiUrl = "https://api-retail.xepos.net/api/v1" + "/login";

                if (apiUrl != "")
            {
                // Create login data (email and password)
                var loginData = new
                {
                    email = txtEmail.Text, // Replace with the actual email
                    password = txtPassword.Text     // Replace with the actual password
                };

                var jsonContent = new StringContent(
                    JsonConvert.SerializeObject(loginData),
                    Encoding.UTF8,
                    "application/json"
                );

                // Set the headers for the login request
                client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));

                try
                {
                    // Send POST request to the login API
                    var response = await client.PostAsync(apiUrl, jsonContent);

                    // Check if the request was successful
                    if (response.IsSuccessStatusCode)
                    {
                        var result = await response.Content.ReadAsStringAsync();
                        //Console.WriteLine("Login successful. Response: " + result); // Log the response
                        var resultresponse = JsonConvert.DeserializeObject<TokenResponse>(result);
                        _authToken = resultresponse.Access_Token;
                        if (txtBusinessName.Text.Trim() == "")
                        {
                            PosDataObject.Setup objSetup = new PosDataObject.Setup();
                            objSetup.Connection = SystemVariables.Conn;
                            objSetup.Businessname = resultresponse.User.Name;
                            objSetup.BusEmail = resultresponse.User.Email;
                            objSetup.Password = txtPassword.Text.Trim();
                            objSetup.LoginUserID = SystemVariables.CurrentUserID;
                            objSetup.CloudId = resultresponse.User.Id;
                            objSetup.Token = resultresponse.Access_Token;
                            objSetup.BaseURL = apiBaseUrl;
                            string strErr = objSetup.InsertBusinessRegistration();
                        }
                        
                        _hasBusinessRegistration = true;
                        _storeTable = null;
                        ApplyBusinessModeUI(true, true);
                        SetStoreSectionEnabled(true);
                        UpdateBusinessControlsState(); // Update button text to "Logged In"
                        if (showSuccessMessage)
                        {
                            DocMessage.MsgInformation("Login successful.");
                        }
                        await GetExistingStoreAsync(true);
                        ShowStoreData();
                        ShowData();
                    }
                    else
                    {
                        var errorMessage = await response.Content.ReadAsStringAsync();
                        var friendly = FormatApiError(errorMessage, "Login failed. Please verify your email and password.");
                        DocMessage.MsgError(friendly);
                    }
                }
                catch (Exception ex)
                {
                    // Handle any exception that might occur during the HTTP request
                    DocMessage.MsgError("Login failed: " + ex.Message);
                }
            }
            else
            {
                _authToken = "";
            }
            }
            finally
            {
                Cursor = Cursors.Arrow;
            }
        }
        //private async void RegisterBusinessAsync()
        //{
        //    frm_XEPOSStoreRegistrationDlg frm_RegistrationDlg = new frm_XEPOSStoreRegistrationDlg();
        //    try
        //    {
                
        //        frm_RegistrationDlg.Email = txtEmail.Text.Trim();
        //        frm_RegistrationDlg.Password = txtPassword.Text.Trim();
        //        frm_RegistrationDlg.BusinessName = txtBusinessName.Text.Trim();
        //        frm_RegistrationDlg.third_party_id = cloudId.ToString();
        //        frm_RegistrationDlg.BusinessId = Convert.ToInt32(hdID.Text);

        //        frm_RegistrationDlg.FirstTimeCall = false;
        //        this.Close();
        //        frm_RegistrationDlg.ShowDialog();
        //        if (frm_RegistrationDlg.DialogResult == true)
        //        {
        //            if (frm_RegistrationDlg.Registered)
        //            {
        //                DocMessage.MsgInformation("Successful Registration.");
        //                frm_RegistrationDlg.Close();
        //                // Application.Current.Shutdown();
        //            }
        //        }

        //    }
        //    catch
        //    {
        //        //frm_RegistrationDlg.Close();
        //        //(Window.GetWindow(this) as MainWindow).blurGrid.Visibility = Visibility.Collapsed;
        //    }

        //}
        private bool HasCloudSyncedSecurityPermission()
        {
            const string sql = "select * from SecurityPermission where ISNULL(cloudid,0) > 0";
            using (var connection = new SqlConnection(SystemVariables.ConnectionString))
            using (var command = new SqlCommand(sql, connection))
            {
                connection.Open();
                using (var reader = command.ExecuteReader())
                {
                    return reader.HasRows;
                }
            }
        }

        private async void btnLogout_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (HasCloudSyncedSecurityPermission())
                {
                    DocMessage.MsgError("Your data has been successfully synced to the cloud. You cannot log out at this time. Please contact your administrator for assistance.");
                    return;
                }

                // Disconnect store from API before clearing data
                if (_isStoreConnected && !string.IsNullOrEmpty(hdStoreID.Text))
                {
                    if (int.TryParse(hdStoreID.Text, out var storeId))
                    {
                        await DisconnectStoreAsync(storeId);
                    }
                }
                
                ClearBusinessAndStoreData();
            }
            catch (Exception ex)
            {
                DocMessage.MsgError("Logout failed: " + ex.Message);
                return;
            }

            _authToken = string.Empty;
            _storeTable = null;
            _hasBusinessRegistration = false;
            _hasStoreRegistration = false;
            ApplyConnectedState(false);
            SetStoreSectionEnabled(false);
            ApplyBusinessModeUI(false, true);
            
            // Clear Business Name fields after logout
            txtBusinessName.Text = string.Empty;
            txtBusinessNameStore.Text = string.Empty;
            
            LoadFormData();
            
            DocMessage.MsgInformation("Logged out successfully.");
        }
        
        private async Task DisconnectStoreAsync(int storeId)
        {
            try
            {
                // Get MAC address
                string macAddress = GetMacAddress();
                if (string.IsNullOrEmpty(macAddress))
                {
                    WriteToCloudFile("Store Disconnect: Unable to retrieve MAC address");
                    return; // Continue with logout even if MAC address retrieval fails
                }

                // Validate auth token
                if (string.IsNullOrEmpty(_authToken))
                {
                    WriteToCloudFile("Store Disconnect: No auth token available");
                    return; // Continue with logout even if no token
                }

                Cursor = Cursors.Wait;

                // Call Store Disconnect API
                using (var client = new HttpClient())
                {
                    client.DefaultRequestHeaders.Clear();
                    client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", _authToken);
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                    var apiUrl = apiBaseUrl + "/store/disconnect";

                    // Prepare request data
                    var disconnectData = new
                    {
                        store_id = storeId,
                        device_id = macAddress
                    };

                    var jsonContent = new StringContent(
                        JsonConvert.SerializeObject(disconnectData),
                        Encoding.UTF8,
                        "application/json"
                    );

                    // Send POST request to disconnect store API
                    var response = await client.PostAsync(apiUrl, jsonContent);

                    if (response.IsSuccessStatusCode)
                    {
                        var result = await response.Content.ReadAsStringAsync();
                        WriteToCloudFile("Store Disconnected - MAC: " + macAddress + ", Store ID: " + storeId);
                    }
                    else
                    {
                        var errorMessage = await response.Content.ReadAsStringAsync();
                        WriteToCloudFile("Store Disconnect API Error - " + response.StatusCode + ": " + errorMessage);
                    }
                }
            }
            catch (Exception ex)
            {
                WriteToCloudFile("Store Disconnect Exception - " + ex.Message);
                // Don't throw - allow logout to continue even if disconnect fails
            }
            finally
            {
                Cursor = Cursors.Arrow;
            }
        }

        private async void btnRegisterStore_Click(object sender, RoutedEventArgs e)
        {
            // Combined button logic: First register store (if new), then connect store
            bool hasStoredStore = !string.IsNullOrWhiteSpace(hdStoreID.Text);
            bool isNewStore = _isNewStoreSelection || !hasStoredStore;
            bool needsLocalRecord = !_localStoreRecordExists;
            
            if (isNewStore || needsLocalRecord)
            {
                // First, register the store
                var saved = await SaveStoreDataAsync();
                if (!saved)
                {
                    return; // Stop if registration failed
                }
                _storeTable = null;
                await GetExistingStoreAsync(true);
                
                // After successful registration, proceed to connect
                hasStoredStore = !string.IsNullOrWhiteSpace(hdStoreID.Text);
                _localStoreRecordExists = true;
            }
            
            // Then connect the store (if we have a store ID)
            if (hasStoredStore && !_isStoreConnected)
            {
                await ConnectStoreAsync();
            }
        }
        
        private async Task ConnectStoreAsync()
        {
            try
            {
                // Get MAC address
                string macAddress = GetMacAddress();
                if (string.IsNullOrEmpty(macAddress))
                {
                    DocMessage.MsgWarning("Unable to retrieve MAC address. Please check your network connection.");
                    return;
                }

                // Get Store ID
                string storeId = hdStoreID.Text;
                if (string.IsNullOrEmpty(storeId))
                {
                    DocMessage.MsgWarning("Store ID not found. Please register the store first.");
                    return;
                }

                if (!int.TryParse(storeId, out var storeIdValue))
                {
                    DocMessage.MsgWarning("Invalid Store ID. Please verify store details.");
                    return;
                }

                // Validate auth token
                if (string.IsNullOrEmpty(_authToken))
                {
                    await LoginAsync();
                }

                Cursor = Cursors.Wait;
                btnRegisterStore.IsEnabled = false;

                // Call Store Connect API
                using (var client = new HttpClient())
                {
                    client.DefaultRequestHeaders.Clear();
                    client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", _authToken);
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                    var apiUrl = apiBaseUrl + "/store/connect";
                    //var apiUrl = "https://api-retail.xepos.net/api/v1/store/connect";
                    // Prepare request data
                    var connectData = new
                    {
                        store_id = storeIdValue,
                        device_id = macAddress
                    };

                    var jsonContent = new StringContent(
                        JsonConvert.SerializeObject(connectData),
                        Encoding.UTF8,
                        "application/json"
                    );

                    // Send POST request to connect store API
                    var response = await client.PostAsync(apiUrl, jsonContent);

                    if (response.IsSuccessStatusCode)
                    {
                        var result = await response.Content.ReadAsStringAsync();
                        var apiResponseResult = JsonConvert.DeserializeObject<ConnectStoreResponse>(result);

                        string selectedStoreName = txtStoreName.Text.Trim();
                        string selectedStoreCode = selectedStoreName.Replace(" ", "").ToUpper();
                        if (_storeTable != null)
                        {
                            var rows = _storeTable.Select($"id = {storeIdValue}");
                            if (rows.Length > 0)
                            {
                                selectedStoreName = rows[0]["store_name"].ToString();
                                selectedStoreCode = rows[0]["store_code"].ToString();
                            }
                        }

                        if (apiResponseResult != null && apiResponseResult.success)
                        {
                            UpdateStoreConnectionStatus(true, storeIdValue);
                            EnsureStoreInDropdown(storeIdValue, selectedStoreName, selectedStoreCode, true);
                            txtStoreName.Text = selectedStoreName;
                            ApplyConnectedState(true);

                            var successMessage = string.IsNullOrWhiteSpace(apiResponseResult.message)
                                ? "Store connected successfully."
                                : apiResponseResult.message;

                            DocMessage.MsgInformation(successMessage);
                            WriteToCloudFile("Store Connected - " + successMessage + " - MAC: " + macAddress + ", Store ID: " + storeIdValue);

                            ShowStoreData();
                        }
                        else
                        {
                            string errorMsg = apiResponseResult?.message ?? "Unknown error occurred.";
                            UpdateStoreConnectionStatus(false, storeIdValue);
                            ApplyConnectedState(false);
                            DocMessage.MsgError("Failed to connect store: " + errorMsg);
                            WriteToCloudFile("Store Connect Failed - " + errorMsg);
                        }
                    }
                    else
                    {
                        var errorMessage = await response.Content.ReadAsStringAsync();
                        UpdateStoreConnectionStatus(false, storeIdValue);
                        ApplyConnectedState(false);
                        var friendly = FormatApiError(errorMessage, "Store connection failed. Please try again.");
                        DocMessage.MsgError(friendly);
                        WriteToCloudFile("Store Connect API Error - " + response.StatusCode + ": " + errorMessage);
                    }
                }
            }
            catch (Exception ex)
            {
                if (int.TryParse(hdStoreID.Text, out var fallbackStoreId))
                {
                    UpdateStoreConnectionStatus(false, fallbackStoreId);
                }
                DocMessage.MsgError("Exception occurred: " + ex.Message);
                WriteToCloudFile("Store Connect Exception - " + ex.Message);
            }
            finally
            {
                Cursor = Cursors.Arrow;
                RefreshStoreSectionState();
            }
        }
       

        private async void btnLogin_Click(object sender, RoutedEventArgs e)
        {
            await LoginAsync(true);
        }

        private void cmbExistingStores_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            try
            {
                // Get the selected item
                var selectedStore = cmbExistingStores.SelectedItem as DataRowView;

                if (selectedStore != null)
                {
                    var selectedId = Convert.ToInt32(selectedStore["id"]);
                    if (selectedId == NewStorePlaceholderId)
                    {
                        _isNewStoreSelection = true;
                        hdStoreID.Text = string.Empty;
                        txtStoreName.Text = string.Empty;
                        RefreshStoreSectionState();
                        return;
                    }

                    _isNewStoreSelection = false;
                    // Lookup store details from the static DataTable
                    var selectedRows = _storeTable.Select($"id = {selectedStore["id"]}");

                    if (selectedRows.Length > 0)
                    {
                        txtStoreName.Text = selectedStore["store_name"].ToString();
                        hdStoreID.Text = selectedStore["id"].ToString();
                        _hasStoreRegistration = true;
                        RefreshStoreSectionState();
                    }
                }
                else
                {
                    // Reset controls if no store selected
                    txtStoreName.Text = string.Empty;
                }
                            }
            catch (Exception ex)
            {
                Console.WriteLine("Error in cmbExistingStores_EditValueChanged: " + ex.Message);
            }

        }
        /// <summary>
        /// Get the MAC address of the first active network adapter
        /// </summary>
        private string GetMacAddress()
        {
            try
            {
                var networkInterface = NetworkInterface.GetAllNetworkInterfaces()
                    .FirstOrDefault(nic => nic.OperationalStatus == OperationalStatus.Up
                                          && nic.NetworkInterfaceType != NetworkInterfaceType.Loopback
                                          && nic.NetworkInterfaceType != NetworkInterfaceType.Tunnel);

                if (networkInterface != null)
                {
                    var macAddress = networkInterface.GetPhysicalAddress().ToString();
                    // Format MAC address with colons (e.g., AA:BB:CC:DD:EE:FF)
                    if (macAddress.Length == 12)
                    {
                        macAddress = string.Join(":", Enumerable.Range(0, 6)
                            .Select(i => macAddress.Substring(i * 2, 2)));
                    }
                    return macAddress;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error getting MAC address: " + ex.Message);
            }
            return string.Empty;
        }

        private void UpdateStoreConnectionStatus(bool isConnected, int cloudId)
        {
            try
            {
                using (var connection = new SqlConnection(SystemVariables.ConnectionString))
                using (var command = new SqlCommand("UPDATE StoreInfo SET isConnect = @IsConnect, ConnectedDate = @ConnectedDate WHERE CloudID = @CloudId", connection))
                {
                    command.Parameters.Add("@IsConnect", SqlDbType.Bit).Value = isConnected;
                    command.Parameters.Add("@ConnectedDate", SqlDbType.DateTime).Value = isConnected ? (object)DateTime.Now : DBNull.Value;
                    command.Parameters.Add("@CloudId", SqlDbType.Int).Value = cloudId;

                    if (connection.State != ConnectionState.Open)
                    {
                        connection.Open();
                    }

                    command.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                WriteToCloudFile("Store Connect Local Update Failed - " + ex.Message);
            }
        }

        public class ConnectStoreResponse
        {
            public bool success { get; set; }
            public string message { get; set; }
        }

        //public class Store
        //{
        //    public int id { get; set; }
        //    public string third_party_id { get; set; }
        //    public int? store_code { get; set; } // Made nullable to handle null values from API
        //    public string store_name { get; set; }
        //    public object connected_by_device_id { get; set; }
        //    public int is_web { get; set; }
        //    public DateTime created_at { get; set; }
        //    public DateTime updated_at { get; set; }
        //    public object deleted_at { get; set; }
        //}

        public class Store
        {
            public int id { get; set; }
            public string third_party_id { get; set; }
            public int? store_code { get; set; }
            public string store_name { get; set; }
            public string connected_by_device_id { get; set; }
            public bool is_web { get; set; }
            public object portal_settings { get; set; }
            public DateTime created_at { get; set; }
            public DateTime updated_at { get; set; }
            public DateTime? deleted_at { get; set; }
        }

        public class PaginatedStores
        {
            public int current_page { get; set; }
            public List<Store> data { get; set; }
            public string first_page_url { get; set; }
            public int from { get; set; }
            public int last_page { get; set; }
            public string last_page_url { get; set; }
            public string next_page_url { get; set; }
            public string path { get; set; }
            public int per_page { get; set; }
            public string prev_page_url { get; set; }
            public int to { get; set; }
            public int total { get; set; }
        }

        public class StoresApiResponse
        {
            public bool success { get; set; }
            public string message { get; set; }
            public PaginatedStores data { get; set; }
        }

        // Old btnConnectStore_Click method removed - logic moved to ConnectStoreAsync() and called from btnRegisterStore_Click
       
    }
}
