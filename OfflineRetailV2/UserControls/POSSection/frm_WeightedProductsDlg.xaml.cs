using OfflineRetailV2;
using OfflineRetailV2.Data;
using OfflineRetailV2.UserControls;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Effects;
using System.Windows.Shapes;
using System.Windows.Threading;

namespace OfflineRetailV2.UserControls.POSSection
{
    public partial class frm_WeightedProductsDlg : Window
    {
        private POSControl frmPosDlg;
        private DispatcherTimer tmrScale;
        private DataTable dtblProducts;
        private int selectedCategoryId = -1;
        private bool isAdding;
        private Border selectedTab;
        private Brush brushName;
        private Brush brushPrice;
        private Brush brushCardBorder;
        private Brush brushPhotoBg;
        private Brush brushCardBg;
        private Brush brushPlaceholderIcon;
        private readonly SolidColorBrush brushConnected = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#2EAD4F"));
        private readonly SolidColorBrush brushDisconnected = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#E53935"));
        private readonly SolidColorBrush brushAccent = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#4F9DAD"));
        private const int VisibleProductRows = 4;
        private const double CardGutter = 8;
        private const double CardPadTop = 8;
        private const double CardPadBottom = 6;
        private const double NameAreaHeight = 20;
        private const double PriceAreaHeight = 18;
        private bool cardsReady;
        private bool isRendering;
        private bool surfaceReady;

        public POSControl POSForm
        {
            get { return frmPosDlg; }
            set { frmPosDlg = value; }
        }

        public frm_WeightedProductsDlg()
        {
            InitializeComponent();
            ModalWindow.CloseCommand = new CommandBase(OnCloseCommand);
        }

        private void OnCloseCommand(object obj)
        {
            Close();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            ApplyThemeBrushes();
            LoadWeightedProducts();
            if (frmPosDlg != null)
            {
                frmPosDlg.StartWeightedProductsScaleMonitor();
            }
            RefreshScaleStatus();
            tmrScale = new DispatcherTimer();
            tmrScale.Interval = TimeSpan.FromMilliseconds(300);
            tmrScale.Tick += TmrScale_Tick;
            tmrScale.Start();
            if (svProducts != null) svProducts.UpdateLayout();
            RenderProductsIfReady();
        }

        private void Window_ContentRendered(object sender, EventArgs e)
        {
            surfaceReady = true;
            RenderProductsIfReady();
            UpdateTabScrollButtons();
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (tmrScale != null)
            {
                tmrScale.Stop();
                tmrScale.Tick -= TmrScale_Tick;
                tmrScale = null;
            }
            if (frmPosDlg != null)
            {
                frmPosDlg.StopWeightedProductsScaleMonitor();
            }
        }

