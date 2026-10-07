using OfflineRetailV2.Data;
using System;
using System.ComponentModel;
using System.Data;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Media.Imaging;
using System.Windows.Threading;

namespace OfflineRetailV2
{
    public partial class DualWindow : Window
    {
        private string[] imageFiles;
        private int currentImageIndex = 0;
        private DispatcherTimer slideshowTimer;

        public DualWindow()
        {
            InitializeComponent();
            terminalnameTB.Text = Settings.RegCompanyName;
            SetFooterTotals(0, 0, 0, 0);
        }

        private void SetFooterTotals(double subtotal, double tax, double discount, double total)
        {
            SubtotalText.Text = GeneralFunctions.FormatDoubleWithCurrency(subtotal);
            TaxText.Text = GeneralFunctions.FormatDoubleWithCurrency(tax);
            DiscountText.Text = GeneralFunctions.FormatDoubleWithCurrency(discount);
            TotalText.Text = GeneralFunctions.FormatDoubleWithCurrency(total);
        }

        public void ShowFullScreenContent()
        {
            string filePath = Settings.ApplicationSecondMonitor;
            if (string.IsNullOrEmpty(filePath))
                return;

            var extension = Path.GetExtension(filePath).ToLower();

            Dispatcher.Invoke(() =>
            {
                GrdVideo.Visibility = Visibility.Collapsed;
                GrdImage.Visibility = Visibility.Collapsed;

                switch (extension)
                {
                    case ".mp4":
                        PlayVideo(filePath);
                        break;
                    case ".jpg":
                    case ".png":
                        StartImageSlideshow(filePath);
                        break;
                    default:
                        break;
                }
            });
        }

        private void PlayVideo(string filePath)
        {
            GrdVideo.Visibility = Visibility.Visible;
            VideoPlayer1.Source = new Uri(filePath, UriKind.RelativeOrAbsolute);
            VideoPlayer1.Play();
        }

        private void StartImageSlideshow(string filePath)
        {
            string directory = Path.GetDirectoryName(filePath);
            imageFiles = Directory.GetFiles(directory, "*.*")
                              .Where(f => f.EndsWith(".jpg", StringComparison.OrdinalIgnoreCase) ||
                                         f.EndsWith(".png", StringComparison.OrdinalIgnoreCase))
                              .OrderBy(f => f)
                              .ToArray();

            if (imageFiles.Length == 0)
            {
                return;
            }

            GrdImage.Visibility = Visibility.Visible;
            currentImageIndex = 0;
            DisplayImage(imageFiles[currentImageIndex]);

            if (imageFiles.Length > 1)
            {
                if (slideshowTimer == null)
                {
                    slideshowTimer = new DispatcherTimer
                    {
                        Interval = TimeSpan.FromSeconds(3)
                    };
                    slideshowTimer.Tick += SlideshowTimer_Tick;
                }
                slideshowTimer.Start();
            }
        }

        private void DisplayImage(string imagePath)
        {
            ImageViewer.Source = new BitmapImage(new Uri(imagePath, UriKind.RelativeOrAbsolute));
        }

        private void SlideshowTimer_Tick(object sender, EventArgs e)
        {
            currentImageIndex = (currentImageIndex + 1) % imageFiles.Length;
            DisplayImage(imageFiles[currentImageIndex]);
        }

        public void HideFullScreenContent()
        {
            Dispatcher.Invoke(() =>
            {
                GrdVideo.Visibility = Visibility.Collapsed;
                GrdImage.Visibility = Visibility.Collapsed;

                if (VideoPlayer1.IsLoaded)
                {
                    VideoPlayer1.Stop();
                }

                if (slideshowTimer != null)
                {
                    slideshowTimer.Stop();
                }

                if (ImageViewer.Source != null)
                {
                    ImageViewer.Source = null;
                }
            });
        }

        public void VideoPlayer1_MediaEnded(object sender, RoutedEventArgs e)
        {
            VideoPlayer1.Position = TimeSpan.Zero;
            VideoPlayer1.Play();
        }

        public void PaymentScreen()
        {
            AmountToPayTB.Text = TotalText.Text;
            GrdPaymentSuccess.Visibility = Visibility.Hidden;
            GrdTapToPay.Visibility = Visibility.Hidden;
            GrdWelcome.Visibility = Visibility.Hidden;
            GrdAddItems.Visibility = Visibility.Hidden;
            GrdThankyou.Visibility = Visibility.Hidden;
            GrdPay.Visibility = Visibility.Visible;
        }

