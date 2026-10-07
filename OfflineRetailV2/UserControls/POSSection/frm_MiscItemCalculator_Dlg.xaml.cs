using DevExpress.Xpf.Editors;
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

public class TaxOption
{
    public int ID { get; set; }
    public string TaxName { get; set; }
    public double TaxRate { get; set; }
}
namespace OfflineRetailV2.UserControls.POSSection
{
    public partial class frm_MiscItemCalculator_Dlg : Window
    {
        public const int WM_COPYDATA = 0x4A;
        public struct COPYDATASTRUCT
        {
            public IntPtr dwData;
            public int cbData;
            public string lpData;
        }

        private decimal _currentPriceValue = 0.00m;
        private bool _isDecimalMode = false;
        private int _decimalDigitsCount = 0;
        private const string CurrencySymbol = "£";
        private readonly CultureInfo UKCulture = new CultureInfo("en-GB");

        private string strProductDesc;
        private double intQty;
        private double dblPrice;
        private string strTaxApplicable1 = "Y";
        private string strTaxApplicable2 = "Y";
        private string strTaxApplicable3 = "Y";
        private bool blTaxChangeFlag = false;

        private double dblCost = 0.00;
        private double dblDiscount = 0.00;
        private bool blBlankLine = false;
        private string strTaxExempt = "N";

        private string strTaxID1 = "0";
        private string strTaxID2 = "0";
        private string strTaxID3 = "0";
        private string strTaxName1 = "";
        private string strTaxName2 = "";
        private string strTaxName3 = "";
        private string strTaxRate1 = "0";
        private string strTaxRate2 = "0";
        private string strTaxRate3 = "0";

        private string strServiceType = "Sales";

        private string strRentType = "DY";
        private double dblRentAmt = 0.00;
        private double dblRentDuration = 1.00;
        private double dblRepairAmt = 0.00;

        private string strRepairItemTag = "";
        private string strRepairItemSL = "";
        private string strRepairItemPurchase = "";

        private bool blWeighted = false;
        private bool blIsEdit = true;
        private bool blBottleRefund = false;
        private bool blFuelItem = false;

        private bool blProceedRentEditingWithoutDuration = false;

        string strCurrentServiceType = "Sales";
        private string weightstring = "";

        private int intSelectedTaxID1 = 0;
        private int intSelectedTaxID2 = 0;
        private int intSelectedTaxID3 = 0;

        private string strWeightedUOM = "";

        NumKeyboard nkybrd;
        bool IsAboutNumKybrdOpen = false;

        FullKeyboard fkybrd;
        bool IsAboutFullKybrdOpen = false;

