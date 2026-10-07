using OfflineRetailV2.Data;
using PosDataObject;
using System;
using System.Windows;
using System.Windows.Input;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.Window;

namespace OfflineRetailV2.UserControls.POSSection
{
    public partial class frmPOSShowBalanceDlg2 : Window
    {
        private double dblTotalsale;
        private double dblTender;
        private double dblChange;
        private bool blprintok = false;
        private bool isKeepOpen = false;
        private bool blpreview = false;
        private bool isInitializing = true;

        public double Totalsale { get => dblTotalsale; set => dblTotalsale = value; }
        public double Tender { get => dblTender; set => dblTender = value; }
        public double Change { get => dblChange; set => dblChange = value; }
        public bool PrintOK { get => blprintok; set => blprintok = value; }
        public bool IsKeepOpen { get => isKeepOpen; set => isKeepOpen = value; }
        public bool PreviewMode { get => blpreview; set => blpreview = value; }
        public bool IsButtonClicked { get; private set; } = false;
        public frmPOSShowBalanceDlg2()
        {
            InitializeComponent();
            InitializeSettings();
            isInitializing = false;
        }

        private void InitializeSettings()
        {
            printerIMG.Visibility = Settings.POSPrintInvoice != 2
                ? Visibility.Visible
                : Visibility.Collapsed;
            tsPrint.IsChecked = Settings.POSPrintInvoice == 1;

            if (Settings.POSShowBalanceDialog == 1 && Settings.POSPrintInvoice == 0)
            {
                tsPrint.Visibility = Visibility.Collapsed;
            }
            else
            {
                tsPrint.Visibility = Visibility.Visible;
            }
        }

        private void TsPrint_Checked(object sender, RoutedEventArgs e)
        {
            if (isInitializing) return;
            UpdatePrintSetting(1); // 1 = Direct Print
        }

        private void TsPrint_Unchecked(object sender, RoutedEventArgs e)
        {
            if (isInitializing) return;
            UpdatePrintSetting(2); // 2 = No Print
        }

        private void UpdatePrintSetting(int printMode)
        {
            try
            {
                var setup = new Setup();
                string result = setup.UpdatePOSPrintInvoiceSetting(printMode);
                if (!string.IsNullOrEmpty(result))
                {
                    throw new Exception(result);
                }
                Settings.POSPrintInvoice = printMode;
            }
            catch (Exception ex)
            {
                tsPrint.IsChecked = printMode != 1;
                MessageBox.Show($"Failed to update print setting: {ex.Message}",
                    "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            SetDecimalPlace();
            UpdateDisplayValues();

            if (!this.IsKeepOpen)
            {
                if (Settings.POSShowBalanceDialog == 1 && Settings.POSPrintInvoice == 1)
                {
                    this.blprintok = true;
                    this.blpreview = tsPrint.IsChecked == true;
                    this.DialogResult = true;
                    this.Close();
                }
            }

        }

        private void SetDecimalPlace()
        {
            // Implement decimal formatting if needed
        }

        private void UpdateDisplayValues()
        {
            string format = Settings.DecimalPlace == 3 ? "f3" : "f2";
            numTotalsale.Text = $"{SystemVariables.CurrencySymbol} {dblTotalsale.ToString(format)}";
            numTender.Text = $"{SystemVariables.CurrencySymbol} {dblTender.ToString(format)}";
            numChangeDue.Text = $"{SystemVariables.CurrencySymbol} {dblChange.ToString(format)}";
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            IsButtonClicked = true;

            if (this.IsKeepOpen != true)
            {
                this.Hide();
            }

            this.Close();
        }

        private void PrintButton_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            this.blprintok = true;
            this.blpreview = tsPrint.IsChecked == true;
            this.DialogResult = true;
           
        }
    }
}