        public void TapToPayScreen()
        {
            AmountToPayByTapTB.Text = TotalText.Text;
            GrdPaymentSuccess.Visibility = Visibility.Hidden;
            GrdTapToPay.Visibility = Visibility.Visible;
            GrdWelcome.Visibility = Visibility.Hidden;
            GrdAddItems.Visibility = Visibility.Hidden;
            GrdThankyou.Visibility = Visibility.Hidden;
            GrdPay.Visibility = Visibility.Collapsed;
        }

        public async void ThankyouScreen()
        {
            GrdPaymentSuccess.Visibility = Visibility.Hidden;
            GrdTapToPay.Visibility = Visibility.Hidden;
            GrdWelcome.Visibility = Visibility.Hidden;
            GrdAddItems.Visibility = Visibility.Hidden;
            GrdPay.Visibility = Visibility.Hidden;
            GrdThankyou.Visibility = Visibility.Visible;
            ThankyouTB.Text = "Payment Successful";
            await Task.Delay(1000);

            ThankyouTB.Text = "Thank you for visiting us";
            await Task.Delay(1000);

            ThankyouTB.Text = "Next Customer Please";
        }

        public void PaymentSuccessfulScreen()
        {
            GrdWelcome.Visibility = Visibility.Hidden;
            GrdAddItems.Visibility = Visibility.Hidden;
            GrdPay.Visibility = Visibility.Hidden;
            GrdThankyou.Visibility = Visibility.Hidden;
            GrdTapToPay.Visibility = Visibility.Hidden;
            GrdPaymentSuccess.Visibility = Visibility.Visible;
        }

        public void WelcomeScreen()
        {
            GrdWelcome.Visibility = Visibility.Visible;
            GrdAddItems.Visibility = Visibility.Hidden;
            GrdPay.Visibility = Visibility.Hidden;
            GrdThankyou.Visibility = Visibility.Hidden;
            GrdTapToPay.Visibility = Visibility.Hidden;
            GrdPaymentSuccess.Visibility = Visibility.Hidden;
        }

        public void UpdateScreen(DataTable dataTable, double subtotal, double tax, double discount, double total)
        {
            GrdWelcome.Visibility = Visibility.Hidden;
            GrdPaymentSuccess.Visibility = Visibility.Hidden;
            GrdTapToPay.Visibility = Visibility.Hidden;
            GrdThankyou.Visibility = Visibility.Hidden;
            GrdPay.Visibility = Visibility.Hidden;
            GrdAddItems.Visibility = Visibility.Visible;

            var itemList = new System.Collections.ObjectModel.ObservableCollection<Item>();
            terminalnameTB.Text = Settings.RegCompanyName;
            int leadingSpaces = 0;

            bool ManualDiscountflag = false;
            string ItemName = "";
            string Description = "";
            string Price = "";

            foreach (DataRow row in dataTable.Rows)
            {
                leadingSpaces = row["PRODUCT"].ToString().TakeWhile(c => c == ' ').Count();

                if (leadingSpaces > 0)
                {
                    leadingSpaces++;
                }
                if (row["PRODUCT"] != null && row["PRODUCT"].ToString().Contains("Manual Discount"))
                {
                    ManualDiscountflag = true;
                }
                if (row["DISCOUNTTEXT"].ToString() == "")
                {
                    ItemName = row["PRODUCT"].ToString().TrimEnd();
                }
                else
                {
                    ItemName = row["PRODUCT"].ToString().TrimEnd() + '\n' + new string(' ', leadingSpaces) + row["DISCOUNTTEXT"].ToString().TrimStart() + "";
                }

                if (ManualDiscountflag)
                {
                    Description = "";
                    Price = "";
                }
                else
                {
                    Description = new string(' ', leadingSpaces) + GeneralFunctions.fnDouble(row["QTY"].ToString()) + " x " + GeneralFunctions.FormatDoubleWithCurrency(GeneralFunctions.fnDouble(row["RATE"].ToString()));
                    Price = GeneralFunctions.FormatDoubleWithCurrency(GeneralFunctions.fnDouble(row["PRICE"].ToString()));
                }

                itemList.Add(new Item
                {
                    ItemName = ItemName,
                    Description = Description,
                    Price = Price
                });

                leadingSpaces = 0;
                ManualDiscountflag = false;
                ItemName = string.Empty;
                Description = string.Empty;
                Price = string.Empty;
            }

            ItemsList.ItemsSource = itemList;
            ScrollToEnd();

            SetFooterTotals(subtotal, tax, discount, total);
        }

