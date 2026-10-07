using OfflineRetailV2.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.IO.Ports;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Windows.Threading;
using WebSocket4Net.Command;

namespace OfflineRetailV2.UserControls.POSSection
{
    /// <summary>
    /// Interaction logic for frmPOSItemDlg.xaml
    /// </summary>
    public partial class frmPOSItemDlg : Window
    {
        public const int WM_COPYDATA = 0x4A;
        public struct COPYDATASTRUCT
        {
            public IntPtr dwData;
            public int cbData;
            public string lpData;
        }

        private string strProductDesc;

        private double intQty;
        private double dblPrice;
        private double dblCost;
        private double dblDiscount;
        private bool blBlankLine;
        private string strTaxExempt;

        private string strTaxID1 = "0";
        private string strTaxID2 = "0";
        private string strTaxID3 = "0";
        private string strTaxName1 = "";
        private string strTaxName2 = "";
        private string strTaxName3 = "";
        private string strTaxRate1 = "0";
        private string strTaxRate2 = "0";
        private string strTaxRate3 = "0";
        private string strTaxApplicable1 = "N";
        private string strTaxApplicable2 = "N";
        private string strTaxApplicable3 = "N";



        private string strServiceType;

        private string strRentType;
        private double dblRentAmt;
        private double dblRentDuration;
        private double dblRepairAmt;

        private string strRepairItemTag;
        private string strRepairItemSL;
        private string strRepairItemPurchase;

        private bool blWeighted;
        private bool blIsEdit;
        private bool blBottleRefund;
        private bool blFuelItem;

        private bool blProceedRentEditingWithoutDuration;

        string strCurrentServiceType = "";
        private string weightstring = "";

        private int intSelectedTaxID1;
        private int intSelectedTaxID2;
        private int intSelectedTaxID3;

        private string strWeightedUOM;
        private int intProductID;

        NumKeyboard nkybrd;
        bool IsAboutNumKybrdOpen = false;

        FullKeyboard fkybrd;
        bool IsAboutFullKybrdOpen = false;

        private bool _isModernUi;
        private enum ModernKeypadTarget { Weight, Price, Cost, Discount }
        private ModernKeypadTarget _keypadTarget = ModernKeypadTarget.Price;
        private decimal _keypadValue = 0m;
        private int _keypadDecimals = 2;
        private decimal _weightValue = 0m;
        private decimal _priceValue = 0m;
        private decimal _costValue = 0m;
        private decimal _discountValue = 0m;
        private const long MaxKeypadUnits = 999999999999;

        private static bool IsLiveWeightLocked
        {
            get { return Settings.ScaleDevice == "Live Weight"; }
        }

        public string WeightedUOM
        {
            get { return strWeightedUOM; }
            set { strWeightedUOM = value; }
        }

        public int ProductID
        {
            get { return intProductID; }
            set { intProductID = value; }
        }

        public int SelectedTaxID1
        {
            get { return intSelectedTaxID1; }
            set { intSelectedTaxID1 = value; }
        }

        public int SelectedTaxID2
        {
            get { return intSelectedTaxID2; }
            set { intSelectedTaxID2 = value; }
        }

        public int SelectedTaxID3
        {
            get { return intSelectedTaxID3; }
            set { intSelectedTaxID3 = value; }
        }

        private bool blTaxChangeFlag;

        public bool TaxChangeFlag
        {
            get { return blTaxChangeFlag; }
            set { blTaxChangeFlag = value; }
        }


        public bool bProceedRentEditingWithoutDuration
        {
            get { return blProceedRentEditingWithoutDuration; }
            set { blProceedRentEditingWithoutDuration = value; }
        }

        public string ServiceType
        {
            get { return strServiceType; }
            set { strServiceType = value; }
        }

        public string RentType
        {
            get { return strRentType; }
            set
            {
                strRentType = value;
                strCurrentServiceType = strRentType;
                SetRentTypeButtonColor();
            }
        }

        public string RepairItemTag
        {
            get { return strRepairItemTag; }
            set { strRepairItemTag = value; }
        }

        public string RepairItemSL
        {
            get { return strRepairItemSL; }
            set { strRepairItemSL = value; }
        }

        public string RepairItemPurchase
        {
            get { return strRepairItemPurchase; }
            set { strRepairItemPurchase = value; }
        }

        public bool IsEdit
        {
            get { return blIsEdit; }
            set { blIsEdit = value; }
        }

        public bool FuelItem
        {
            get { return blFuelItem; }
            set { blFuelItem = value; }
        }

        public bool Weighted
        {
            get { return blWeighted; }
            set { blWeighted = value; }
        }

        public double RentAmt
        {
            get { return dblRentAmt; }
            set { dblRentAmt = value; }
        }

        public double RentDuration
        {
            get { return dblRentDuration; }
            set { dblRentDuration = value; }
        }

        public double RepairAmt
        {
            get { return dblRepairAmt; }
            set { dblRepairAmt = value; }
        }
        public string TaxID1
        {
            get { return strTaxID1; }
            set { strTaxID1 = value; }
        }

        public string TaxID2
        {
            get { return strTaxID2; }
            set { strTaxID2 = value; }
        }

        public string TaxID3
        {
            get { return strTaxID3; }
            set { strTaxID3 = value; }
        }

        public string TaxName1
        {
            get { return strTaxName1; }
            set { strTaxName1 = value; }
        }

        public string TaxName2
        {
            get { return strTaxName2; }
            set { strTaxName2 = value; }
        }

        public string TaxName3
        {
            get { return strTaxName3; }
            set { strTaxName3 = value; }
        }

        public string TaxRate1
        {
            get { return strTaxRate1; }
            set { strTaxRate1 = value; }
        }

        public string TaxRate2
        {
            get { return strTaxRate2; }
            set { strTaxRate2 = value; }
        }

        public string TaxRate3
        {
            get { return strTaxRate3; }
            set { strTaxRate3 = value; }
        }

        public string TaxApplicable1
        {
            get { return strTaxApplicable1; }
            set { strTaxApplicable1 = value; }
        }

        public string TaxApplicable2
        {
            get { return strTaxApplicable2; }
            set { strTaxApplicable2 = value; }
        }

        public string TaxApplicable3
        {
            get { return strTaxApplicable3; }
            set { strTaxApplicable3 = value; }
        }


        public bool BlankLine
        {
            get { return blBlankLine; }
            set { blBlankLine = value; }
        }

        public bool BottleRefund
        {
            get { return blBottleRefund; }
            set { blBottleRefund = value; }
        }

        public string TaxExempt
        {
            get { return strTaxExempt; }
            set { strTaxExempt = value; }
        }

        public string ProductDesc
        {
            get { return strProductDesc; }
            set { strProductDesc = value; }
        }
        public double Qty
        {
            get { return intQty; }
            set { intQty = value; }
        }
        public double Price
        {
            get { return dblPrice; }
            set { dblPrice = value; }
        }
        public double Cost
        {
            get { return dblCost; }
            set { dblCost = value; }
        }

        public double Discount
        {
            get { return dblDiscount; }
            set { dblDiscount = value; }
        }
        public frmPOSItemDlg()
        {
            InitializeComponent();
            ModalWindow.CloseCommand = new CommandBase(OnClose);
        }

        public new bool? ShowDialog()
        {
            PrepareUiBeforeShow();
            return base.ShowDialog();
        }

        protected override void OnSourceInitialized(EventArgs e)
        {
            PrepareUiBeforeShow();
            base.OnSourceInitialized(e);
        }

        private void PrepareUiBeforeShow()
        {
            if (strServiceType == "Sales" && (blWeighted || blBlankLine))
            {
                ApplyModernShell();
            }
            else
            {
                gridClassic.Visibility = Visibility.Visible;
                gridModern.Visibility = Visibility.Collapsed;
            }
        }

