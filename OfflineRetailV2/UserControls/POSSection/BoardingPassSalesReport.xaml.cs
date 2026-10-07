using DevExpress.XtraGauges.Core.Model;
using OfflineRetailV2.Data;
using System;
using System.Data;
using System.Windows;
using DevExpress.Xpf.Editors.Settings; // Add this
namespace OfflineRetailV2
{
    public partial class BoardingPassSalesReport : Window
    {
        public BoardingPassSalesReport()
        {
            InitializeComponent();

            blurGrid.Visibility = Visibility.Visible;

            dtStart.DateTime = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
            dtEnd.DateTime = DateTime.Today;

            // Apply Dynamic Currency Formatting
            ApplyCurrencyFormatting();

            PopulateFlightFilters();

            ModalWindow.CloseCommand = new CommandBase(OnClose);
        }

        private void ApplyCurrencyFormatting()
        {
            string symbol = SystemVariables.CurrencySymbol;
            // Standard numeric format: Symbol + space + number with 2 decimals
            string currencyFormat = $"{symbol} #,##0.00";

            // 1. Fix for Total Revenue TextEdit
            txtTotalRevenue.MaskType = DevExpress.Xpf.Editors.MaskType.Numeric;
            txtTotalRevenue.Mask = currencyFormat;
            txtTotalRevenue.MaskUseAsDisplayFormat = true;

            // 2. Fix for Grid Summary (Searching by FieldName)
            foreach (var item in grdReport.TotalSummary)
            {
                if (item.FieldName == "RevenueGenerated")
                {
                    // Use {0:n2} to keep the custom symbol and 2 decimal places
                    item.DisplayFormat = "Sum: " + symbol + " {0:n2}";
                }
            }

            // 3. Fix for Grid Columns
            grdReport.ColumnsPopulated += (s, e) => {
                // Inside your ColumnsPopulated event handler:
                if (grdReport.Columns["RevenueGenerated"] != null)
                {
                    var editSettings = new TextEditSettings
                    {
                        MaskType = DevExpress.Xpf.Editors.MaskType.Numeric,
                        Mask = currencyFormat,
                        MaskUseAsDisplayFormat = true,
                        // This aligns the text inside the cells to the left
                        HorizontalContentAlignment = EditSettingsHorizontalAlignment.Left
                    };
                    grdReport.Columns["RevenueGenerated"].EditSettings = editSettings;

                    // This aligns the column header text to the left
                    grdReport.Columns["RevenueGenerated"].HorizontalHeaderContentAlignment = HorizontalAlignment.Left;
                }
            };
        }
        private void DateEdit_PreviewMouseLeftButtonDown(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            if (sender is DevExpress.Xpf.Editors.DateEdit dateEdit)
            {
                if (!dateEdit.IsPopupOpen)
                {
                    dateEdit.ShowPopup();
                    e.Handled = true; // Prevents subsequent mouse events from closing it instantly
                }
            }
        }

        
        private void OnClose(object obj)
        {
            Close();
        }

        private void BtnGenerate_Click(object sender, RoutedEventArgs e)
        {
            // 1. Extract and sanitize filter values
            string flightNo = (cmbFlightNo.Text == "All Flights" || string.IsNullOrEmpty(cmbFlightNo.Text))
                              ? ""
                              : cmbFlightNo.Text;

            string origin = (string.IsNullOrEmpty(cmbFromFlight.Text) || cmbFromFlight.Text.Contains("Select"))
                            ? ""
                            : cmbFromFlight.Text;

            string destination = (string.IsNullOrEmpty(cmbToFlight.Text) || cmbToFlight.Text.Contains("Select"))
                                ? ""
                                : cmbToFlight.Text;

            // --- NEW: Extract Date Values ---
            DateTime startDate = dtStart.DateTime;
            DateTime endDate = dtEnd.DateTime;

            // 2. Execute Data Retrieval
            PosDataObject.POS objPos = new PosDataObject.POS();
            objPos.Connection = SystemVariables.Conn;

            try
            {
                // Updated method call to include dates
                DataTable dt = objPos.GetSalesReport(flightNo, origin, destination, startDate, endDate);

                // --- REVENUE CALCULATION LOGIC ---
                decimal totalRevenue = 0;

                if (dt != null && dt.Rows.Count > 0)
                {
                    object sumObject = dt.Compute("Sum(RevenueGenerated)", "");

                    if (sumObject != DBNull.Value)
                    {
                        totalRevenue = Convert.ToDecimal(sumObject);
                    }
                }

                txtTotalRevenue.EditValue = totalRevenue;

                // Bind the result to the grid
                grdReport.ItemsSource = dt.DefaultView;

                if (dt.Rows.Count == 0)
                {
                    DocMessage.MsgInformation("No sales data found for the selected criteria.");
                }
            }
            catch (Exception ex)
            {
                DocMessage.MsgInformation("Error generating report: " + ex.Message);
            }
        }

        private void CmbFlightNo_SelectedIndexChanged(object sender, RoutedEventArgs e)
        {
            if (cmbFlightNo.SelectedIndex < 0 || cmbFlightNo.EditValue == null) return;

            if (cmbFlightNo.SelectedItem is DataRowView selectedRow)
            {
                string origin = selectedRow["OriginAirport"]?.ToString();
                string destination = selectedRow["DestinationAirport"]?.ToString();

                if (!string.IsNullOrEmpty(origin))
                    cmbFromFlight.EditValue = origin;

                if (!string.IsNullOrEmpty(destination))
                    cmbToFlight.EditValue = destination;
            }
        }

        private void BtnPrint_Click(object sender, RoutedEventArgs e)
        {
            if (grdReport.ItemsSource == null) return;

            viewReport.ShowPrintPreview(this, "Boarding Pass Sales Report");
        }

        private void PopulateFlightFilters()
        {
            PosDataObject.POS objPos = new PosDataObject.POS();
            objPos.Connection = SystemVariables.Conn;

            // 1. Populate Flight Numbers
            DataTable dtFlights = objPos.GetUniqueFlightNumbers();
            cmbFlightNo.ItemsSource = dtFlights.DefaultView;
            cmbFlightNo.DisplayMember = "FlightNumber";
            cmbFlightNo.ValueMember = "FlightNumber";

            // 2. Populate Origins
            DataTable dtOrigins = objPos.GetUniqueOrigins();
            cmbFromFlight.ItemsSource = dtOrigins.DefaultView;
            cmbFromFlight.DisplayMember = "OriginAirport";
            cmbFromFlight.ValueMember = "OriginAirport";

            // 3. Populate Destinations
            DataTable dtDestinations = objPos.GetUniqueDestinations();
            cmbToFlight.ItemsSource = dtDestinations.DefaultView;
            cmbToFlight.DisplayMember = "DestinationAirport";
            cmbToFlight.ValueMember = "DestinationAirport";
        }
    }
}