        private int LastSelectedItemIndex = -1;

        public void ScrollToItem(int selectedIndex)
        {
            Dispatcher.InvokeAsync(() =>
            {
                if (selectedIndex < 0 || selectedIndex >= ItemsList.Items.Count)
                    return;

                var container = ItemsList.ItemContainerGenerator.ContainerFromIndex(selectedIndex) as FrameworkElement;

                if (container != null)
                {
                    container.BringIntoView(new Rect(0, 0, container.ActualWidth, container.ActualHeight));
                }
            }, System.Windows.Threading.DispatcherPriority.Background);
        }

        public void UpdateScreenCart(DataTable dataTable, double subtotal, double tax, double discount, double total, string selectedProduct = null)
        {
            GrdWelcome.Visibility = Visibility.Hidden;
            GrdPaymentSuccess.Visibility = Visibility.Hidden;
            GrdTapToPay.Visibility = Visibility.Hidden;
            GrdThankyou.Visibility = Visibility.Hidden;
            GrdPay.Visibility = Visibility.Hidden;
            GrdAddItems.Visibility = Visibility.Visible;

            var itemList = new System.Collections.ObjectModel.ObservableCollection<Item>();
            terminalnameTB.Text = Settings.RegCompanyName;
            int leadingSpaces = 0;

            bool ManualDiscountflag = false;
            string ItemName = "";
            string Description = "";
            string Price = "";

            int selectedIndex = -1;
            int currentIndex = 0;

            foreach (DataRow row in dataTable.Rows)
            {
                leadingSpaces = row["PRODUCT"].ToString().TakeWhile(c => c == ' ').Count();
                if (leadingSpaces > 0) leadingSpaces++;

                if (row["PRODUCT"] != null && row["PRODUCT"].ToString().Contains("Manual Discount"))
                    ManualDiscountflag = true;

                if (row["DISCOUNTTEXT"].ToString() == "")
                    ItemName = row["PRODUCT"].ToString().TrimEnd();
                else
                    ItemName = row["PRODUCT"].ToString().TrimEnd() + '\n' + new string(' ', leadingSpaces) + row["DISCOUNTTEXT"].ToString().TrimStart();

                if (ManualDiscountflag)
                {
                    Description = "";
                    Price = "";
                }
                else
                {
                    Description = new string(' ', leadingSpaces) + GeneralFunctions.fnDouble(row["QTY"].ToString()) + " x " + GeneralFunctions.FormatDoubleWithCurrency(GeneralFunctions.fnDouble(row["RATE"].ToString()));
                    Price = GeneralFunctions.FormatDoubleWithCurrency(GeneralFunctions.fnDouble(row["PRICE"].ToString()));
                }

                if (selectedProduct != null && row["PRODUCT"].ToString().TrimEnd() == selectedProduct)
                {
                    selectedIndex = currentIndex;
                }

                itemList.Add(new Item
                {
                    ItemName = ItemName,
                    Description = Description,
                    Price = Price
                });

                currentIndex++;
                leadingSpaces = 0;
                ManualDiscountflag = false;
                ItemName = string.Empty;
                Description = string.Empty;
                Price = string.Empty;
            }

            ItemsList.ItemsSource = itemList;

            if (selectedIndex != -1)
            {
                LastSelectedItemIndex = selectedIndex;
            }

            Dispatcher.InvokeAsync(() =>
            {
                if (LastSelectedItemIndex >= 0)
                {
                    ScrollToItem(LastSelectedItemIndex);
                }
            }, System.Windows.Threading.DispatcherPriority.Background);

            SetFooterTotals(subtotal, tax, discount, total);
        }

        private void ScrollToEnd()
        {
            ScrollViewerControl.Dispatcher.BeginInvoke(new Action(() =>
            {
                ScrollViewerControl.ScrollToEnd();
            }), System.Windows.Threading.DispatcherPriority.Background);
        }
    }

    public class Item : INotifyPropertyChanged
    {
        private bool _isSelected;

        public string ItemName { get; set; }
        public string Description { get; set; }
        public string Price { get; set; }

        public bool IsSelected
        {
            get => _isSelected;
            set
            {
                _isSelected = value;
                OnPropertyChanged(nameof(IsSelected));
            }
        }

        public event PropertyChangedEventHandler PropertyChanged;
        protected void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}