        private void OnClose(object obj)
        {
            DialogResult = false;
            StopListeningToScale();
            CloseKeyboards();
            ResMan.closeKeyboard();
            Close();
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
            if (_isModernUi && sender != txtModernProduct) return;
            if (Settings.UseTouchKeyboardInPOS == "N") return;
            if (!TryGetScreenLocation(sender, out Point location)) return;
            CloseKeyboards();

            if (!IsAboutFullKybrdOpen)
            {
                fkybrd = new FullKeyboard();

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







        private void Num_LostFocus(object sender, RoutedEventArgs e)
        {
            CloseKeyboards();
        }

        private void Num_GotFocus(object sender, RoutedEventArgs e)
        {
            if (_isModernUi) return;
            if (sender == txtQty && IsLiveWeightLocked) return;
            if (Settings.UseTouchKeyboardInPOS == "N") return;
            if (!TryGetScreenLocation(sender, out Point location)) return;
            CloseKeyboards();

            Dispatcher.BeginInvoke(new Action(() =>
            {
                var edit = sender as DevExpress.Xpf.Editors.TextEdit;
                if (edit != null) edit.SelectAll();
            }));


            if (!IsAboutNumKybrdOpen)
            {
                nkybrd = new NumKeyboard();

                nkybrd.Left = location.X + 385 <= System.Windows.SystemParameters.WorkArea.Width ? location.X : location.X - (location.X + 385 - System.Windows.SystemParameters.WorkArea.Width);
                if (location.Y + 35 + 270 > System.Windows.SystemParameters.WorkArea.Height)
                {
                    nkybrd.Top = location.Y - 270;
                }
                else
                {
                    nkybrd.Top = location.Y + 35;
                }

                nkybrd.Height = 270;
                nkybrd.Width = 385;
                nkybrd.IsWindow = true;
                nkybrd.CalledForm = this;
                nkybrd.Closing += new System.ComponentModel.CancelEventHandler(NKybrd_Closing);
                nkybrd.Show();
                IsAboutNumKybrdOpen = true;
            }
        }

        private bool TryGetScreenLocation(object sender, out Point location)
        {
            location = new Point();
            Visual visual = sender as Visual;
            if (visual == null) return false;
            if (PresentationSource.FromVisual(visual) == null) return false;
            try
            {
                location = visual.PointToScreen(new Point(0, 0));
                return true;
            }
            catch (InvalidOperationException)
            {
                return false;
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

        private void btnWeight_Click(object sender, RoutedEventArgs e)
        {
            if (Settings.COMPort != "(None)")
            {
                string strfilename = "";
                strfilename = Environment.CurrentDirectory;
                if (strfilename.EndsWith("\\"))
                {
                    strfilename = strfilename + "Weight.exe";
                }
                else
                {
                    strfilename = strfilename + "\\Weight.exe";
                }
                if (!System.IO.File.Exists(strfilename)) return;
                System.Diagnostics.Process p = new System.Diagnostics.Process();
                p.StartInfo.FileName = strfilename;
                p.Start();

            }
        }

        private void btnKeyboard_Click(object sender, RoutedEventArgs e)
        {
            ResMan.ShowFullKeyboard();
        }

        private void btnHelp_Click(object sender, RoutedEventArgs e)
        {
            if (btnHelp.Tag.ToString() == "")
            {
                new MessageBoxWindow().Show( Properties.Resources.This_help_topic_is_currently_not_available_, "POS Help", MessageBoxButton.OK, MessageBoxImage.Information);
                return;
            }
            else
            {
                string ret = GeneralFunctions.IsHelpFileExists(btnHelp.Tag.ToString());
                if (ret == "")
                {
                    new MessageBoxWindow().Show(Properties.Resources.This_help_topic_is_currently_not_available_, "POS Help", MessageBoxButton.OK, MessageBoxImage.Information);
                    return;
                }
                else
                {
                    System.Diagnostics.Process p = new System.Diagnostics.Process();
                    p.StartInfo.FileName = ret;
                    p.Start();
                }
            }
        }
        private void SetRentTypeButtonColor()
        {

            if (strCurrentServiceType == "") return;
            foreach (Control cr in pnlrent.Children)
            {
                if (cr is Button)
                {
                    if (cr.Tag.ToString() == strCurrentServiceType)
                    {
                        (cr as Button).Style = this.FindResource("GeneralButtonStyle2") as Style;
                    }
                    else
                    {
                        (cr as Button).Style = this.FindResource("GeneralButtonStyle") as Style;
                    }
                }
            }

        }
        private void btnOK_Click(object sender, RoutedEventArgs e)
        {
            if (_isModernUi)
            {
                SyncModernToClassic();
            }
            if (strServiceType == "Sales")
            {
                if (txtProduct.Text.Trim() == "")
                {
                    new MessageBoxWindow().Show(Properties.Resources.Enter_Product, Properties.Resources.Validation, MessageBoxButton.OK, MessageBoxImage.Information);
                    GeneralFunctions.SetFocus(txtProduct);
                    return;
                }

                if (double.Parse(numDiscount.Text) < 0)
                {
                    new MessageBoxWindow().Show(Properties.Resources.Enter_valid_discount, Properties.Resources.Discount_Validation, MessageBoxButton.OK, MessageBoxImage.Information);
                    GeneralFunctions.SetFocus(numDiscount);
                    return;
                }

                if (!blBlankLine)
                {
                    if (Weighted)
                    {
                        if (double.Parse(txtQty.Text) <= 0)
                        {
                            new MessageBoxWindow().Show(Properties.Resources.Enter_valid_weight, Properties.Resources.Weight_Validation, MessageBoxButton.OK, MessageBoxImage.Information);
                            GeneralFunctions.SetFocus(txtQty);
                            return;
                        }
                    }
                    strProductDesc = txtProduct.Text;
                    intQty = GeneralFunctions.fnDouble(txtQty.Text);
                    dblPrice = double.Parse(numPrice.Text);
                    dblDiscount = double.Parse(numDiscount.Text);
                    GetApplicableTax();
                    PersistWeightedUomToProduct();
                }
                else
                {
                    strProductDesc = txtProduct.Text;
                    intQty = GeneralFunctions.fnDouble(txtQty.Text);
                    dblPrice = double.Parse(numPrice.Text);
                    dblCost = double.Parse(numCost.Text);
                    GetApplicableTax();
                    dblDiscount = double.Parse(numDiscount.Text);
                }
            }

            if (strServiceType == "Rent")
            {
                if (txtRentProduct.Text.Trim() == "")
                {
                    new MessageBoxWindow().Show(Properties.Resources.Enter_Product, Properties.Resources.Validation, MessageBoxButton.OK, MessageBoxImage.Information);
                    GeneralFunctions.SetFocus(txtRentProduct);
                    return;
                }

                if ((double.Parse(txtRentDuration.Text) <= 0) && (!blProceedRentEditingWithoutDuration))
                {
                    DocMessage.MsgInformation(Properties.Resources.Invalid_Duration);
                    GeneralFunctions.SetFocus(txtRentDuration);
                    return;
                }

                if (!blBlankLine)
                {
                    strProductDesc = txtRentProduct.Text;
                    intQty = GeneralFunctions.fnDouble(txtRentQty.Text);
                    dblRentDuration = double.Parse(txtRentDuration.Text);
                    dblRentAmt = double.Parse(txtRentPrice.Text);
                    GetApplicableTax();
                }
                else
                {
                    strProductDesc = txtRentProduct.Text;
                    intQty = GeneralFunctions.fnDouble(txtRentQty.Text);
                    dblRentDuration = double.Parse(txtRentDuration.Text);
                    dblRentAmt = double.Parse(txtRentPrice.Text);
                    GetApplicableTax();
                }
            }

            if (strServiceType == "Repair")
            {
                if (txtRepairProduct.Text.Trim() == "")
                {
                    new MessageBoxWindow().Show(Properties.Resources.Enter_Product, Properties.Resources.Validation, MessageBoxButton.OK, MessageBoxImage.Information);
                    GeneralFunctions.SetFocus(txtRepairProduct);
                    return;
                }

                if (!blBlankLine)
                {
                    strProductDesc = txtRepairProduct.Text;
                    dblRepairAmt = double.Parse(txtRepairAmt.Text);
                    strRepairItemSL = txtRepairSL.Text.Trim();
                    strRepairItemTag = txtRepairTag.Text.Trim();
                    if (dtRepairPurchase.EditText != null) strRepairItemPurchase = dtRepairPurchase.EditText.ToString();
                    else strRepairItemPurchase = "";
                    GetApplicableTax();
                }
                else
                {
                    strProductDesc = txtRepairProduct.Text;
                    dblRepairAmt = double.Parse(txtRepairAmt.Text);
                    strRepairItemSL = txtRepairSL.Text.Trim();
                    strRepairItemTag = txtRepairTag.Text.Trim();
                    if (dtRepairPurchase.EditText != null) strRepairItemPurchase = dtRepairPurchase.EditText.ToString();
                    else strRepairItemPurchase = "";
                    GetApplicableTax();
                }
            }

            DialogResult =true;
            StopListeningToScale();
            CloseKeyboards();
            Close();
        }
        private void FillTax()
        {
            // fetch TaxID, TaxName first

            int intCount = 0;
            DataTable dtblTaxHeader = new DataTable();
            PosDataObject.Tax objTax = new PosDataObject.Tax();
            objTax.Connection = new SqlConnection(SystemVariables.ConnectionString);
            dtblTaxHeader = objTax.FetchActiveTax();
            foreach (DataRow dr in dtblTaxHeader.Rows)
            {
                string strTaxName = "";
                intCount++;
                strTaxName = dr["TaxName"].ToString() + " (" + GeneralFunctions.fnDouble(dr["TaxRate"].ToString()).ToString("n") + "%)";

                if (intCount == 1)
                {
                    strTaxID1 = dr["ID"].ToString();
                    strTaxName1 = strTaxName;
                    strTaxRate1 = dr["TaxRate"].ToString();
                }
                if (intCount == 2)
                {
                    strTaxID2 = dr["ID"].ToString();
                    strTaxName2 = strTaxName;
                    strTaxRate2 = dr["TaxRate"].ToString();
                }
                if (intCount == 3)
                {
                    strTaxID3 = dr["ID"].ToString();
                    strTaxName3 = strTaxName;
                    strTaxRate3 = dr["TaxRate"].ToString();
                    break;
                }
            }
            DataTable dtbl = new DataTable();

            dtbl.Columns.Add("ID", System.Type.GetType("System.String"));
            dtbl.Columns.Add("TaxName", System.Type.GetType("System.String"));
            dtbl.Columns.Add("TaxRate", System.Type.GetType("System.String"));
            dtbl.Columns.Add("CheckTax", System.Type.GetType("System.Boolean"));
            dtbl.Columns.Add("Image", System.Type.GetType("System.Byte[]"));
            byte[] strip = GeneralFunctions.GetImageAsByteArray();
            if (GeneralFunctions.fnInt32(strTaxID1) > 0)
                dtbl.Rows.Add(new object[] { strTaxID1, strTaxName1, strTaxRate1, true, strip });
            if (GeneralFunctions.fnInt32(strTaxID2) > 0)
                dtbl.Rows.Add(new object[] { strTaxID2, strTaxName2, strTaxRate2, true, strip });
            if (GeneralFunctions.fnInt32(strTaxID3) > 0)
                dtbl.Rows.Add(new object[] { strTaxID3, strTaxName3, strTaxRate3, true, strip });

            grdTax.ItemsSource = dtbl;
            dtblTaxHeader.Dispose();
            dtbl.Dispose();
        }

        private void SetSelectedTax()
        {
            DataTable dtbl = grdTax.ItemsSource as DataTable;

            foreach (DataRow dr in dtbl.Rows)
            {
                dr["CheckTax"] = false;
                int txid = GeneralFunctions.fnInt32(dr["ID"].ToString());
                if ((txid == intSelectedTaxID1) || (txid == intSelectedTaxID2) || (txid == intSelectedTaxID1))
                {
                    dr["CheckTax"] = true;
                }
            }
            grdTax.ItemsSource = dtbl;
        }


        private void SetNoTax()
        {
            DataTable dtbl = grdTax.ItemsSource as DataTable;

            foreach (DataRow dr in dtbl.Rows)
            {
                dr["CheckTax"] = false;
            }
            grdTax.ItemsSource = dtbl;
        }

        private void GetApplicableTax()
        {
            int tcurrtx1 = 0;
            int tcurrtx2 = 0;
            int tcurrtx3 = 0;

            DataTable dtbl = new DataTable();
            dtbl = grdTax.ItemsSource as DataTable;
            int intc = 0;
            foreach (DataRow dr in dtbl.Rows)
            {
                intc++;
                if (intc == 1)
                {
                    if (Convert.ToBoolean(dr["CheckTax"].ToString()) == true)
                    {
                        strTaxApplicable1 = "Y";
                        tcurrtx1 = 1;
                    }
                }
                if (intc == 2)
                {
                    if (Convert.ToBoolean(dr["CheckTax"].ToString()) == true)
                    {
                        strTaxApplicable2 = "Y";
                        tcurrtx2 = 1;
                    }
                }
                if (intc == 3)
                {
                    if (Convert.ToBoolean(dr["CheckTax"].ToString()) == true)
                    {
                        strTaxApplicable3 = "Y";
                        tcurrtx3 = 1;
                    }
                }
            }
            dtbl.Dispose();

            if ((intSelectedTaxID1 == tcurrtx1) && (intSelectedTaxID2 == tcurrtx2) && (intSelectedTaxID3 == tcurrtx3))
            {
                blTaxChangeFlag = false;
            }
            else
            {
                blTaxChangeFlag = true;
            }
        }
        private void btnCancel_Click(object sender, RoutedEventArgs e)
        {
            DialogResult = false;
            StopListeningToScale();
            CloseKeyboards();
            Close();
        }

        private void txtRentPrice_TextChanged(object sender, TextChangedEventArgs e)
        {
            if ((txtRentDuration.Text != null) && (txtRentPrice.Text != null) && (txtRentQty?.Text != null))
            {
                if (!blProceedRentEditingWithoutDuration) numTotal.Text = (double.Parse(txtRentDuration.Text) * double.Parse(txtRentPrice.Text) * double.Parse(txtRentQty?.Text??"0")).ToString();
                else numTotal.Text = (double.Parse(txtRentPrice.Text) * double.Parse(txtRentQty.Text)).ToString();
            }
        }

        private void rb1_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button)
            {
                strCurrentServiceType = (sender as Button).Tag.ToString();
                SetRentTypeButtonColor();
                if (strCurrentServiceType == "MI")
                {
                    strRentType = "MI";
                    lbrenttype.Text = Properties.Resources.min;
                }
                else if (strCurrentServiceType == "HR")
                {
                    strRentType = "HR";
                    lbrenttype.Text = Properties.Resources.hr ;
                }
                else if (strCurrentServiceType == "HD")
                {
                    strRentType = "HD";
                    lbrenttype.Text = Properties.Resources.halfday;
                }
                else if (strCurrentServiceType == "DY")
                {
                    strRentType = "DY";
                    lbrenttype.Text = Properties.Resources.day;
                }
                else if (strCurrentServiceType == "WK")
                {
                    strRentType = "WK";
                    lbrenttype.Text = Properties.Resources.week;
                }
                else
                {
                    strRentType = "MN";
                    lbrenttype.Text = Properties.Resources.month;
                }
            }
        }
        #region LiveWeightSacle XX
        public SerialPort _serialPort = new SerialPort();
        private static string ScaleCOMPort = "COM4";
        private static Queue<byte> recievedData = new Queue<byte>();
        DispatcherTimer dispatcherTimer = new DispatcherTimer();
        private bool _isListeningToScale;
        public static string message { get; set; } = string.Empty;
        private void StartListeningToScale()
        {
            if (_isListeningToScale) return;
            dispatcherTimer.Start();
            _isListeningToScale = true;
        }
        private void _serialPort_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            try
            {
                byte[] data = new byte[_serialPort.BytesToRead];
                File.AppendAllText(System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "scaleLog.txt"), $"_serialPort_DataReceived" + data + Environment.NewLine);
                _serialPort.Read(data, 0, data.Length);

                data.ToList().ForEach(b => recievedData.Enqueue(b));
                ProcessScaleData();

            }
            catch (Exception ex)
            {
                File.AppendAllText(System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "scaleLog.txt"), $"_serialPort_DataReceived.Exception : {ex} " + Environment.NewLine);
            }
        }
        private void StopListeningToScale()
        {
            if (_isListeningToScale)
            {
                dispatcherTimer.Stop();
                _serialPort.Close();
                _serialPort.Dispose();
                _isListeningToScale = false;
            }
        }
        private void ProcessScaleData()
        {
            File.AppendAllText(System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "scaleLog.txt"), $"recievedData.Count : {recievedData.Count} " + Environment.NewLine);
            if (recievedData.Count == 25)
            {
                message = "";
                foreach (var item in recievedData)
                {
                    message += (char)item;
                }
                recievedData.Clear();
                float weight = 0;
                if (message.Substring(3, 1) == "3")
                {
                    weight = float.Parse(message.Substring(5, 5)) / 1000;
                }
                File.AppendAllText(System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "scaleLog.txt"), Environment.NewLine + $"weight: {weight} " + Environment.NewLine);