        public string WeightedUOM
        {
            get { return strWeightedUOM; }
            set { }
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

        public bool TaxChangeFlag
        {
            get { return blTaxChangeFlag; }
            set { }
        }


        public bool bProceedRentEditingWithoutDuration
        {
            get { return blProceedRentEditingWithoutDuration; }
            set { }
        }

        public string ServiceType
        {
            get { return strServiceType; }
            set { }
        }

        public string RentType
        {
            get { return strRentType; }
            set { }
        }

        public string RepairItemTag
        {
            get { return strRepairItemTag; }
            set { }
        }

        public string RepairItemSL
        {
            get { return strRepairItemSL; }
            set { }
        }

        public string RepairItemPurchase
        {
            get { return strRepairItemPurchase; }
            set { }
        }

        public bool IsEdit
        {
            get { return blIsEdit; }
            set { }
        }

        public bool FuelItem
        {
            get { return blFuelItem; }
            set { }
        }

        public bool Weighted
        {
            get { return blWeighted; }
            set { }
        }

        public double RentAmt
        {
            get { return dblRentAmt; }
            set { }
        }

        public double RentDuration
        {
            get { return dblRentDuration; }
            set { }
        }

        public double RepairAmt
        {
            get { return dblRepairAmt; }
            set { }
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
            set { }
        }

        public bool BottleRefund
        {
            get { return blBottleRefund; }
            set { }
        }

        public string TaxExempt
        {
            get { return strTaxExempt; }
            set { }
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
            get { return (double)_currentPriceValue; }
            set { _currentPriceValue = (decimal)value; }
        }
        public double Cost
        {
            get { return dblCost; }
            set { }
        }

        public double Discount
        {
            get { return dblDiscount; }
            set { }
        }

        public frm_MiscItemCalculator_Dlg()
        {
            InitializeComponent();
            ModalWindow.CloseCommand = new CommandBase(OnClose);
            Closed += (_, __) => CloseKeyboards();
        }

        private void OnClose(object obj)
        {
            DialogResult = false;
            StopListeningToScale();
            CloseKeyboards();
            ResMan.closeKeyboard();
            Close();
        }
        private void InitializeKeyboards()
        {
            // Instantiate them once on load
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
            nkybrd.Closing += NKybrd_Closing; // Crucial: Handle closing to just hide

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
            fkybrd.Closing += FKybrd_Closing;
        }
        private void CloseKeyboards()
        {
            if (fkybrd != null)
            {
                fkybrd.Closing -= FKybrd_Closing;
                IsAboutFullKybrdOpen = false;
                try
                {
                    fkybrd.Close();
                }
                catch
                {
                }
                fkybrd = null;
            }
            IsAboutFullKybrdOpen = false;

            if (nkybrd != null)
            {
                nkybrd.Closing -= NKybrd_Closing;
                IsAboutNumKybrdOpen = false;
                try
                {
                    nkybrd.Close();
                }
                catch
                {
                }
                nkybrd = null;
            }
            IsAboutNumKybrdOpen = false;
        }


        private void Full_LostFocus(object sender, RoutedEventArgs e)
        {
            // The reason focus is lost is often immediately followed by a GotFocus 
            // on the FullKeyboard itself (if it's not a TopMost/Owner window).

            // However, since the external keyboards are likely handling the key input
            // and passing the value back, the easiest way to stop the flicker 
            // is to ONLY call CloseKeyboards when the dialogue itself is closing.

            // If you MUST close it on LostFocus, you need a safe guard:

            // Check if the new focus target is the FullKeyboard window (fkybrd)
            if (fkybrd != null && fkybrd.IsActive)
            {
                // Focus is moving to the keyboard window, do nothing.
                return;
            }

            // If focus is truly leaving the text entry process entirely:
            CloseKeyboards();
        }

        // And for a temporary test, you can remove the entire LostFocus handler from the TextEdit.


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

                try
                {
                    Window posMain = System.Windows.Application.Current.MainWindow ?? this;
                    Rect workArea = ScreenHelper.GetWorkAreaForWindow(posMain);
                    fkybrd.Left = workArea.Left + (workArea.Width - fkybrd.Width) / 2;
                    fkybrd.Top = workArea.Bottom - fkybrd.Height - 10;
                }
                catch
                {
                    fkybrd.Left = GeneralFunctions.fnInt32((SystemParameters.WorkArea.Width - 800) / 2);
                    fkybrd.Top = SystemParameters.WorkArea.Height - fkybrd.Height - 10;
                }

                fkybrd.Closing += FKybrd_Closing;
                fkybrd.Show();
                IsAboutFullKybrdOpen = true;
            }
        }
        //private void Full_GotFocus(object sender, RoutedEventArgs e)
        //{
        //    if (Settings.UseTouchKeyboardInAdmin == "N") return;
        //    CloseKeyboards();

        //    if (!IsAboutFullKybrdOpen)
        //    {
        //        fkybrd = new FullKeyboard();

        //        var location = (sender as DevExpress.Xpf.Editors.TextEdit).PointToScreen(new Point(0, 0));
        //        fkybrd.Left = GeneralFunctions.fnInt32((SystemParameters.WorkArea.Width - 800) / 2);
        //        if (location.Y + 35 + 320 > System.Windows.SystemParameters.WorkArea.Height)
        //        {
        //            fkybrd.Top = location.Y - 35 - 320;
        //        }
        //        else
        //        {
        //            fkybrd.Top = location.Y + 35;
        //        }

