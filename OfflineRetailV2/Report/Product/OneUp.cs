using System;
using System.ComponentModel;
using System.Drawing;
using DevExpress.Utils;
using DevExpress.XtraPrinting;
using DevExpress.XtraPrinting.BarCode;
using DevExpress.XtraReports.UI;
using OfflineRetailV2.Data;
using OfflineRetailV2;
namespace OfflineRetailV2.Report.Product
{
    public partial class OneUp : DevExpress.XtraReports.UI.XtraReport
    {
        public OneUp()
        {
            InitializeComponent();
            ApplySampleBarcodeLayout();
            //Translation.SetMultilingualTextInXtraReport(this);
        }

        // Shelf sticker: name at the top, retail barcode on the left, price beside the bars.
        public void ApplySampleBarcodeLayout()
        {
            lbProduct.LocationFloat = new PointFloat(2F, 2F);
            lbProduct.SizeF = new SizeF(276F, 18F);
            lbProduct.TextAlignment = TextAlignment.MiddleCenter;
            lbProduct.Padding = new PaddingInfo(2, 2, 0, 0, 100F);
            lbProduct.CanGrow = false;

            // Room under the name, then EAN bars with the long guards dropping into the digits.
            lbBarCode.LocationFloat = new PointFloat(4F, 32F);
            lbBarCode.SizeF = new SizeF(162F, 66F);
            lbBarCode.ShowText = true;
            lbBarCode.AutoModule = true;
            lbBarCode.Alignment = TextAlignment.TopCenter;
            lbBarCode.TextAlignment = TextAlignment.BottomCenter;
            lbBarCode.StylePriority.UseTextAlignment = false;
            lbBarCode.Font = new DevExpress.Drawing.DXFont("Arial", 9F);
            lbBarCode.Padding = new PaddingInfo(0, 2, 0, 0, 100F);
            lbBarCode.BeforePrint -= lbBarCode_BeforePrint;
            lbBarCode.BeforePrint += lbBarCode_BeforePrint;

            lbPrice.LocationFloat = new PointFloat(166F, 36F);
            lbPrice.SizeF = new SizeF(110F, 40F);
            lbPrice.TextAlignment = TextAlignment.MiddleRight;
            lbPrice.Padding = new PaddingInfo(0, 2, 0, 0, 100F);

            lbSKU.Visible = false;

            Detail.HeightF = 104F;
            this.PageHeight = 104;
            if (this.Bands[BandKind.BottomMargin] != null)
                this.Bands[BandKind.BottomMargin].HeightF = 0F;
            if (this.Bands[BandKind.TopMargin] != null)
                this.Bands[BandKind.TopMargin].HeightF = 0F;
        }

        private void lbBarCode_BeforePrint(object sender, CancelEventArgs e)
        {
            XRBarCode barcode = (XRBarCode)sender;
            string raw = (barcode.Text ?? string.Empty).Trim().Replace(" ", string.Empty).Replace("-", string.Empty);
            if (raw.Length == 0)
                return;

            string digits = string.Empty;
            for (int i = 0; i < raw.Length; i++)
            {
                if (raw[i] >= '0' && raw[i] <= '9')
                    digits += raw[i];
            }

            if (digits.Length != raw.Length)
            {
                barcode.Symbology = new Code128Generator();
                return;
            }

            if (digits.Length == 13 && IsValidGtinCheckDigit(digits))
            {
                EAN13Generator ean13 = new EAN13Generator();
                ean13.CalcCheckSum = false;
                barcode.Text = digits;
                barcode.Symbology = ean13;
                barcode.ShowText = true;
                return;
            }

            if (digits.Length == 12 && IsValidGtinCheckDigit(digits))
            {
                UPCAGenerator upc = new UPCAGenerator();
                upc.CalcCheckSum = false;
                barcode.Text = digits;
                barcode.Symbology = upc;
                barcode.ShowText = true;
                return;
            }

            if (digits.Length == 8 && IsValidGtinCheckDigit(digits))
            {
                EAN8Generator ean8 = new EAN8Generator();
                ean8.CalcCheckSum = false;
                barcode.Text = digits;
                barcode.Symbology = ean8;
                barcode.ShowText = true;
                return;
            }

            barcode.Symbology = new Code128Generator();
            barcode.ShowText = true;
        }

        private static bool IsValidGtinCheckDigit(string digits)
        {
            if (digits.Length != 8 && digits.Length != 12 && digits.Length != 13)
                return false;

            int sum = 0;
            int weight = 3;
            for (int i = digits.Length - 2; i >= 0; i--)
            {
                sum += (digits[i] - '0') * weight;
                weight = weight == 3 ? 1 : 3;
            }

            int check = (10 - (sum % 10)) % 10;
            return check == (digits[digits.Length - 1] - '0');
        }

    }
}