                scaleWeightText = weight.ToString();
                // BeginInvoke (not Invoke): Invoke from DataReceived deadlocks/re-enters the UI
                // thread and can terminate the process with StackOverflowException (0x800703E9).
                Dispatcher.BeginInvoke(new Action(() =>
                {
                    if (!Weighted) return;
                    ApplyWeightToQty(scaleWeightText);
                }));
            }

        }
        //
        string scaleWeightText = "0.00";
        private void DispatcherTimer_Tick(object sender, EventArgs e)
        {
            FeedDataToScale();
        }
        private void FeedDataToScale()
        {
            try
            {
                if (!_serialPort.IsOpen)
                {
                    _serialPort.Open();
                }
                recievedData.Clear();

                _serialPort.Write(new byte[] { 4 }, 0, 1);
                _serialPort.Write(new byte[] { 5 }, 0, 1);
                File.AppendAllText(System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "scaleLog.txt"), "\n\rData Has been sent!:--------------------------\n\r");

            }
            catch (Exception ex)
            {
                File.AppendAllText(System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "scaleLog.txt"), "\n\rException FeedDataToScale:--------------------------\n\r" + ex.ToString() + "\n");
                return;
            }

        }
        #endregion

        #region IsNewLiveWeightScaleEnabled
        public SerialPort _newWeightSerialPort = new SerialPort();
        private readonly StringBuilder _newWeightScaleBuffer = new StringBuilder();
        private static readonly char[] _newWeightScaleLineTerminators = new char[] { '\r', '\n' };
        private DispatcherTimer _newWeightDispatcherTimer = new DispatcherTimer();
        private bool _isListeningToNewWeightScale;
        private bool _newWeightScaleDialogRevealed;
        private DispatcherTimer _newWeightScaleRevealTimeout;
        private bool _newWeightScaleCloseHooked;
        private bool _isApplyingScaleWeight;
        private double _lastAppliedScaleWeight = double.NaN;
        private const int NewWeightScaleBufferMaxLength = 4096;

        private static string NewWeightScaleLogPath
        {
            get { return System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "scaleLog.txt"); }
        }

        private void StartNewWeightScaleListening()
        {
            if (_isListeningToNewWeightScale) return;
            _newWeightDispatcherTimer.Start();
            _isListeningToNewWeightScale = true;
        }

        private void _newWeightSerialPort_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            try
            {
                if (!_isListeningToNewWeightScale) return;

                string data = _newWeightSerialPort.ReadExisting();
                if (data == "") return;

                lock (_newWeightScaleBuffer)
                {
                    _newWeightScaleBuffer.Append(data);
                    if (_newWeightScaleBuffer.Length > NewWeightScaleBufferMaxLength)
                    {
                        _newWeightScaleBuffer.Remove(0, _newWeightScaleBuffer.Length - NewWeightScaleBufferMaxLength);
                    }
                }
                ProcessNewWeightScaleData();
            }
            catch (Exception ex)
            {
                File.AppendAllText(NewWeightScaleLogPath, $"_newWeightSerialPort_DataReceived.Exception : {ex} " + Environment.NewLine);
            }
        }

        private void StopNewWeightScaleListening()
        {
            if (!_isListeningToNewWeightScale) return;

            _isListeningToNewWeightScale = false;
            _newWeightDispatcherTimer.Stop();
            _newWeightDispatcherTimer.Tick -= NewWeightDispatcherTimer_Tick;
            _newWeightSerialPort.DataReceived -= _newWeightSerialPort_DataReceived;

            if (_newWeightScaleRevealTimeout != null)
            {
                _newWeightScaleRevealTimeout.Stop();
                _newWeightScaleRevealTimeout.Tick -= RevealNewWeightScaleDialogAfterTimeout;
                _newWeightScaleRevealTimeout = null;
            }

            SerialPort port = _newWeightSerialPort;
            Task.Run(() =>
            {
                try
                {
                    port.Close();
                    port.Dispose();
                }
                catch
                {
                }
            });
        }

        private void ProcessNewWeightScaleData(bool applyIncomplete = false)
        {
            while (true)
            {
                string line;

                lock (_newWeightScaleBuffer)
                {
                    string pending = _newWeightScaleBuffer.ToString();
                    int intIndex = pending.IndexOfAny(_newWeightScaleLineTerminators);

                    if (intIndex < 0)
                    {
                        if (!applyIncomplete || pending.Trim() == "") return;

                        line = pending;
                        _newWeightScaleBuffer.Clear();
                    }
                    else
                    {
                        line = pending.Substring(0, intIndex);
                        _newWeightScaleBuffer.Clear();
                        _newWeightScaleBuffer.Append(pending.Substring(intIndex + 1));
                    }
                }

                ApplyNewWeightScaleReading(line);
            }
        }

        private void ApplyNewWeightScaleReading(string line)
        {
            if (line.Trim() == "") return;

            if (line.Contains("?") ||
                Regex.IsMatch(line, @"\bUS\b|\bMD\b", RegexOptions.IgnoreCase))
            {
                return;
            }

            Match weightMatch = Regex.Match(
                line,
                @"([-+]?\d+(?:\.\d+)?)\s*(KG|LB)\b",
                RegexOptions.IgnoreCase);
            if (!weightMatch.Success) return;

            double dblWeight = GeneralFunctions.fnDouble(weightMatch.Groups[1].Value);
            if (dblWeight <= 0) return;

            Dispatcher.BeginInvoke(new Action(() =>
            {
                if (!Weighted) return;

                ApplyWeightToQty(dblWeight);
                RevealNewWeightScaleDialog();
            }));
        }

        private void ApplyWeightToQty(object weightValue)
        {
            if (_isApplyingScaleWeight) return;

            double dblWeight = GeneralFunctions.fnDouble(weightValue);
            if (!double.IsNaN(_lastAppliedScaleWeight) && Math.Abs(_lastAppliedScaleWeight - dblWeight) < 0.0001)
            {
                return;
            }

            _isApplyingScaleWeight = true;
            try
            {
                _lastAppliedScaleWeight = dblWeight;
                txtQty.EditValue = dblWeight;
                UpdateWeightFromScale(dblWeight.ToString(CultureInfo.InvariantCulture));
            }
            finally
            {
                _isApplyingScaleWeight = false;
            }
        }

        private void RevealNewWeightScaleDialog()
        {
            if (_newWeightScaleDialogRevealed) return;
            _newWeightScaleDialogRevealed = true;

            if (_newWeightScaleRevealTimeout != null)
            {
                _newWeightScaleRevealTimeout.Stop();
                _newWeightScaleRevealTimeout.Tick -= RevealNewWeightScaleDialogAfterTimeout;
                _newWeightScaleRevealTimeout = null;
            }

            Opacity = 1;
        }

        private void RevealNewWeightScaleDialogAfterTimeout(object sender, EventArgs e)
        {
            RevealNewWeightScaleDialog();
        }

        private void NewWeightDispatcherTimer_Tick(object sender, EventArgs e)
        {
            FeedNewWeightScaleData();
        }

        private void FeedNewWeightScaleData()
        {
            try
            {
                if (!_newWeightSerialPort.IsOpen)
                {
                    _newWeightSerialPort.Open();
                }

                ProcessNewWeightScaleData(true);
                _newWeightSerialPort.Write("W\r\n");
            }
            catch (Exception ex)
            {
                File.AppendAllText(NewWeightScaleLogPath, "\n\rException FeedNewWeightScaleData:--------------------------\n\r" + ex.ToString() + "\n");
            }
        }

        private void ConfigureNewWeightSerialPort()
        {
            _newWeightSerialPort.PortName = Settings.COMPort1;
            _newWeightSerialPort.BaudRate = int.Parse(Settings.BaudRate);
            _newWeightSerialPort.DataBits = int.Parse(Settings.DataBits);

            if (Enum.TryParse(Settings.Parity, true, out System.IO.Ports.Parity parityValue))
            {
                _newWeightSerialPort.Parity = parityValue;
            }
            else
            {
                _newWeightSerialPort.Parity = System.IO.Ports.Parity.None;
            }

            if (Enum.TryParse(Settings.StopBits, true, out System.IO.Ports.StopBits stopBitsValue))
            {
                _newWeightSerialPort.StopBits = stopBitsValue;
            }
            else
            {
                _newWeightSerialPort.StopBits = System.IO.Ports.StopBits.One;
            }

            System.IO.Ports.Handshake handshakeValue = System.IO.Ports.Handshake.None;
            if (Settings.Handshake == "RequstToSend") handshakeValue = System.IO.Ports.Handshake.RequestToSend;
            if (Settings.Handshake == "RequstToSendXOnXOff") handshakeValue = System.IO.Ports.Handshake.RequestToSendXOnXOff;
            if (Settings.Handshake == "XOnXOff") handshakeValue = System.IO.Ports.Handshake.XOnXOff;
            _newWeightSerialPort.Handshake = handshakeValue;

            int intScaleTimeout = GeneralFunctions.fnInt32(Settings.Timeout);
            if (intScaleTimeout < 3000) intScaleTimeout = 3000;
            _newWeightSerialPort.ReadTimeout = intScaleTimeout;
            _newWeightSerialPort.WriteTimeout = intScaleTimeout;
        }

        private void StartNewWeightScaleModel()
        {
            if (!_newWeightScaleCloseHooked)
            {
                Closing += (s, e) => StopNewWeightScaleListening();
                _newWeightScaleCloseHooked = true;
            }

            try
            {
                ConfigureNewWeightSerialPort();

                string logFilePath = NewWeightScaleLogPath;
                if (!File.Exists(logFilePath))
                {
                    File.Create(logFilePath).Dispose();
                }

                File.WriteAllText(logFilePath, string.Empty);
                _newWeightSerialPort.DataReceived -= _newWeightSerialPort_DataReceived;
                _newWeightSerialPort.DataReceived += _newWeightSerialPort_DataReceived;

                if (!_newWeightSerialPort.IsOpen)
                {
                    _newWeightSerialPort.Open();
                }

                _newWeightDispatcherTimer.Tick -= NewWeightDispatcherTimer_Tick;
                _newWeightDispatcherTimer.Tick += NewWeightDispatcherTimer_Tick;
                _newWeightDispatcherTimer.Interval = TimeSpan.FromMilliseconds(200);

                if (Weighted)
                {
                    Opacity = 0;
                    _newWeightScaleRevealTimeout = new DispatcherTimer();
                    _newWeightScaleRevealTimeout.Interval = TimeSpan.FromSeconds(2);
                    _newWeightScaleRevealTimeout.Tick += RevealNewWeightScaleDialogAfterTimeout;
                    _newWeightScaleRevealTimeout.Start();
                }

                StartNewWeightScaleListening();
                FeedNewWeightScaleData();
            }
            catch (Exception ex)
            {
                try
                {
                    File.AppendAllText(NewWeightScaleLogPath, $"New weight scale port init failed : {ex} " + Environment.NewLine);
                }
                catch
                {
                }
            }
        }
        #endregion

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            PrepareUiBeforeShow();
            nkybrd = new NumKeyboard();
            fkybrd = new FullKeyboard();
            Title.Text = Properties.Resources.Edit_Product;

            if (Settings.ScaleDevice == "Live Weight")
            {
                if(Settings.IsNewLiveWeightScaleEnabled == 1)
                {
                    StartNewWeightScaleModel();
                }
                else
                {
                    #region LiveWeightSacle XX
                    try
                    {

                        //if (_serialPort.IsOpen)
                        //{
                        //    _serialPort.Close();
                        //}
                        //_serialPort.Dispose();
                        _serialPort.PortName = Settings.COMPort1;
                        _serialPort.BaudRate = int.Parse(Settings.BaudRate);

                        _serialPort.DataBits = int.Parse(Settings.DataBits);
                        if (Enum.TryParse(Settings.Parity, true, out System.IO.Ports.Parity parityValue))
                        {
                            _serialPort.Parity = parityValue;
                        }
                        else
                        {
                            // Handle invalid value (set a default or throw an error)
                            _serialPort.Parity = System.IO.Ports.Parity.None; // Default value
                        }
                        if (Enum.TryParse(Settings.StopBits, true, out System.IO.Ports.StopBits stopBitsValue))
                        {
                            _serialPort.StopBits = stopBitsValue;
                        }
                        else
                        {
                            // Handle invalid value (set a default or throw an error)
                            _serialPort.StopBits = System.IO.Ports.StopBits.One; // Default value
                        }


                        //_serialPort.PortName = ScaleCOMPort;
                        //_serialPort.BaudRate = 9600;
                        //_serialPort.DataBits = 7;
                        //_serialPort.Parity = Parity.Odd;
                        //_serialPort.StopBits = StopBits.One;
                        string logFilePath = System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "scaleLog.txt");

                        // Ensure the file exists before clearing
                        if (!File.Exists(logFilePath))
                        {
                            File.Create(logFilePath).Dispose(); // Create and immediately close the file
                        }

                        // Clear the file content
                        File.WriteAllText(logFilePath, string.Empty);
                        _serialPort.DataReceived += _serialPort_DataReceived;

                        if (!_serialPort.IsOpen)
                        {
                            _serialPort.Open();
                        }
                        dispatcherTimer.Tick += DispatcherTimer_Tick;
                        dispatcherTimer.Interval = TimeSpan.FromSeconds(1.5);
                        StartListeningToScale();
                    }
                    catch (Exception ex)
                    {
                        //this exception occurs when the com port has problem
                        //continue to the code 
                    }
                    #endregion

                }
            }

            if (strServiceType == "Sales")
            {
                tbctrl.SelectedIndex = 0;
                if (!blBlankLine)
                {
                    lblabel.Visibility=Visibility.Collapsed;
                    numCurrPrice.Visibility=Visibility.Collapsed;
                    numCost.Visibility=Visibility.Collapsed;
                    //panel2.Visibility = Visibility.Visible;
                    if (blFuelItem)
                    {
                        //txtQty.Decimals = 3;
                        //numPrice.Decimals = 3;
                    }
                    else
                    {
                        //txtQty.Decimals = Settings.DecimalPlace;
                        //numPrice.Decimals = Settings.DecimalPlace;
                    }
                    txtProduct.Text = strProductDesc;
                    if (blWeighted)
                        txtQty.Mask = "f3";
                    txtQty.EditValue = intQty;
                    numPrice.Text = dblPrice.ToString();
                    numDiscount.Text = dblDiscount.ToString();
                    btnHelp.Tag = "Help on poseditprod";
                    if (blWeighted)
                    {
                        lbUOM.Visibility = Visibility.Visible;
                        lbUOM.Text = strWeightedUOM;
                        numPrice.Visibility = Visibility.Visible;
                        lbPrice.Visibility = Visibility.Visible;
                        numCurrPrice.Visibility=Visibility.Collapsed;
                        numCost.Visibility=Visibility.Collapsed;
                        lblabel.Visibility=Visibility.Collapsed;
                        numDiscount.Visibility = Visibility.Visible;
                        lbDiscount1.Visibility = Visibility.Visible;
                        lblQty.Text = Properties.Resources.Weight;
                        btnWeight.Visibility=Visibility.Collapsed;
                        txtQty.IsReadOnly = IsLiveWeightLocked;
                        if (!IsEdit)
                        {
                            Title.Text = Properties.Resources.Weight;
                            txtProduct.IsReadOnly = true;
                            txtProduct.Focusable = false;
                            if (!_isModernUi)
                            {
                                if (IsLiveWeightLocked)
                                    GeneralFunctions.SetFocus(numPrice);
                                else
                                    GeneralFunctions.SetFocus(txtQty);
                            }
                        }
                    }
                    else
                    {
                        lblQty.Text = Properties.Resources.Quantity;
                        btnWeight.Visibility=Visibility.Collapsed;
                        if (blBottleRefund)
                        {
                            lbDiscount1.Visibility = numDiscount.Visibility=Visibility.Collapsed;
                            txtProduct.IsEnabled = false;
                        }
                    }

                    FillTax();
                    SetSelectedTax();
                }
                else
                {
                    Title.Text = Properties.Resources.Blank_Line;
                    lblabel.Visibility = Visibility.Visible;
                    lblabel.Text = Properties.Resources.Cost;
                    numCurrPrice.Visibility=Visibility.Collapsed;
                    numCost.Visibility = Visibility.Visible;
                    //panel2.Visibility = Visibility.Visible;
                    FillTax();
                    SetNoTax();
                    //txtQty.Decimals = Settings.DecimalPlace;
                    //numPrice.Decimals = Settings.DecimalPlace;
                    //numCost.Decimals = Settings.DecimalPlace;
                    txtProduct.Text = strProductDesc;
                    txtQty.Text = intQty.ToString();
                    numPrice.Text = dblPrice.ToString();
                    numCost.Text = dblPrice.ToString();
                    btnHelp.Tag = "Help on posblankprod";
                    if (!_isModernUi)
                        GeneralFunctions.SetFocus(numPrice);
                }
            }

            if (strServiceType == "Rent")
            {

                tbctrl.SelectedIndex = 1;
                if (!blBlankLine)
                {
                    //txtRentDuration.Decimals = Settings.DecimalPlace;
                    //txtRentPrice.Decimals = Settings.DecimalPlace;
                    //txtRentQty.Decimals = Settings.DecimalPlace;
                    //panel2.Visibility = Visibility.Visible;
                    txtRentProduct.Text = strProductDesc;
                    txtRentDuration.Text = dblRentDuration.ToString();
                    txtRentPrice.Text = dblRentAmt.ToString();
                    txtRentQty.Text = intQty.ToString();
                    FillTax();
                    SetSelectedTax();
                }
                else
                {
                    Title.Text = Properties.Resources.Blank_Line;
                    //panel2.Visibility = Visibility.Visible;
                    FillTax();
                    SetNoTax();
                    //txtRentDuration.Decimals = Settings.DecimalPlace;
                    //txtRentPrice.Decimals = Settings.DecimalPlace;
                    //txtRentQty.Decimals = Settings.DecimalPlace;
                    strRentType = "DY";
                    txtRentDuration.Text = "1";
                    txtRentPrice.Text = "1";
                    txtRentQty.Text = "1";
                    btnHelp.Tag = "Help on posblankprod";
                }
                if (blProceedRentEditingWithoutDuration)
                {
                    txtRentDuration.Text = "0";
                    txtRentDuration.IsReadOnly = true;
                }
                if (strCurrentServiceType == "MI")
                {
                    lbrenttype.Text = Properties.Resources.min;
                }
                else if (strCurrentServiceType == "HR")
                {
                    lbrenttype.Text = Properties.Resources.hr;
                }
                else if (strCurrentServiceType == "HD")
                {
                    lbrenttype.Text = Properties.Resources.halfday;
                }
                else if (strCurrentServiceType == "DY")
                {
                    lbrenttype.Text = Properties.Resources.day;
                }
                else if (strCurrentServiceType == "WK")
                {
                    lbrenttype.Text = Properties.Resources.week;
                }
                else
                {
                    lbrenttype.Text = Properties.Resources.month;
                }
            }

            if (strServiceType == "Repair")
            {
                tbctrl.SelectedIndex = 2;
                if (!blBlankLine)
                {
                    //txtRepairAmt.Decimals = Settings.DecimalPlace;
                    //panel2.Visibility = Visibility.Visible;
                    txtRepairAmt.Text = dblRepairAmt.ToString();
                    txtRepairProduct.Text = strProductDesc;
                    txtRepairSL.Text = strRepairItemSL;
                    txtRepairTag.Text = strRepairItemTag;
                    if (strRepairItemPurchase == "")
                    {
                        dtRepairPurchase.EditValue = null;
                    }
                    else
                    {
                        dtRepairPurchase.EditValue = GeneralFunctions.fnDate(strRepairItemPurchase);
                    }
                    FillTax();
                    SetSelectedTax();
                }
                else
                {
                    //txtRepairAmt.Decimals = Settings.DecimalPlace;
                    Title.Text = Properties.Resources.Blank_Line;
                    //panel2.Visibility = Visibility.Visible;
                    FillTax();
                    SetNoTax();
                    txtRepairAmt.Text = dblRepairAmt.ToString();
                    txtRepairProduct.Text = strProductDesc;
                    txtRepairSL.Text = strRepairItemSL;
                    txtRepairTag.Text = strRepairItemTag;
                    if (strRepairItemPurchase == "")
                    {
                        dtRepairPurchase.EditValue = null;
                    }
                    else
                    {
                        dtRepairPurchase.EditValue = GeneralFunctions.fnDate(strRepairItemPurchase);
                    }
                    btnHelp.Tag = "Help on posblankprod";
                }
            }
            if (_isModernUi)
            {
                PopulateModernValuesFromFields();
                InitModernTaxCombo();
                if (blWeighted)
                    InitWeightUomCombo();
            }
        }

        private void TxtRentPrice_EditValueChanged(object sender, DevExpress.Xpf.Editors.EditValueChangedEventArgs e)
        {
            if ((txtRentDuration.Text != null) && (txtRentPrice.Text != null) && (txtRentQty?.Text != null))
            {
                if (!blProceedRentEditingWithoutDuration) numTotal.Text = (double.Parse(txtRentDuration.Text) * double.Parse(txtRentPrice.Text) * double.Parse(txtRentQty?.Text ?? "0")).ToString();
                else numTotal.Text = (double.Parse(txtRentPrice.Text) * double.Parse(txtRentQty.Text)).ToString();
            }
        }

        private void DtRepairPurchase_PreviewMouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            DevExpress.Xpf.Editors.DateEdit editor = sender as DevExpress.Xpf.Editors.DateEdit;
            if (editor != null)
            {
                editor.IsPopupOpen = true;
                editor.ShowPopup();
                e.Handled = true;
            }
        }

        #region Modern UI
        private bool _modernShellApplied;

        private void ApplyModernShell()
        {
            if (_modernShellApplied) return;
            _modernShellApplied = true;
            _isModernUi = true;

            WindowState = WindowState.Maximized;
            dimOverlay.Visibility = Visibility.Visible;
            dialogHost.HorizontalAlignment = HorizontalAlignment.Center;
            dialogHost.VerticalAlignment = VerticalAlignment.Center;
            dialogHost.Width = 540;
            dialogHost.Height = double.NaN;
            ModalWindow.Margin = new Thickness(5);
            gridClassic.Visibility = Visibility.Collapsed;
            gridModern.Visibility = Visibility.Visible;

            string currency = SystemVariables.CurrencySymbol ?? "£";
            txtHeroCurrency.Text = currency;
            txtWeightPriceCurrency.Text = currency;
            txtDiscountCurrency.Text = currency;
            txtCostCurrency.Text = currency;

            _weightValue = (decimal)intQty;
            _priceValue = (decimal)dblPrice;
            _costValue = dblCost != 0 ? (decimal)dblCost : (decimal)dblPrice;
            _discountValue = (decimal)dblDiscount;
            txtModernProduct.Text = strProductDesc ?? "";

            if (blWeighted)
            {
                txtQty.Mask = "f3";
                txtModernTitle.Text = "Weight Product";
                txtModernSubtitle.Visibility = Visibility.Collapsed;
                pnlWeightField.Visibility = Visibility.Visible;
                pnlPriceHeroField.Visibility = Visibility.Collapsed;
                pnlQtyBox.Visibility = Visibility.Collapsed;
                colQty.Width = new GridLength(0);
                pnlPriceField.Visibility = Visibility.Visible;
                pnlCostField.Visibility = Visibility.Collapsed;
                InitWeightUomCombo();
                if (!blIsEdit)
                {
                    txtModernProduct.IsReadOnly = true;
                    txtModernProduct.Focusable = false;
                }
                // Product → Weight → Price+Discount → Tax
                ArrangeModernFields(pnlProductField, pnlWeightField, pnlSecondaryAmounts, pnlQtyTaxRow, pnlModernKeypad);
                ApplyLiveWeightFieldLock();
                SetKeypadTarget(IsLiveWeightLocked ? ModernKeypadTarget.Price : ModernKeypadTarget.Weight);
            }
            else
            {
                txtModernTitle.Text = Properties.Resources.Blank_Line;
                txtModernSubtitle.Text = "Enter details";
                pnlWeightField.Visibility = Visibility.Collapsed;
                pnlPriceHeroField.Visibility = Visibility.Visible;
                pnlQtyBox.Visibility = Visibility.Visible;
                colQty.Width = new GridLength(140);
                pnlPriceField.Visibility = Visibility.Collapsed;
                pnlCostField.Visibility = Visibility.Visible;

                int qty = (int)Math.Round(intQty);
                if (qty <= 0) qty = 1;
                txtModernQty.Text = qty.ToString();
                // Product (was Price spot) → Qty+Tax → Price (was Product spot) → Cost+Discount
                ArrangeModernFields(pnlProductField, pnlQtyTaxRow, pnlPriceHeroField, pnlSecondaryAmounts, pnlModernKeypad);
                SetKeypadTarget(ModernKeypadTarget.Price);
            }

            RefreshModernValueDisplays();
        }

        private void ArrangeModernFields(params UIElement[] orderedChildren)
        {
            pnlModernFields.Children.Clear();
            foreach (var child in orderedChildren)
            {
                if (child != null && !pnlModernFields.Children.Contains(child))
                    pnlModernFields.Children.Add(child);
            }
        }
        private decimal ParseDecimalField(object editValue, string text, decimal fallback)
        {
            object source = editValue ?? text;
            if (source is decimal d) return d;
            if (source is double dbl) return (decimal)dbl;
            if (source is float f) return (decimal)f;
            if (source is int i) return i;
            string raw = Convert.ToString(source);
            decimal parsed;
            if (decimal.TryParse(raw, NumberStyles.Any, CultureInfo.CurrentCulture, out parsed) ||
                decimal.TryParse(raw, NumberStyles.Any, CultureInfo.InvariantCulture, out parsed))
            {
                return parsed;
            }
            return fallback;
        }

        private void PopulateModernValuesFromFields()
        {
            decimal parsedWeight = ParseDecimalField(txtQty.EditValue, txtQty.Text, (decimal)intQty);
            if (parsedWeight == 0 && intQty != 0)
                parsedWeight = (decimal)intQty;
            _weightValue = parsedWeight;
            _priceValue = ParseDecimalField(numPrice.EditValue, numPrice.Text, (decimal)dblPrice);
            _costValue = ParseDecimalField(numCost.EditValue, numCost.Text, dblCost != 0 ? (decimal)dblCost : (decimal)dblPrice);
            _discountValue = ParseDecimalField(numDiscount.EditValue, numDiscount.Text, (decimal)dblDiscount);
            txtModernProduct.Text = txtProduct.Text;

            if (!blWeighted)
            {
                int qty = 1;
                if (!int.TryParse(Convert.ToString(txtQty.Text), NumberStyles.Any, CultureInfo.CurrentCulture, out qty) || qty <= 0)
                    qty = 1;
                txtModernQty.Text = qty.ToString();
            }
            else if (_keypadTarget == ModernKeypadTarget.Weight)
            {
                _keypadValue = _weightValue;
            }

            RefreshModernValueDisplays();
        }
        private void SyncModernToClassic()
        {
            txtProduct.Text = txtModernProduct.Text ?? "";
            numPrice.Text = _priceValue.ToString(CultureInfo.CurrentCulture);
            numDiscount.Text = _discountValue.ToString(CultureInfo.CurrentCulture);

            if (blWeighted)
            {
                txtQty.EditValue = _weightValue;
                ApplySelectedWeightUom();
            }
            else
            {
                txtQty.Text = txtModernQty.Text;
                numCost.Text = _costValue.ToString(CultureInfo.CurrentCulture);
            }

            ApplyModernTaxToGrid();
        }

        private void InitModernTaxCombo()
        {
            var options = new List<TaxOption>();
            options.Add(new TaxOption { ID = 0, TaxName = "No Tax (0%)", TaxRate = 0 });

            DataTable dtbl = grdTax.ItemsSource as DataTable;
            int selectedId = 0;
            if (dtbl != null)
            {
                foreach (DataRow dr in dtbl.Rows)
                {
                    int id = GeneralFunctions.fnInt32(dr["ID"].ToString());
                    options.Add(new TaxOption
                    {
                        ID = id,
                        TaxName = dr["TaxName"].ToString(),
                        TaxRate = GeneralFunctions.fnDouble(dr["TaxRate"].ToString())
                    });
                    if (Convert.ToBoolean(dr["CheckTax"]) && selectedId == 0)
                        selectedId = id;
                }
            }

            cmbModernTax.ItemsSource = options;
            cmbModernTax.DisplayMember = "TaxName";
            cmbModernTax.ValueMember = "ID";
            cmbModernTax.EditValue = selectedId;
        }

        private void ApplyModernTaxToGrid()
        {
            DataTable dtbl = grdTax.ItemsSource as DataTable;
            if (dtbl == null) return;

            int selectedId = GeneralFunctions.fnInt32(cmbModernTax.EditValue);
            foreach (DataRow dr in dtbl.Rows)
            {
                dr["CheckTax"] = GeneralFunctions.fnInt32(dr["ID"].ToString()) == selectedId;
            }
            grdTax.ItemsSource = dtbl;

            strTaxApplicable1 = "N";
            strTaxApplicable2 = "N";
            strTaxApplicable3 = "N";
        }

        private long ToKeypadUnits(decimal value, int decimals)
        {
            decimal factor = (decimal)Math.Pow(10, decimals);
            return (long)Math.Round(value * factor, MidpointRounding.AwayFromZero);
        }

        private decimal FromKeypadUnits(long units, int decimals)
        {
            decimal factor = (decimal)Math.Pow(10, decimals);
            return units / factor;
        }
        private void ApplyLiveWeightFieldLock()
        {
            bool locked = IsLiveWeightLocked;
            txtQty.IsReadOnly = locked;
            if (bdWeightHero != null)
                bdWeightHero.Cursor = locked ? Cursors.Arrow : Cursors.Hand;
        }

        private void SetKeypadTarget(ModernKeypadTarget target)
        {
            if (target == ModernKeypadTarget.Weight && IsLiveWeightLocked)
                return;
            _keypadTarget = target;
            _keypadDecimals = (target == ModernKeypadTarget.Weight) ? 3 : 2;
            switch (target)
            {
                case ModernKeypadTarget.Weight:
                    _keypadValue = _weightValue;
                    break;
                case ModernKeypadTarget.Price:
                    _keypadValue = _priceValue;
                    break;
                case ModernKeypadTarget.Cost:
                    _keypadValue = _costValue;
                    break;
                default:
                    _keypadValue = _discountValue;
                    break;
            }
        }

        private void CommitKeypadValue()
        {
            if (_keypadTarget == ModernKeypadTarget.Weight && IsLiveWeightLocked)
                return;
            switch (_keypadTarget)
            {
                case ModernKeypadTarget.Weight:
                    _weightValue = _keypadValue;
                    break;
                case ModernKeypadTarget.Price:
                    _priceValue = _keypadValue;
                    break;
                case ModernKeypadTarget.Cost:
                    _costValue = _keypadValue;
                    break;
                default:
                    _discountValue = _keypadValue;
                    break;
            }
            RefreshModernValueDisplays();
        }

        private void RefreshModernValueDisplays()
        {
            txtWeightDisplay.Text = _weightValue.ToString("0.000", CultureInfo.CurrentCulture);
            string priceText = _priceValue.ToString("N2");
            txtPriceDisplay.Text = priceText;
            txtHeroPriceDisplay.Text = priceText;
            txtCostDisplay.Text = _costValue.ToString("N2");
            txtDiscountDisplay.Text = _discountValue.ToString("N2");
        }

        private void UpdateWeightFromScale(string scaleText)
        {
            if (!_isModernUi) return;
            if (decimal.TryParse(scaleText, NumberStyles.Any, CultureInfo.InvariantCulture, out decimal w) ||
                decimal.TryParse(scaleText, NumberStyles.Any, CultureInfo.CurrentCulture, out w))
            {
                _weightValue = w;
                if (_keypadTarget == ModernKeypadTarget.Weight)
                    _keypadValue = w;
                RefreshModernValueDisplays();
            }
        }

        private void InitWeightUomCombo()
        {
            if (txtWeightUom == null) return;

            string selected = NormalizeWeightUom(strWeightedUOM);
            strWeightedUOM = selected;
            txtWeightUom.Text = selected;
            lbUOM.Text = selected;
            HighlightWeightUomOptions();
        }

        private string NormalizeWeightUom(string uom)
        {
            if (string.IsNullOrWhiteSpace(uom)) return "Kg";

            string t = uom.Trim();
            if (t.Equals("Lb", StringComparison.OrdinalIgnoreCase) ||
                t.Equals("lbs", StringComparison.OrdinalIgnoreCase) ||
                t.Equals("pound", StringComparison.OrdinalIgnoreCase) ||
                t.Equals("pounds", StringComparison.OrdinalIgnoreCase))
                return "Lb";
            if (t.Equals("Kg", StringComparison.OrdinalIgnoreCase) ||
                t.Equals("kgs", StringComparison.OrdinalIgnoreCase) ||
                t.Equals("kilogram", StringComparison.OrdinalIgnoreCase) ||
                t.Equals("kilograms", StringComparison.OrdinalIgnoreCase))
                return "Kg";
            if (t.Equals("Grams", StringComparison.OrdinalIgnoreCase) ||
                t.Equals("gram", StringComparison.OrdinalIgnoreCase) ||
                t.Equals("g", StringComparison.OrdinalIgnoreCase) ||
                t.Equals("gm", StringComparison.OrdinalIgnoreCase) ||
                t.Equals("gms", StringComparison.OrdinalIgnoreCase))
                return "Grams";

            return "Kg";
        }

        private void ApplySelectedWeightUom()
        {
            string selected = txtWeightUom?.Text;
            if (string.IsNullOrWhiteSpace(selected))
                selected = NormalizeWeightUom(strWeightedUOM);

            strWeightedUOM = selected;
            txtWeightUom.Text = selected;
            lbUOM.Text = selected;
            HighlightWeightUomOptions();
        }

        private void HighlightWeightUomOptions()
        {
            if (btnUomLb == null || btnUomKg == null || btnUomGrams == null) return;

            Brush selectedBrush = TryFindResource("scPriceInput") as Brush;
            if (selectedBrush == null) selectedBrush = Brushes.Transparent;

            foreach (Button btn in new[] { btnUomLb, btnUomKg, btnUomGrams })
            {
                bool selected = string.Equals(Convert.ToString(btn.Tag), strWeightedUOM, StringComparison.OrdinalIgnoreCase);
                btn.FontWeight = selected ? FontWeights.Bold : FontWeights.SemiBold;
                btn.Background = selected ? selectedBrush : Brushes.Transparent;
            }
        }

        private bool _suppressWeightUomPopupOpen;

        private void bdWeightUomChip_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            _suppressWeightUomPopupOpen = popupWeightUom != null && popupWeightUom.IsOpen;
            Border chip = sender as Border;
            if (chip != null)
                chip.CaptureMouse();
            e.Handled = true;
        }

        private void bdWeightUomChip_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            Border chip = sender as Border;
            if (chip != null && chip.IsMouseCaptured)
                chip.ReleaseMouseCapture();
            e.Handled = true;

            if (_suppressWeightUomPopupOpen)
            {
                _suppressWeightUomPopupOpen = false;
                return;
            }

            HighlightWeightUomOptions();
            Dispatcher.BeginInvoke(new Action(() =>
            {
                if (popupWeightUom != null)
                    popupWeightUom.IsOpen = true;
            }), DispatcherPriority.Background);
        }

        private void WeightUomOption_Click(object sender, RoutedEventArgs e)
        {
            Button btn = sender as Button;
            if (btn == null) return;

            string selected = Convert.ToString(btn.Tag);
            if (string.IsNullOrWhiteSpace(selected)) return;

            strWeightedUOM = selected;
            txtWeightUom.Text = selected;
            lbUOM.Text = selected;
            popupWeightUom.IsOpen = false;
            HighlightWeightUomOptions();
            PersistWeightedUomToProduct();
            SetKeypadTarget(ModernKeypadTarget.Weight);
        }

        private void bdWeightHero_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            if (popupWeightUom != null && popupWeightUom.IsOpen)
                popupWeightUom.IsOpen = false;
            if (IsLiveWeightLocked) return;
            SetKeypadTarget(ModernKeypadTarget.Weight);
        }

        private void PersistWeightedUomToProduct()
        {
            if (!blWeighted) return;
            if (intProductID <= 0) return;

            string selected = NormalizeWeightUom(strWeightedUOM);
            if (string.IsNullOrWhiteSpace(selected)) return;

            try
            {
                PosDataObject.Product objProduct = new PosDataObject.Product();
                objProduct.Connection = new SqlConnection(SystemVariables.ConnectionString);
                objProduct.ID = intProductID;
                objProduct.UOM = selected;
                objProduct.UpdateWeightedUOM();
            }
            catch
            {
            }
        }

        private void bdPriceHero_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            SetKeypadTarget(ModernKeypadTarget.Price);
        }

        private void bdWeightPrice_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            SetKeypadTarget(ModernKeypadTarget.Price);
        }

        private void bdCost_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            SetKeypadTarget(ModernKeypadTarget.Cost);
        }

        private void bdDiscount_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            SetKeypadTarget(ModernKeypadTarget.Discount);
        }

        private void ModernKeypad_NumClick(object sender, RoutedEventArgs e)
        {
            if (_keypadTarget == ModernKeypadTarget.Weight && IsLiveWeightLocked) return;
            var btn = sender as Button;
            if (btn == null) return;
            if (!int.TryParse(Convert.ToString(btn.Content), out int digit))
                return;

            long units = ToKeypadUnits(_keypadValue, _keypadDecimals);
            units = units * 10 + digit;
            if (units > MaxKeypadUnits)
                units = MaxKeypadUnits;
            _keypadValue = FromKeypadUnits(units, _keypadDecimals);
            CommitKeypadValue();
        }

        private void ModernKeypad_ClearClick(object sender, RoutedEventArgs e)
        {
            if (_keypadTarget == ModernKeypadTarget.Weight && IsLiveWeightLocked) return;
            _keypadValue = 0m;
            CommitKeypadValue();
        }

        private void ModernKeypad_BackspaceClick(object sender, RoutedEventArgs e)
        {
            if (_keypadTarget == ModernKeypadTarget.Weight && IsLiveWeightLocked) return;
            long units = ToKeypadUnits(_keypadValue, _keypadDecimals);
            units = units / 10;
            if (units < 0) units = 0;
            _keypadValue = FromKeypadUnits(units, _keypadDecimals);
            CommitKeypadValue();
        }

        private void btnQtyMinus_Click(object sender, RoutedEventArgs e)
        {
            AdjustModernQuantity(-1);
        }

        private void btnQtyPlus_Click(object sender, RoutedEventArgs e)
        {
            AdjustModernQuantity(1);
        }

        private void AdjustModernQuantity(int delta)
        {
            int currentQty;
            if (!int.TryParse(txtModernQty.Text, NumberStyles.Integer, CultureInfo.CurrentCulture, out currentQty))
                currentQty = 1;
            currentQty += delta;
            if (currentQty < 1)
                currentQty = 1;
            txtModernQty.Text = currentQty.ToString();
        }
        #endregion
    }
}