        //        fkybrd.Height = 320;
        //        fkybrd.Width = 800;
        //        fkybrd.IsWindow = true;
        //        fkybrd.calledform = this;
        //        fkybrd.Closing += new System.ComponentModel.CancelEventHandler(FKybrd_Closing);
        //        fkybrd.Show();
        //        IsAboutFullKybrdOpen = true;
        //    }

        //}

        private void FKybrd_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            IsAboutFullKybrdOpen = false;
            e.Cancel = false;
        }


        private void Num_LostFocus(object sender, RoutedEventArgs e)
        {
            //CloseKeyboards();
        }

        private void UpdatePriceDisplay()
        {
            // 1. Format the price as a Number with 2 decimals (N2). This omits the culture's default symbol.
            string priceText = _currentPriceValue.ToString("N2", UKCulture);

            // 2. Prepend the globally stored currency symbol to the left side.
            numPrice.Text = SystemVariables.CurrencySymbol + priceText;
        }

        private const long MaxCents = 999999999999; 

        private long ToCents(decimal value)
        {
            return (long)Math.Round(value * 100);
        }

        private decimal FromCents(long cents)
        {
            return cents / 100m;
        }





        private void Keypad_NumClick(object sender, RoutedEventArgs e)
        {
            var btn = sender as Button;
            if (btn == null) return;

            if (!int.TryParse(btn.Content.ToString(), out int digit))
                return;

            long cents = ToCents(_currentPriceValue);

            if (_isDecimalMode)
            {
                // Typing after decimal point
                if (_decimalDigitsCount == 0)
                {
                    // Add first decimal digit (tenths)
                    cents = (cents / 100) * 100 + digit * 10;
                    _decimalDigitsCount = 1;
                }
                else if (_decimalDigitsCount == 1)
                {
                    // Add second decimal digit (hundredths)
                    cents = (cents / 10) * 10 + digit;
                    _decimalDigitsCount = 2;
                }
                else
                {
                    // Already two decimals — ignore more
                    return;
                }
            }
            else
            {
                // Auto-shifting integer logic
                cents = cents * 10 + digit;
                if (cents > MaxCents)
                    cents = MaxCents;
            }

            _currentPriceValue = FromCents(cents);
            UpdatePriceDisplay();
        }

        private void Keypad_DotClick(object sender, RoutedEventArgs e)
        {
            // Enter decimal editing mode
            _isDecimalMode = true;

            // Determine how many decimal digits already exist
            long cents = ToCents(_currentPriceValue);
            int ones = (int)(cents % 10);
            int tens = (int)((cents / 10) % 10);

            if (tens != 0 && ones != 0)
                _decimalDigitsCount = 2;
            else if (tens != 0 || ones != 0)
                _decimalDigitsCount = 1;
            else
                _decimalDigitsCount = 0;
        }

        private void Keypad_BackspaceClick(object sender, RoutedEventArgs e)
        {
            long cents = ToCents(_currentPriceValue);

            if (_isDecimalMode)
            {
                if (_decimalDigitsCount == 2)
                {
                    // Remove hundredths
                    cents = (cents / 10) * 10;
                    _decimalDigitsCount = 1;
                }
                else if (_decimalDigitsCount == 1)
                {
                    // Remove tenths
                    cents = (cents / 100) * 100;
                    _decimalDigitsCount = 0;
                }
                else
                {
                    // Backspace when no decimals — go back to integer mode
                    _isDecimalMode = false;
                }
            }
            else
            {
                // Remove last integer digit
                cents = cents / 10;
            }

            if (cents < 0) cents = 0;

            _currentPriceValue = FromCents(cents);

            // Reset if cleared
            if (_currentPriceValue == 0m)
            {
                _isDecimalMode = false;
                _decimalDigitsCount = 0;
            }

            UpdatePriceDisplay();
        }




        private void Num_GotFocus(object sender, RoutedEventArgs e)
        {
            if (Settings.UseTouchKeyboardInPOS == "N") return;

            // Hide Full keyboard if open
            if (IsAboutFullKybrdOpen) fkybrd.Hide();

            // Select text
            Dispatcher.BeginInvoke(new Action(() => (sender as DevExpress.Xpf.Editors.TextEdit)?.SelectAll()));

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
                nkybrd.Closing += NKybrd_Closing;
                PositionKeyboard(nkybrd);
                nkybrd.Show();
                IsAboutNumKybrdOpen = true;
            }
        }
        private void PositionKeyboard(Window kb)
        {
            Window parentWindow = Window.GetWindow(Application.Current.MainWindow) ?? Application.Current.MainWindow;
            if (parentWindow != null)
            {
                Rect workArea = OfflineRetailV2.Data.ScreenHelper.GetWorkAreaForWindow(parentWindow);
                kb.Left = workArea.Left + (workArea.Width - kb.Width) / 2;
                kb.Top = workArea.Bottom - kb.Height - 10;
            }
        }

        private void NKybrd_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            IsAboutNumKybrdOpen = false;
            e.Cancel = false;
        }

        private void btnWeight_Click(object sender, RoutedEventArgs e)
        {
        }

        private void btnKeyboard_Click(object sender, RoutedEventArgs e)
        {
            //ResMan.ShowFullKeyboard();
        }

        private void SetRentTypeButtonColor()
        {
        }
        private void rb1_Click(object sender, RoutedEventArgs e)
        {
        }


        private void btnOK_Click(object sender, RoutedEventArgs e)
        {
            if (strServiceType == "Sales")
            {
                if (txtProduct.Text.Trim() == "")
                {
                    DocMessage.MsgInformation(Properties.Resources.Enter_Product);
                    GeneralFunctions.SetFocus(txtProduct);
                    return;
                }

                if (!double.TryParse(txtQty.Text, out double qty) || qty <= 0)
                {
                    DocMessage.MsgInformation(Properties.Resources.Enter_valid_weight);
                    //GeneralFunctions.SetFocus(txtQty);
                    return;
                }

                if (_currentPriceValue <= 0)
                {
                    DocMessage.MsgInformation("Enter valid Price.");
                    return;
                }


                strProductDesc = txtProduct.Text;
                intQty = GeneralFunctions.fnDouble(txtQty.Text);
                dblPrice = (double)_currentPriceValue;
                dblDiscount = 0.00;
                dblCost = 0.00;

                GetApplicableTax();

            }

            DialogResult = true;
            StopListeningToScale();
            CloseKeyboards();
            Close();
        }

        private void FillTax()
        {
            var taxOptions = new List<TaxOption>();

            // ✅ Default "No Tax" option
            taxOptions.Add(new TaxOption { ID = 0, TaxName = "No Tax (0%)", TaxRate = 0.00 });

            try
            {
                PosDataObject.Tax objTax = new PosDataObject.Tax();
                objTax.Connection = new SqlConnection(SystemVariables.ConnectionString);

                DataTable dtblTaxHeader = objTax.FetchActiveTax();

                foreach (DataRow dr in dtblTaxHeader.Rows)
                {
                    int taxId = GeneralFunctions.fnInt32(dr["ID"].ToString());
                    double taxRate = GeneralFunctions.fnDouble(dr["TaxRate"].ToString());

                    // Skip if tax rate is 0 (handled by default option above)
                    if (taxRate == 0)
                        continue;

                    // 🏷️ Fetch the descriptive name directly from the database table row field
                    // Note: If your column name is different (e.g., "TaxDescription"), swap it here.
                    string dbTaxName = dr.Table.Columns.Contains("TaxName") ? dr["TaxName"].ToString().Trim() : "Tax";

                    // Combine them nicely: "Complete Name (Rate%)" -> e.g., "Standard VAT (20%)"
                    string displayTaxName = $"{dbTaxName} ({taxRate.ToString("0")}%)";

                    taxOptions.Add(new TaxOption
                    {
                        ID = taxId,
                        TaxName = displayTaxName,
                        TaxRate = taxRate
                    });

                    // Preserve reference tracking variables
                    if (taxOptions.Count - 1 == 1)
                    {
                        strTaxID1 = dr["ID"].ToString();
                        strTaxName1 = displayTaxName;
                        strTaxRate1 = dr["TaxRate"].ToString();
                    }
                    else if (taxOptions.Count - 1 == 2)
                    {
                        strTaxID2 = dr["ID"].ToString();
                        strTaxName2 = displayTaxName;
                        strTaxRate2 = dr["TaxRate"].ToString();
                    }
                    else if (taxOptions.Count - 1 == 3)
                    {
                        strTaxID3 = dr["ID"].ToString();
                        strTaxName3 = displayTaxName;
                        strTaxRate3 = dr["TaxRate"].ToString();
                    }
                }

                dtblTaxHeader.Dispose();
            }
            catch (Exception)
            {
                // optional logging if needed
            }

            cmbTaxType.ItemsSource = taxOptions;
            cmbTaxType.DisplayMember = "TaxName";
            cmbTaxType.ValueMember = "ID";
        }


        private void SetSelectedTax()
        {
            int currentTaxID = 0;

            if (strTaxApplicable1 == "Y" && GeneralFunctions.fnInt32(strTaxID1) > 0)
            {
                currentTaxID = GeneralFunctions.fnInt32(strTaxID1);
            }
            else if (strTaxApplicable2 == "Y" && GeneralFunctions.fnInt32(strTaxID2) > 0)
            {
                currentTaxID = GeneralFunctions.fnInt32(strTaxID2);
            }
            else if (strTaxApplicable3 == "Y" && GeneralFunctions.fnInt32(strTaxID3) > 0)
            {
                currentTaxID = GeneralFunctions.fnInt32(strTaxID3);
            }

            cmbTaxType.EditValue = currentTaxID;
        }
        private void SetNoTax()
        {
            cmbTaxType.EditValue = 0;
        }
        private void GetApplicableTax()
        {
            int selectedID = GeneralFunctions.fnInt32(cmbTaxType.EditValue);

            strTaxApplicable1 = "N";
            strTaxApplicable2 = "N";
            strTaxApplicable3 = "N";

            if (selectedID == GeneralFunctions.fnInt32(strTaxID1))
            {
                strTaxApplicable1 = "Y";
            }
            else if (selectedID == GeneralFunctions.fnInt32(strTaxID2))
            {
                strTaxApplicable2 = "Y";
            }
            else if (selectedID == GeneralFunctions.fnInt32(strTaxID3))
            {
                strTaxApplicable3 = "Y";
            }

            int tcurrtx1 = (strTaxApplicable1 == "Y") ? 1 : 0;
            int tcurrtx2 = (strTaxApplicable2 == "Y") ? 1 : 0;
            int tcurrtx3 = (strTaxApplicable3 == "Y") ? 1 : 0;

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
        }
        private void TxtRentPrice_EditValueChanged(object sender, DevExpress.Xpf.Editors.EditValueChangedEventArgs e)
        {
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
                // 1. REMOVED: File.AppendAllText (Major bottleneck)

                // 2. Efficiently read existing bytes
                int bytesToRead = _serialPort.BytesToRead;
                byte[] data = new byte[bytesToRead];
                _serialPort.Read(data, 0, bytesToRead);

                // 3. Queue data
                foreach (byte b in data)
                {
                    recievedData.Enqueue(b);
                }

                ProcessScaleData();
            }
            catch (Exception)
            {
                // Swallowed exception to prevent crash, but removed disk I/O logging
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
            // Check count first to avoid unnecessary looping
            if (recievedData.Count == 25)
            {
                // Build string using StringBuilder (Faster than string concatenation)
                StringBuilder sb = new StringBuilder();
                foreach (var item in recievedData)
                {
                    sb.Append((char)item);
                }

                string msg = sb.ToString();
                recievedData.Clear();

                float weight = 0;
                // Safe check for string length
                if (msg.Length > 5 && msg.Substring(3, 1) == "3")
                {
                    if (float.TryParse(msg.Substring(5, 5), out float parsedWeight))
                    {
                        weight = parsedWeight / 1000;
                    }
                }

                scaleWeightText = weight.ToString();

                // Only invoke UI if weight actually changed (optional optimization)
                Dispatcher.Invoke(() =>
                {
                    // UI Updates here
                });
            }
        }

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

                // Write directly without logging
                _serialPort.Write(new byte[] { 4 }, 0, 1);
                _serialPort.Write(new byte[] { 5 }, 0, 1);
            }
            catch (Exception)
            {
                // Removed disk logging
                return;
            }
        }
        #endregion

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            if (Settings.ScaleDevice == "Live Weight")
            {
                #region LiveWeightSacle XX
                try
                {

                    _serialPort.PortName = Settings.COMPort1;
                    _serialPort.BaudRate = int.Parse(Settings.BaudRate);

                    _serialPort.DataBits = int.Parse(Settings.DataBits);
                    if (Enum.TryParse(Settings.Parity, true, out System.IO.Ports.Parity parityValue))
                    {
                        _serialPort.Parity = parityValue;
                    }
                    else
                    {
                        _serialPort.Parity = System.IO.Ports.Parity.None;
                    }
                    if (Enum.TryParse(Settings.StopBits, true, out System.IO.Ports.StopBits stopBitsValue))
                    {
                        _serialPort.StopBits = stopBitsValue;
                    }
                    else
                    {
                        _serialPort.StopBits = System.IO.Ports.StopBits.One;
                    }

                    string logFilePath = System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "scaleLog.txt");

                    if (!File.Exists(logFilePath))
                    {
                        File.Create(logFilePath).Dispose();
                    }

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
                catch (Exception)
                {
                }
            }
            #endregion

            {
                //txtProduct.Text = strProductDesc;

                // ✅ Ensure quantity starts at 1
                if (intQty <= 0)
                {
                    intQty = 1;
                }
                txtQty.Text = intQty.ToString("N0", UKCulture);

                _currentPriceValue = (decimal)dblPrice;
                UpdatePriceDisplay();

                

                // ✅ Fill taxes and default select 0%
                FillTax();
                cmbTaxType.EditValue = 0; // Ensure 0% selected by default


            }
        }

        private void DtRepairPurchase_PreviewMouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
        }
        private void AdjustQuantity(double delta)
        {
            // 1. Try to parse the current Text value as an integer (whole number only).
            if (int.TryParse(txtQty.Text, NumberStyles.Integer, UKCulture, out int currentQty))
            {
                // 2. Perform the addition or subtraction.
                int newQty = currentQty + (int)delta;

                // 3. Prevent quantity from going below zero.
                if (newQty < 0)
                    newQty = 0;

                // 4. Update the Text — show as integer only (no decimals).
                txtQty.Text = newQty.ToString("N0", UKCulture);
            }
            else
            {
                // If parsing fails, reset to safe default.
                txtQty.Text = 1.ToString("N0", UKCulture);
            }

            // 5. Update backing property (if you have one for current quantity).
            intQty = int.Parse(txtQty.Text, NumberStyles.Integer, UKCulture);
        }


        private void btnQtyMinus_Click(object sender, RoutedEventArgs e)
        {
            AdjustQuantity(-1);
            Keyboard.Focus(txtQty);
        }

        private void btnQtyPlus_Click(object sender, RoutedEventArgs e)
        {
            AdjustQuantity(1);
            Keyboard.Focus(txtQty);
        }

        private void txtProduct_MouseRightButtonDown(object sender, MouseButtonEventArgs e)
        {
            
        }

        private void txtProduct_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            
        }

        private void Keypad_ClearBtnClick(object sender, RoutedEventArgs e)
        {
            // 1. Reset the actual price value to zero
            _currentPriceValue = 0.00m;

            // 2. Reset the flags that track input state (decimal mode and digit counts)
            _isDecimalMode = false;
            _decimalDigitsCount = 0;

            // 3. Update the UI text to show the zeroed currency (e.g., £0.00)
            UpdatePriceDisplay();
        }

        //private void btnAdvanced_Click(object sender, RoutedEventArgs e)
        //{
        //    this.Close();
        //    AddProductWindow addProductWindow = new AddProductWindow();
        //    addProductWindow.ShowDialog();
        //}
    }
}
