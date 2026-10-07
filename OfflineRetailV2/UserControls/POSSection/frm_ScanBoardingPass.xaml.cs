using OfflineRetailV2.Data;     // Namespace for ParseResult, etc.
using System;
using System.Data;
using System.Linq;
using System.Windows;
using System.Windows.Input;


namespace OfflineRetailV2
{
    public partial class frm_ScanBoardingPass : Window
    {
        private ParseResult _currentScanResult;
        public bool isSkipped;
        public BcbpBoardingPass ScannedPass { get; private set; }   
        public frm_ScanBoardingPass()
        {
            InitializeComponent();
            ModalWindow.CloseCommand = new CommandBase(OnCloseCOmmand);
        }

        private void OnCloseCOmmand(object obj)
        {
            Settings.IsBoardingPassSkipped = false;
            Close();
        }

        private void TxtScanInput_PreviewKeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                string rawData = txtScanInput.Text?.Trim();

                if (!string.IsNullOrEmpty(rawData))
                {
                    // Verify if the scanned data matches the IATA BCBP format
                    if (IsBoardingPassFormat(rawData))
                    {
                        ProcessBoardingPass(rawData);
                        txtScanInput.Clear();
                        // --- ENABLE THE BUTTON HERE ---
                    }
                    else
                    {
                        // This is a retail coupon or invalid barcode.
                        // We keep it in the input field (or show an alert) and do not parse it.
                        DocMessage.MsgInformation("Scanned item is not a valid boarding pass barcode.");

                        txtScanInput.Focus();
                        txtScanInput.Clear(); // Always clear after any attempt
                        txtScanInput.SelectAll();
                    }
                }
            }
        }
        private bool IsBoardingPassFormat(string data)
        {
            // 1. Basic length check (IATA BCBP is usually 60+, iCoupons can be shorter)
            if (string.IsNullOrEmpty(data) || data.Length < 40)
                return false;

            // 2. Format Indicator: Must start with 'M'
            if (char.ToUpper(data[0]) != 'M')
                return false;

            // 3. Passenger Name Check: 
            // In BCBP, index 2-22 is the name. It almost always contains a '/' 
            // to separate Last Name/First Name. iCoupons do not use this format.
            string nameSection = data.Substring(2, 21);
            if (!nameSection.Contains("/"))
                return false;

            // 4. Junk Filter: iCoupons often use long strings of the same character (like 'XXXX')
            // We can reject data that looks like placeholder text.
            if (nameSection.Contains("XXXXX"))
                return false;

            // 5. Electronic Ticket Indicator:
            // In standard BCBP, index 29 is usually 'E' for Electronic Ticket.
            // In your boarding pass sample: "EAJ4VF5" -> 'E' is at index 23. 
            // (Note: Position varies slightly by airline version, so '/' is the most reliable check)

            return true;
        }
        // Inside frm_ScanBoardingPass.xaml.cs

        public string GetCalculatedFlightDate()
        {
            var leg = ScannedPass?.Segments.FirstOrDefault();
            if (leg == null || string.IsNullOrEmpty(leg.JulianDate)) return null;

            if (int.TryParse(leg.JulianDate, out int dayOfYear))
            {
                int currentYear = DateTime.Now.Year;
                DateTime candidateDate = new DateTime(currentYear, 1, 1).AddDays(dayOfYear - 1);

                // Threshold Logic
                if (candidateDate > DateTime.Now.AddMonths(6))
                    candidateDate = candidateDate.AddYears(-1);
                else if (candidateDate < DateTime.Now.AddMonths(-6))
                    candidateDate = candidateDate.AddYears(1);

                // Return in a SQL-friendly format (YYYY-MM-DD)
                return candidateDate.ToString("yyyy-MM-dd");
            }
            return null;
        }
        private string ConvertJulianToDate(string julianStr)
        {
            if (int.TryParse(julianStr, out int dayOfYear))
            {
                int currentYear = DateTime.Now.Year;
                // Create date for current year
                DateTime candidateDate = new DateTime(currentYear, 1, 1).AddDays(dayOfYear - 1);

                // Threshold logic: If the date is more than 6 months in the future, 
                // it likely belongs to the previous year. If more than 6 months in the past,
                // it belongs to next year.
                if (candidateDate > DateTime.Now.AddMonths(6))
                    candidateDate = candidateDate.AddYears(-1);
                else if (candidateDate < DateTime.Now.AddMonths(-6))
                    candidateDate = candidateDate.AddYears(1);

                return candidateDate.ToString("dd MMM yyyy");
            }
            return "Invalid Date";
        }
        private void ProcessBoardingPass(string rawData)
        {
            try
            {
                BcbpParser parser = new BcbpParser();
                _currentScanResult = parser.Parse(rawData, false);

                if (_currentScanResult.IsValid && _currentScanResult.BoardingPass != null)
                {
                    var pass = _currentScanResult.BoardingPass;
                    ScannedPass = _currentScanResult.BoardingPass;
                    var leg = (pass.Segments != null && pass.Segments.Count > 0) ? pass.Segments[0] : null;

                    DataTable dt = new DataTable();
                    dt.Columns.Add("Field");
                    dt.Columns.Add("Value");

                    dt.Rows.Add("Passenger Name", pass.PassengerNameNormalized);
                    dt.Rows.Add("PNR", leg != null ? leg.Pnr : "N/A");
                    dt.Rows.Add("Origin", leg != null ? leg.FromAirport : "N/A");
                    dt.Rows.Add("Destination", leg != null ? leg.ToAirport : "N/A");
                    dt.Rows.Add("Flight", leg != null ? leg.CarrierCode + leg.FlightNumber : "N/A");

                    // Here is the updated Julian Date row
                    //string readableDate = (leg != null && !string.IsNullOrEmpty(leg.JulianDate))
                    //                      ? ConvertJulianToDate(leg.JulianDate)
                    //                      : "N/A";
                    string displayDate = (leg != null && !string.IsNullOrEmpty(leg.JulianDate))
                    ? ConvertJulianToDate(leg.JulianDate)
                    : "N/A";

                    dt.Rows.Add("Flight Date", displayDate);

                    dt.Rows.Add("Seat", leg != null ? leg.SeatNumber : "N/A");
                    dt.Rows.Add("Sequence", leg != null ? leg.SequenceNumber : "N/A");

                    grdBoardingPassData.ItemsSource = dt.DefaultView;
                    btnDone.IsEnabled = true;

                }
                else
                {
                    btnDone.IsEnabled = false;
                    DocMessage.MsgInformation("Parsing failed: " + string.Join(", ", _currentScanResult.ValidationErrors.ToArray()));
                }
            }
            catch (Exception ex)
            {
                btnDone.IsEnabled = false;
                DocMessage.MsgInformation("Error: " + ex.Message);
            }
        }

        private void BtnCancel_Click(object sender, RoutedEventArgs e)
        {
            Settings.IsBoardingPassSkipped = true;
            this.Close();
        }

        private void BtnDone_Click(object sender, RoutedEventArgs e)
        {
            this.DialogResult = true;
            Settings.IsBoardingPassSkipped = false;
            this.Close();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            txtScanInput.Focus();
        }
    }
}