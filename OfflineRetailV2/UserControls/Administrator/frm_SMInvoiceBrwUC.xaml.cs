using OfflineRetailV2.Data;
using System.Data;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;

namespace OfflineRetailV2.UserControls.Administrator
{
    /// <summary>
    /// Interaction logic for frm_SMInvoiceBrwUC.xaml
    /// </summary>
    public partial class frm_SMInvoiceBrwUC : UserControl
    {
        public frm_MainAdmin ParentForm { get; set; }

        public frm_SMInvoiceBrwUC()
        {
            InitializeComponent();
        }

        public void LoadSubmenu()
        {
            pnlBody.Children.Clear();
            foreach (DataRow dr in SystemVariables.Menu.Rows)
            {
                if (dr["MainMenu"].ToString() != "Invoice") continue;
                if (dr["Visible"].ToString() == "N") continue;

                Button btn = new Button
                {
                    Tag = dr["SubMenu"].ToString(),
                    Width = 130,
                    Height = 75,
                    Margin = new System.Windows.Thickness(5),
                    BorderThickness = new System.Windows.Thickness(3),
                    Style = (Style)FindResource("SubmenuButton")
                };

                TextBlock tb = new TextBlock
                {
                    Text = dr["SubMenu"].ToString(),
                    TextWrapping = System.Windows.TextWrapping.WrapWithOverflow,
                    TextAlignment = System.Windows.TextAlignment.Center,
                    FontFamily = (FontFamily)FindResource("OSSemiBold"),
                    Foreground = Brushes.White
                };

                btn.Content = tb;
                btn.PreviewMouseLeftButtonDown += Btn_PreviewMouseLeftButtonDown;
                pnlBody.Children.Add(btn);
            }
        }

        private void Btn_PreviewMouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            ParentForm.ExecuteClickFromSubMenu(((Button)sender).Tag.ToString());
        }
    }
}