        private void Window_PreviewKeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Escape)
            {
                if (txtSearch != null && txtSearch.IsKeyboardFocusWithin && !string.IsNullOrWhiteSpace(txtSearch.Text))
                {
                    txtSearch.Text = "";
                    e.Handled = true;
                    return;
                }
                Close();
            }
        }

        private void BtnClose_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }

        private void TmrScale_Tick(object sender, EventArgs e)
        {
            RefreshScaleStatus();
        }

        private bool IsDarkTheme()
        {
            return string.Equals(SystemVariables.SelectedTheme, "Dark", StringComparison.OrdinalIgnoreCase);
        }

        private Brush ThemeBrush(string key, Brush fallback)
        {
            return FindResource(key) as Brush ?? fallback;
        }

        private void ApplyThemeBrushes()
        {
            if (IsDarkTheme())
            {
                brushName = ThemeBrush("ControlForeground", Brushes.White);
                brushPrice = brushAccent;
                brushCardBorder = ThemeBrush("scBorderBrush", new SolidColorBrush((Color)ColorConverter.ConvertFromString("#444444")));
                brushPhotoBg = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#353B52"));
                brushCardBg = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#2F3A4D"));
                brushPlaceholderIcon = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#8A9BA3"));
            }
            else
            {
                brushName = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#1B3A4B"));
                brushPrice = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#3D5A6C"));
                brushCardBorder = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#E6EEF1"));
                brushPhotoBg = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#F4F8F9"));
                brushCardBg = Brushes.White;
                brushPlaceholderIcon = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#B7C6CD"));
            }

            Brush iconStroke = IsDarkTheme() ? brushAccent : brushName;
            if (pathTitleIcon1 != null) pathTitleIcon1.Stroke = iconStroke;
            if (pathTitleIcon2 != null) pathTitleIcon2.Stroke = iconStroke;
            if (pathTitleIcon3 != null) pathTitleIcon3.Stroke = iconStroke;
            if (pathTitleIcon4 != null) pathTitleIcon4.Stroke = iconStroke;

            Brush themeSurface = ThemeBrush("ModalContentBackground", new SolidColorBrush((Color)ColorConverter.ConvertFromString("#292E41")));
            if (grdCardsHost != null)
            {
                grdCardsHost.Background = IsDarkTheme()
                    ? themeSurface
                    : new SolidColorBrush((Color)ColorConverter.ConvertFromString("#EFF4F4"));
            }
            ApplySearchBoxStyle();
        }

        private void ApplySearchBoxStyle()
        {
            if (txtSearch == null) return;
            txtSearch.IconOnRight = true;
            txtSearch.CornerRadius = new CornerRadius(18);
            txtSearch.BorderThickness = new Thickness(1);
            txtSearch.BorderBrush = brushAccent;
            txtSearch.CaretBrush = brushName;
            txtSearch.Foreground = brushName;
            txtSearch.Background = IsDarkTheme()
                ? ThemeBrush("scPriceInput", new SolidColorBrush((Color)ColorConverter.ConvertFromString("#2F3A4D")))
                : Brushes.White;
        }

        private void RefreshScaleStatus()
        {
            bool connected = false;
            bool hasLiveWeight = false;
            string weightText = "0.000 KG";

            if (frmPosDlg != null)
            {
                connected = frmPosDlg.IsScaleDeviceConnected();
                hasLiveWeight = frmPosDlg.HasLiveScaleWeight();
                weightText = frmPosDlg.GetLiveScaleWeightDisplay();
            }

            tbLiveWeight.Text = string.IsNullOrWhiteSpace(weightText) ? "0.000 KG" : weightText;

            if (connected)
            {
                ellScaleStatus.Fill = brushConnected;
                tbScaleStatus.Text = "Scale Connected";
                tbScaleStatus.Foreground = brushConnected;
                if (hasLiveWeight)
                {
                    tbScaleReady.Text = "Ready";
                    tbScaleReady.Foreground = brushConnected;
                }
                else
                {
                    tbScaleReady.Text = "Waiting for weight";
                    tbScaleReady.Foreground = brushPrice;
                }
            }
            else
            {
                ellScaleStatus.Fill = brushDisconnected;
                tbScaleStatus.Text = "Not Connected";
                tbScaleStatus.Foreground = brushDisconnected;
                tbScaleReady.Text = "";
                tbScaleReady.Foreground = brushDisconnected;
            }
        }

        private void LoadWeightedProducts()
        {
            PosDataObject.Product objProduct = new PosDataObject.Product();
            objProduct.Connection = SystemVariables.Conn;
            dtblProducts = objProduct.FetchWeightedProductsForPOS();
            if (dtblProducts == null)
            {
                dtblProducts = new DataTable();
            }

            BuildCategoryTabs();
            selectedCategoryId = -1;
            cardsReady = false;
        }

        private void BuildCategoryTabs()
        {
            pnlCategoryTabs.Children.Clear();
            selectedTab = null;

            Border allTab = CreateCategoryTab("All Items", -1);
            pnlCategoryTabs.Children.Add(allTab);
            SelectCategoryTab(allTab, false);

            if (dtblProducts == null) return;

            var categories = dtblProducts.AsEnumerable()
                .Select(r => new
                {
                    ID = GeneralFunctions.fnInt32(r["CategoryID"].ToString()),
                    Name = r["CategoryName"].ToString()
                })
                .GroupBy(x => x.ID)
                .Select(g => new
                {
                    ID = g.Key,
                    Name = string.IsNullOrWhiteSpace(g.First().Name) ? "Other" : g.First().Name
                })
                .OrderBy(x => x.Name)
                .ToList();

            foreach (var cat in categories)
            {
                pnlCategoryTabs.Children.Add(CreateCategoryTab(cat.Name, cat.ID));
            }
            Dispatcher.BeginInvoke(new Action(UpdateTabScrollButtons), DispatcherPriority.Loaded);
        }

        private Border CreateCategoryTab(string name, int categoryId)
        {
            TextBlock tb = new TextBlock();
            tb.Text = name;
            tb.FontFamily = FindResource("OSSemiBold") as FontFamily;
            tb.FontSize = 13;
            tb.HorizontalAlignment = HorizontalAlignment.Center;
            tb.VerticalAlignment = VerticalAlignment.Center;

            Border pill = new Border();
            pill.CornerRadius = new CornerRadius(18);
            pill.Padding = new Thickness(20, 0, 20, 0);
            pill.Margin = new Thickness(0, 0, 8, 0);
            pill.MinWidth = 96;
            pill.Height = 36;
            pill.Cursor = Cursors.Hand;
            pill.Tag = categoryId;
            pill.Child = tb;
            pill.MouseLeftButtonUp += CategoryTab_MouseLeftButtonUp;
            ApplyCategoryTabStyle(pill, false);
            return pill;
        }

        private void ApplyCategoryTabStyle(Border pill, bool selected)
        {
            TextBlock tb = pill.Child as TextBlock;
            if (selected)
            {
                pill.Background = brushAccent;
                if (tb != null) tb.Foreground = Brushes.White;
            }
            else
            {
                Brush idleBg = FindResource("scPriceInput") as Brush;
                pill.Background = idleBg ?? brushPhotoBg;
                if (tb != null) tb.Foreground = brushAccent;
            }
        }

        private void SelectCategoryTab(Border pill, bool renderProducts)
        {
            if (pill == null || pill == selectedTab) return;
            if (selectedTab != null)
            {
                ApplyCategoryTabStyle(selectedTab, false);
            }
            selectedTab = pill;
            ApplyCategoryTabStyle(pill, true);
            selectedCategoryId = GeneralFunctions.fnInt32(pill.Tag == null ? "-1" : pill.Tag.ToString());
            if (renderProducts)
            {
                RenderProducts();
            }
        }

        private void CategoryTab_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            SelectCategoryTab(sender as Border, true);
        }

        private void BtnTabLeft_Click(object sender, RoutedEventArgs e)
        {
            ScrollCategoryTabs(-1);
        }

        private void BtnTabRight_Click(object sender, RoutedEventArgs e)
        {
            ScrollCategoryTabs(1);
        }

        private void SvCategoryTabs_ScrollChanged(object sender, ScrollChangedEventArgs e)
        {
            UpdateTabScrollButtons();
        }

        private void SvCategoryTabs_SizeChanged(object sender, SizeChangedEventArgs e)
        {
            UpdateTabScrollButtons();
        }

        private void ScrollCategoryTabs(int direction)
        {
            if (svCategoryTabs == null) return;
            double step = Math.Max(120, svCategoryTabs.ViewportWidth * 0.55);
            double next = svCategoryTabs.HorizontalOffset + (direction * step);
            if (next < 0) next = 0;
            if (next > svCategoryTabs.ScrollableWidth) next = svCategoryTabs.ScrollableWidth;
            svCategoryTabs.ScrollToHorizontalOffset(next);
            UpdateTabScrollButtons();
        }

        private void UpdateTabScrollButtons()
        {
            if (svCategoryTabs == null || btnTabLeft == null || btnTabRight == null) return;
            bool overflow = svCategoryTabs.ExtentWidth > svCategoryTabs.ViewportWidth + 2;
            btnTabLeft.IsEnabled = overflow && svCategoryTabs.HorizontalOffset > 1;
            btnTabRight.IsEnabled = overflow && svCategoryTabs.HorizontalOffset < svCategoryTabs.ScrollableWidth - 1;
        }

        private void TxtSearch_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (dtblProducts == null) return;
            if (cardsReady) RenderProducts();
        }

        private string GetSearchQuery()
        {
            if (txtSearch == null) return "";
            return (txtSearch.Text ?? "").Trim();
        }

        private static bool MatchesSearch(DataRow dr, string query)
        {
            if (string.IsNullOrEmpty(query)) return true;
            string name = dr["Description"] == null ? "" : dr["Description"].ToString();
            string sku = dr["SKU"] == null ? "" : dr["SKU"].ToString();
            return name.IndexOf(query, StringComparison.OrdinalIgnoreCase) >= 0
                || sku.IndexOf(query, StringComparison.OrdinalIgnoreCase) >= 0;
        }

        private bool HasMeasuredProductArea()
        {
            return svProducts != null && svProducts.ActualWidth >= 50 && svProducts.ActualHeight >= 50;
        }

        private void RenderProductsIfReady()
        {
            if (dtblProducts == null) return;
            if (!HasMeasuredProductArea()) return;
            if (!cardsReady) RenderProducts();
            else ApplyProductCardLayout();
        }

        private void RenderProducts()
        {
            if (isRendering) return;
            isRendering = true;
            try
            {
                pnlProducts.Children.Clear();
                if (dtblProducts == null || dtblProducts.Rows.Count == 0)
                {
                    tbEmpty.Visibility = Visibility.Visible;
                    cardsReady = true;
                    if (surfaceReady) pnlProducts.Opacity = 1;
                    return;
                }

                IEnumerable<DataRow> rows = dtblProducts.AsEnumerable();
                if (selectedCategoryId >= 0)
                {
                    rows = rows.Where(r => GeneralFunctions.fnInt32(r["CategoryID"].ToString()) == selectedCategoryId);
                }
                string query = GetSearchQuery();
                if (!string.IsNullOrEmpty(query))
                {
                    rows = rows.Where(r => MatchesSearch(r, query));
                }

                int count = 0;
                foreach (DataRow dr in rows)
                {
                    pnlProducts.Children.Add(CreateProductCard(dr));
                    count++;
                }

                tbEmpty.Text = !string.IsNullOrEmpty(query)
                    ? "No matching products found"
                    : "No weighted products found";
                tbEmpty.Visibility = count == 0 ? Visibility.Visible : Visibility.Collapsed;
                ApplyProductCardLayout();
                cardsReady = true;
            }
            finally
            {
                isRendering = false;
            }
        }

        private void SvProducts_SizeChanged(object sender, SizeChangedEventArgs e)
        {
            RenderProductsIfReady();
        }

        private double GetProductCardHeight()
        {
            double available = svProducts != null ? svProducts.ActualHeight : 0;
            if (available < 50) available = 520;
            double height = Math.Floor(available / VisibleProductRows) - CardGutter;
            if (height < 110) height = 110;
            return height;
        }

        private double GetStableViewportWidth()
        {
            if (svProducts == null) return 960;
            double width = svProducts.ActualWidth;
            if (width < 50) return 960;
            width -= SystemParameters.VerticalScrollBarWidth;
            if (width < 120) width = 120;
            return width;
        }

        private static double GetPhotoHeight(double cardHeight)
        {
            double photo = cardHeight - CardPadTop - CardPadBottom - NameAreaHeight - PriceAreaHeight;
            if (photo < 48) photo = 48;
            return photo;
        }

        private void ApplyCardMetrics(Border card, double cardHeight)
        {
            card.Height = cardHeight;
            card.ClearValue(FrameworkElement.WidthProperty);
            card.Margin = new Thickness(CardGutter / 2);
            card.HorizontalAlignment = HorizontalAlignment.Stretch;
            card.UseLayoutRounding = true;
            card.SnapsToDevicePixels = true;

            Grid content = card.Child as Grid;
            if (content == null || content.Children.Count == 0) return;
            Border photoBox = content.Children[0] as Border;
            if (photoBox == null)
            {
                Grid photoHost = content.Children[0] as Grid;
                if (photoHost != null && photoHost.Children.Count > 0)
                    photoBox = photoHost.Children[0] as Border;
            }
            if (photoBox == null) return;
            photoBox.Height = GetPhotoHeight(cardHeight);
        }

        private void ApplyProductCardLayout()
        {
            if (pnlProducts == null || !HasMeasuredProductArea()) return;
            pnlProducts.Width = GetStableViewportWidth();
            double height = GetProductCardHeight();
            foreach (UIElement child in pnlProducts.Children)
            {
                Border card = child as Border;
                if (card == null) continue;
                ApplyCardMetrics(card, height);
            }
            if (surfaceReady) pnlProducts.Opacity = 1;
        }

        private Border CreateProductCard(DataRow dr)
        {
            int productId = GeneralFunctions.fnInt32(dr["ID"].ToString());
            string sku = dr["SKU"].ToString();
            string name = dr["Description"].ToString();
            double price = GeneralFunctions.fnDouble(dr["PriceA"].ToString());
            string uom = dr["UOM"].ToString();
            if (string.IsNullOrWhiteSpace(uom)) uom = "KG";

            string priceText = Settings.DecimalPlace == 3 ? price.ToString("f3") : price.ToString("f");
            string priceLine = SystemVariables.CurrencySymbol + priceText + " / " + uom;

            Image imgPhoto = new Image();
            imgPhoto.Stretch = Stretch.Uniform;
            imgPhoto.Margin = new Thickness(4);
            imgPhoto.HorizontalAlignment = HorizontalAlignment.Center;
            imgPhoto.VerticalAlignment = VerticalAlignment.Center;
            try
            {
                GeneralFunctions.LoadPhotofromDB("Product", productId, imgPhoto);
            }
            catch
            {
                imgPhoto.Source = null;
            }

            TextBlock tbName = new TextBlock();
            tbName.Text = name;
            tbName.FontFamily = FindResource("OSSemiBold") as FontFamily;
            tbName.FontSize = 12;
            tbName.FontWeight = FontWeights.SemiBold;
            tbName.Foreground = brushName;
            tbName.TextWrapping = TextWrapping.NoWrap;
            tbName.TextTrimming = TextTrimming.CharacterEllipsis;
            tbName.TextAlignment = TextAlignment.Center;
            tbName.VerticalAlignment = VerticalAlignment.Center;
            tbName.Margin = new Thickness(4, 0, 4, 0);
            tbName.Height = NameAreaHeight;
            tbName.Padding = new Thickness(0);

            TextBlock tbPrice = new TextBlock();
            tbPrice.Text = priceLine;
            tbPrice.FontFamily = FindResource("OSRegular") as FontFamily;
            tbPrice.FontSize = 11;
            tbPrice.Foreground = brushPrice;
            tbPrice.TextAlignment = TextAlignment.Center;
            tbPrice.VerticalAlignment = VerticalAlignment.Top;
            tbPrice.Margin = new Thickness(4, 0, 4, 0);
            tbPrice.Height = PriceAreaHeight;
            tbPrice.Padding = new Thickness(0);

            double cardHeight = GetProductCardHeight();
            Border photoBox = new Border();
            photoBox.CornerRadius = new CornerRadius(10);
            photoBox.ClipToBounds = true;
            photoBox.Margin = new Thickness(0);
            photoBox.Height = GetPhotoHeight(cardHeight);
            if (imgPhoto.Source == null)
            {
                photoBox.Background = brushPhotoBg;
                photoBox.Child = CreateScaleIcon(brushPlaceholderIcon, 40);
            }
            else
            {
                photoBox.Background = Brushes.Transparent;
                photoBox.Child = imgPhoto;
            }

            int cartCount = 0;
            if (frmPosDlg != null)
            {
                cartCount = frmPosDlg.GetWeightedProductCartCount(productId);
            }

            TextBlock tbCartCount = new TextBlock();
            tbCartCount.Text = cartCount.ToString();
            tbCartCount.FontFamily = FindResource("OSSemiBold") as FontFamily;
            tbCartCount.FontSize = 11;
            tbCartCount.FontWeight = FontWeights.Bold;
            tbCartCount.Foreground = Brushes.White;
            tbCartCount.Margin = new Thickness(4, 0, 0, 0);
            tbCartCount.VerticalAlignment = VerticalAlignment.Center;

            StackPanel spBadge = new StackPanel();
            spBadge.Orientation = Orientation.Horizontal;
            spBadge.VerticalAlignment = VerticalAlignment.Center;
            spBadge.Children.Add(CreateCartIcon(Brushes.White, 12));
            spBadge.Children.Add(tbCartCount);

            Border badge = new Border();
            badge.CornerRadius = new CornerRadius(10);
            badge.Background = brushConnected;
            badge.Padding = new Thickness(7, 3, 8, 3);
            badge.HorizontalAlignment = HorizontalAlignment.Right;
            badge.VerticalAlignment = VerticalAlignment.Top;
            badge.Margin = new Thickness(0, 4, 4, 0);
            badge.IsHitTestVisible = false;
            badge.Child = spBadge;
            badge.Visibility = cartCount > 0 ? Visibility.Visible : Visibility.Collapsed;
            badge.Effect = new DropShadowEffect
            {
                Color = Colors.Black,
                BlurRadius = 6,
                ShadowDepth = 1,
                Opacity = 0.25,
                Direction = 270
            };

            Grid photoHost = new Grid();
            photoHost.Children.Add(photoBox);
            photoHost.Children.Add(badge);

            Grid content = new Grid();
            content.RowDefinitions.Add(new RowDefinition { Height = GridLength.Auto });
            content.RowDefinitions.Add(new RowDefinition { Height = GridLength.Auto });
            content.RowDefinitions.Add(new RowDefinition { Height = GridLength.Auto });
            Grid.SetRow(photoHost, 0);
            Grid.SetRow(tbName, 1);
            Grid.SetRow(tbPrice, 2);
            content.Children.Add(photoHost);
            content.Children.Add(tbName);
            content.Children.Add(tbPrice);

            Border card = new Border();
            card.Height = cardHeight;
            card.Margin = new Thickness(CardGutter / 2);
            card.Padding = new Thickness(CardPadTop, CardPadTop, CardPadTop, CardPadBottom);
            card.HorizontalAlignment = HorizontalAlignment.Stretch;
            card.VerticalAlignment = VerticalAlignment.Stretch;
            card.UseLayoutRounding = true;
            card.SnapsToDevicePixels = true;
            card.CornerRadius = new CornerRadius(12);
            card.Background = brushCardBg;
            card.BorderBrush = brushCardBorder;
            card.BorderThickness = new Thickness(1);
            card.Cursor = Cursors.Hand;
            card.Tag = new WeightedCardInfo
            {
                SKU = sku,
                ProductId = productId,
                Badge = badge,
                CountText = tbCartCount
            };
            card.Child = content;
            card.Effect = new DropShadowEffect
            {
                Color = IsDarkTheme() ? Colors.Black : Color.FromRgb(27, 58, 75),
                BlurRadius = 10,
                ShadowDepth = 1,
                Opacity = IsDarkTheme() ? 0.35 : 0.10,
                Direction = 270
            };
            card.MouseLeftButtonUp += ProductCard_MouseLeftButtonUp;
            card.MouseEnter += (s, e) => { ((Border)s).BorderBrush = brushAccent; };
            card.MouseLeave += (s, e) => { ((Border)s).BorderBrush = brushCardBorder; };

            return card;
        }

        private class WeightedCardInfo
        {
            public string SKU;
            public int ProductId;
            public Border Badge;
            public TextBlock CountText;
        }

        private static Viewbox CreateCartIcon(Brush stroke, double size)
        {
            Canvas canvas = new Canvas();
            canvas.Width = 24;
            canvas.Height = 24;

            canvas.Children.Add(CreateScalePath("M4,6 H6.2 L8.2,15.2 H19 L21,8.2 H8.6", stroke, 1.8, true));
            Ellipse wheel1 = new Ellipse();
            wheel1.Width = 3.2;
            wheel1.Height = 3.2;
            wheel1.Stroke = stroke;
            wheel1.StrokeThickness = 1.6;
            wheel1.Fill = Brushes.Transparent;
            Canvas.SetLeft(wheel1, 9.2);
            Canvas.SetTop(wheel1, 17.2);
            canvas.Children.Add(wheel1);
            Ellipse wheel2 = new Ellipse();
            wheel2.Width = 3.2;
            wheel2.Height = 3.2;
            wheel2.Stroke = stroke;
            wheel2.StrokeThickness = 1.6;
            wheel2.Fill = Brushes.Transparent;
            Canvas.SetLeft(wheel2, 16.4);
            Canvas.SetTop(wheel2, 17.2);
            canvas.Children.Add(wheel2);

            Viewbox vb = new Viewbox();
            vb.Width = size;
            vb.Height = size;
            vb.VerticalAlignment = VerticalAlignment.Center;
            vb.Child = canvas;
            return vb;
        }

        private static void UpdateCartBadge(WeightedCardInfo info, int count)
        {
            if (info == null) return;
            if (info.CountText != null) info.CountText.Text = count.ToString();
            if (info.Badge != null)
                info.Badge.Visibility = count > 0 ? Visibility.Visible : Visibility.Collapsed;
        }

        private static Viewbox CreateScaleIcon(Brush stroke, double size)
        {
            Canvas canvas = new Canvas();
            canvas.Width = 24;
            canvas.Height = 24;

            canvas.Children.Add(CreateScalePath("M3.5,4.5 H20.5", stroke, 1.8, false));
            canvas.Children.Add(CreateScalePath("M8,4.5 V8 M16,4.5 V8", stroke, 1.8, false));
            canvas.Children.Add(CreateScalePath("M7,8 H17 L20.5,20.5 H3.5 Z", stroke, 1.8, true));
            canvas.Children.Add(CreateScalePath("M12,12.2 L14.3,14.8 L12,17.4 L9.7,14.8 Z", stroke, 1.6, true));

            Viewbox vb = new Viewbox();
            vb.Width = size;
            vb.Height = size;
            vb.HorizontalAlignment = HorizontalAlignment.Center;
            vb.VerticalAlignment = VerticalAlignment.Center;
            vb.Child = canvas;
            return vb;
        }

        private static Path CreateScalePath(string data, Brush stroke, double thickness, bool roundJoin)
        {
            Path path = new Path();
            path.Stroke = stroke;
            path.StrokeThickness = thickness;
            path.StrokeStartLineCap = PenLineCap.Round;
            path.StrokeEndLineCap = PenLineCap.Round;
            if (roundJoin) path.StrokeLineJoin = PenLineJoin.Round;
            path.Fill = Brushes.Transparent;
            path.Data = Geometry.Parse(data);
            return path;
        }

        private async void ProductCard_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            if (isAdding) return;
            Border card = sender as Border;
            if (card == null) return;
            WeightedCardInfo info = card.Tag as WeightedCardInfo;
            if (info == null || string.IsNullOrWhiteSpace(info.SKU)) return;
            if (frmPosDlg == null) return;

            bool connected = frmPosDlg.IsScaleDeviceConnected();
            bool hasLiveWeight = frmPosDlg.HasLiveScaleWeight();
            if (!connected)
            {
                DocMessage.MsgInformation("Scale is not connected. Connect the live weight scale to add a product.");
                return;
            }
            if (!hasLiveWeight)
            {
                DocMessage.MsgInformation("Place an item on the scale to add it to the cart.");
                return;
            }

            isAdding = true;
            card.Opacity = 0.6;
            try
            {
                await frmPosDlg.AddWeightedProductToCart(info.SKU);
                UpdateCartBadge(info, frmPosDlg.GetWeightedProductCartCount(info.ProductId));
            }
            finally
            {
                card.Opacity = 1;
                isAdding = false;
            }
        }
    }
}
