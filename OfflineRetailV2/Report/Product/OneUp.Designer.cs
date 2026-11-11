namespace OfflineRetailV2.Report.Product
{
    partial class OneUp
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            DevExpress.XtraPrinting.BarCode.Code128Generator code128Generator1 = new DevExpress.XtraPrinting.BarCode.Code128Generator();
            DevExpress.XtraReports.UI.XRWatermark xrWatermark1 = new DevExpress.XtraReports.UI.XRWatermark();
            this.Detail = new DevExpress.XtraReports.UI.DetailBand();
            this.lbPrice = new DevExpress.XtraReports.UI.XRLabel();
            this.lbBarCode = new DevExpress.XtraReports.UI.XRBarCode();
            this.lbProduct = new DevExpress.XtraReports.UI.XRLabel();
            this.lbSKU = new DevExpress.XtraReports.UI.XRLabel();
            this.dataSet1 = new System.Data.DataSet();
            this.topMarginBand1 = new DevExpress.XtraReports.UI.TopMarginBand();
            this.bottomMarginBand1 = new DevExpress.XtraReports.UI.BottomMarginBand();
            ((System.ComponentModel.ISupportInitialize)(this.dataSet1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // Detail
            // 
            this.Detail.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.lbPrice,
            this.lbBarCode,
            this.lbProduct,
            this.lbSKU});
            this.Detail.Font = new DevExpress.Drawing.DXFont("Times New Roman", 9.75F);
            this.Detail.HeightF = 129F;
            this.Detail.Name = "Detail";
            this.Detail.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.Detail.StylePriority.UseFont = false;
            this.Detail.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // lbPrice
            // 
            this.lbPrice.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[PRICE]")});
            this.lbPrice.Font = new DevExpress.Drawing.DXFont("Arial", 20F);
            this.lbPrice.LocationFloat = new DevExpress.Utils.PointFloat(166.1875F, 42.65623F);
            this.lbPrice.Name = "lbPrice";
            this.lbPrice.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.lbPrice.SizeF = new System.Drawing.SizeF(107.8125F, 41.41669F);
            this.lbPrice.StylePriority.UseFont = false;
            this.lbPrice.StylePriority.UseTextAlignment = false;
            this.lbPrice.Text = "[PRICE]";
            this.lbPrice.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // lbBarCode
            // 
            this.lbBarCode.Alignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft;
            this.lbBarCode.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[SKU]")});
            this.lbBarCode.Font = new DevExpress.Drawing.DXFont("Arial", 9F);
            this.lbBarCode.LocationFloat = new DevExpress.Utils.PointFloat(5.999994F, 29.91664F);
            this.lbBarCode.Module = 1F;
            this.lbBarCode.Name = "lbBarCode";
            this.lbBarCode.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.lbBarCode.ShowText = false;
            this.lbBarCode.SizeF = new System.Drawing.SizeF(160.1875F, 54.15628F);
            this.lbBarCode.StylePriority.UseFont = false;
            this.lbBarCode.StylePriority.UsePadding = false;
            this.lbBarCode.StylePriority.UseTextAlignment = false;
            this.lbBarCode.Symbology = code128Generator1;
            this.lbBarCode.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // lbProduct
            // 
            this.lbProduct.CanGrow = false;
            this.lbProduct.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[DESC]")});
            this.lbProduct.Font = new DevExpress.Drawing.DXFont("Arial", 12F);
            this.lbProduct.LocationFloat = new DevExpress.Utils.PointFloat(5.999994F, 3.999996F);
            this.lbProduct.Multiline = true;
            this.lbProduct.Name = "lbProduct";
            this.lbProduct.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.lbProduct.SizeF = new System.Drawing.SizeF(268F, 25.91664F);
            this.lbProduct.StylePriority.UseFont = false;
            this.lbProduct.StylePriority.UseTextAlignment = false;
            this.lbProduct.Text = "[DESC]";
            this.lbProduct.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft;
            // 
            // lbSKU
            // 
            this.lbSKU.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[SKU]")});
            this.lbSKU.Font = new DevExpress.Drawing.DXFont("Arial", 10F);
            this.lbSKU.LocationFloat = new DevExpress.Utils.PointFloat(6.00001F, 86.39584F);
            this.lbSKU.Name = "lbSKU";
            this.lbSKU.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 1, 0, 100F);
            this.lbSKU.SizeF = new System.Drawing.SizeF(268F, 33.60421F);
            this.lbSKU.StylePriority.UseFont = false;
            this.lbSKU.StylePriority.UsePadding = false;
            this.lbSKU.StylePriority.UseTextAlignment = false;
            this.lbSKU.Text = "[SKU]";
            this.lbSKU.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // dataSet1
            // 
            this.dataSet1.DataSetName = "NewDataSet";
            // 
            // topMarginBand1
            // 
            this.topMarginBand1.HeightF = 0F;
            this.topMarginBand1.Name = "topMarginBand1";
            // 
            // bottomMarginBand1
            // 
            this.bottomMarginBand1.HeightF = 0F;
            this.bottomMarginBand1.Name = "bottomMarginBand1";
            // 
            // OneUp
            // 
            this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.Detail,
            this.topMarginBand1,
            this.bottomMarginBand1});
            this.DataSource = this.dataSet1;
            this.Margins = new DevExpress.Drawing.DXMargins(0F, 0F, 0F, 0F);
            this.PageHeight = 125;
            this.PageWidth = 280;
            this.PaperKind = DevExpress.Drawing.Printing.DXPaperKind.Custom;
            this.Version = "24.1";
            xrWatermark1.Id = "Watermark1";
            this.Watermarks.AddRange(new DevExpress.XtraPrinting.Drawing.Watermark[] {
            xrWatermark1});
            ((System.ComponentModel.ISupportInitialize)(this.dataSet1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }

        #endregion
        private System.Data.DataSet dataSet1;
        public DevExpress.XtraReports.UI.XRLabel lbPrice;
        public DevExpress.XtraReports.UI.XRBarCode lbBarCode;
        public DevExpress.XtraReports.UI.XRLabel lbProduct;
        public DevExpress.XtraReports.UI.XRLabel lbSKU;
        private DevExpress.XtraReports.UI.TopMarginBand topMarginBand1;
        private DevExpress.XtraReports.UI.BottomMarginBand bottomMarginBand1;
        public DevExpress.XtraReports.UI.DetailBand Detail;
    }
}
