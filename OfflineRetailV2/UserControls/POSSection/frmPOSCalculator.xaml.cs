using DevExpress.Xpf.Editors;
using OfflineRetailV2.Data;
using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace OfflineRetailV2.UserControls.POSSection
{
    public partial class frmPOSCalculator : Window
    {
        public double Price { get; private set; } = -1;
        private string input = ""; // stores only digits, no dots or symbols

        public frmPOSCalculator()
        {
            InitializeComponent();
            UpdateDisplay();
            ModalWindow.CloseCommand = new CommandBase(OnCloseCommand);
        }

        public string DisplayName
        {
            get => lblCatName?.Text;
            set { if (lblCatName != null) lblCatName.Text = value; }
        }

        private void Key_Click(object sender, RoutedEventArgs e)
        {
            string val = ((Button)sender).Content.ToString();

            // Only accept digits
            if (!char.IsDigit(val[0])) return;

            // Limit total input length (e.g., 8 digits max)
            if (input.Length >= 8) return;

            input += val;
            UpdateDisplay();
        }

        private void Backspace_Click(object sender, RoutedEventArgs e)
        {
            if (input.Length > 0)
            {
                input = input.Substring(0, input.Length - 1);
            }
            UpdateDisplay();
        }

        private void UpdateDisplay()
        {
            string symbol = SystemVariables.CurrencySymbol;
            if (string.IsNullOrEmpty(input))
            {
                txtDisplay.Text = $"{symbol}0.00";
                ToggleButtons(false);
                return;
            }

            // Parse as integer pennies and divide by 100
            if (long.TryParse(input, out long pennies))
            {
                double amount = pennies / 100.0;
                txtDisplay.Text = $"{symbol}{amount:F2}";
                ToggleButtons(amount > 0);
            }
            else
            {
                txtDisplay.Text = $"{symbol}0.00";
                ToggleButtons(false);
            }
        }

        private void ToggleButtons(bool enable)
        {
            btnPayNow.IsEnabled = enable;
            btnPayNow.Opacity = enable ? 1 : 0.5;
            btnCloseAmount.IsEnabled = enable;
            btnCloseAmount.Opacity = enable ? 1 : 0.5;
        }

        private void PayNow_Click(object sender, RoutedEventArgs e)
        {
            if (long.TryParse(input, out long pennies))
            {
                Price = pennies / 100.0;
                DialogResult = true;
                Close();
            }
        }

        private void Close_Click(object sender, RoutedEventArgs e)
        {
            DialogResult = false;
            Close();
        }

        private void btnCloseAmount_Click(object sender, RoutedEventArgs e)
        {
            input = "";
            UpdateDisplay();
        }

        private void OnCloseCommand(object obj)
        {
            Close();
        }
    }
}
