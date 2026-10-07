using System;
using System.Threading.Tasks;
using System.Windows;
using OfflineRetailV2.Data;
using DevExpress.Xpf.Core;
using DevExpress.Mvvm;
using DevExpress.XtraEditors;



namespace OfflineRetailV2
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        
        public App()
        {
            try
            {
                
                SystemVariables.BrandName = ConfigSettings.GetBrandName();
            }
            catch
            {
                SystemVariables.BrandName = "XEPOS Retail 2024";
            }

            try
            {
                SystemVariables.SelectedTheme = ConfigSettings.GetTheme();
            }
            catch
            {
                SystemVariables.SelectedTheme = "Dark";
            }
            

            //RenderOptions.ProcessRenderMode = RenderMode.SoftwareOnly;
            //Timeline.SetIsEnabled(this, true);
            var splashScreenViewModel = new DXSplashScreenViewModel()
            {
                Title = SystemVariables.BrandName,
                Copyright = "",
                Subtitle = "",
                Logo = new Uri("/Resources/Icons/Logo.png", UriKind.Relative)
            };

            SplashScreenManager.Create(() => new FluentSplashScreen1(), splashScreenViewModel).ShowOnStartup(true);
        }
        protected override void OnStartup(StartupEventArgs e)
        {
            base.OnStartup(e);

            // Persist unexpected crashes to Logs table for support diagnosis.
            this.DispatcherUnhandledException += App_DispatcherUnhandledException;
            AppDomain.CurrentDomain.UnhandledException += App_UnhandledException;
            System.Threading.Tasks.TaskScheduler.UnobservedTaskException += App_UnobservedTaskException;

            PerformBackgroundWarmUp();
            /*
            if (SystemVariables.SelectedTheme == "Dark")
            {
                ApplicationThemeHelper.ApplicationThemeName = Theme.Office2019BlackName;
                Application.Current.Resources.MergedDictionaries.Clear();
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Resources/Images.xaml", UriKind.Relative)
                });
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Resources/Icons.xaml", UriKind.Relative)
                });
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Resources/Fonts.xaml", UriKind.Relative)
                });
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Resources/GenericStyles.xaml", UriKind.Relative)
                });
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Controls/CustomButtonStyle.xaml", UriKind.Relative)
                });
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Controls/ListButtonStyle.xaml", UriKind.Relative)
                });
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Controls/LinkButtonStyle.xaml", UriKind.Relative)
                });
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Controls/CustomTextBoxStyle.xaml", UriKind.Relative)
                });
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Controls/ModalWindowStyle.xaml", UriKind.Relative)
                });
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Controls/ModalWindowWCStyle.xaml", UriKind.Relative)
                });
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Resources/Themes/Dark/DarkTheme.xaml", UriKind.Relative)
                });
            }

            if (SystemVariables.SelectedTheme == "Light")
            {
                ApplicationThemeHelper.ApplicationThemeName = Theme.Office2019ColorfulName;
                Application.Current.Resources.MergedDictionaries.Clear();
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Resources/Images.xaml", UriKind.Relative)
                });
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Resources/Icons.xaml", UriKind.Relative)
                });
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Resources/Fonts.xaml", UriKind.Relative)
                });
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Resources/GenericLightStyles.xaml", UriKind.Relative)
                });
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Controls/CustomButtonLightStyle.xaml", UriKind.Relative)
                });
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Controls/ListButtonStyle.xaml", UriKind.Relative)
                });
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Controls/LinkButtonStyle.xaml", UriKind.Relative)
                });
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Controls/CustomTextBoxLightStyle.xaml", UriKind.Relative)
                });
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Controls/ModalWindowLightStyle.xaml", UriKind.Relative)
                });
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Controls/ModalWindowWCLightStyle.xaml", UriKind.Relative)
                });
                Application.Current.Resources.MergedDictionaries.Add(new ResourceDictionary()
                {
                    Source = new Uri("OfflineRetailV2;component/Resources/Themes/Light/LightTheme.xaml", UriKind.Relative)
                });
            }
            */

            /*
            base.OnStartup(e);

            //initialize the splash screen and set it as the application main window
            var splashScreen = new SplashScreenWindow();
            try
            {
                SystemVariables.BrandName = ConfigSettings.GetBrandName();
            }
            catch
            {
                SystemVariables.BrandName = "XEPOS Retail 2024";
            }
            splashScreen.lbBrand.Text = SystemVariables.BrandName;
            this.MainWindow = splashScreen;
            splashScreen.Show();
            */
            //in order to ensure the UI stays responsive, we need to
            //do the work on a different thread
            Task.Factory.StartNew(() =>
            {
                //we need to do the work in batches so that we can report progress
                /*for (int i = 1; i <= 100; i++)
                {
                    //simulate a part of work being done
                    System.Threading.Thread.Sleep(30);

                    //because we're not on the UI thread, we need to use the Dispatcher
                    //associated with the splash screen to update the progress bar
                    splashScreen.Dispatcher.Invoke(() => splashScreen.Progress = i);
                }*/

                //once we're done we need to use the Dispatcher
                //to create and show the main window
                this.Dispatcher.Invoke(() =>
                {
                    //initialize the main window, set it as the application main window
                    //and close the splash screen

                    var mainWindow = new MainWindow();
                    this.MainWindow = mainWindow;
                    mainWindow.Show();
                    //splashScreen.Close();
                });
            });

        }
        private void App_DispatcherUnhandledException(object sender, System.Windows.Threading.DispatcherUnhandledExceptionEventArgs e)
        {
            try
            {
                GeneralFunctions.SetCrashLog("UI Crash", e.Exception,
                    "User=" + (SystemVariables.CurrentUserName ?? "") +
                    "; Terminal=" + (Settings.TerminalName ?? ""));
            }
            catch { }
            // Keep existing fatal dialog behavior via MainWindow handler when registered;
            // mark handled only after logging so process can still surface the error UI.
        }

        private static void App_UnhandledException(object sender, UnhandledExceptionEventArgs e)
        {
            try
            {
                Exception ex = e.ExceptionObject as Exception;
                GeneralFunctions.SetCrashLog("Fatal Error", ex,
                    "IsTerminating=" + e.IsTerminating +
                    "; User=" + (SystemVariables.CurrentUserName ?? "") +
                    "; Terminal=" + (Settings.TerminalName ?? ""));
            }
            catch { }
        }

        private static void App_UnobservedTaskException(object sender, System.Threading.Tasks.UnobservedTaskExceptionEventArgs e)
        {
            try
            {
                GeneralFunctions.SetCrashLog("Task Crash", e.Exception,
                    "User=" + (SystemVariables.CurrentUserName ?? "") +
                    "; Terminal=" + (Settings.TerminalName ?? ""));
                e.SetObserved();
            }
            catch { }
        }

        private void PerformBackgroundWarmUp()
        {
            try
            {
                // --- 1. Fix the Printer Lag (System.Printing.dll) ---
                // Accessing this property forces .NET to load the DLL 
                // and talk to the Windows Print Spooler immediately.
                var printerCount = System.Drawing.Printing.PrinterSettings.InstalledPrinters.Count;

                // --- 2. Fix the DevExpress Lag (DevExpress.Xpf.Core.dll) ---
                // We wrap this in Dispatcher because UI controls must be created on a UI-compatible thread
                Application.Current.Dispatcher.Invoke(() =>
                {
                    try
                    {
                        // Force DevExpress Editors to load
                        var dummyBarcode = new DevExpress.Xpf.Editors.BarCodeEdit();
                        dummyBarcode.StyleSettings = new DevExpress.Xpf.Editors.Code128StyleSettings();

                        // Pre-load RichEdit (used by POS cart cell templates) so first cart row is cheaper.
                        var dummyRichEdit = new DevExpress.Xpf.RichEdit.RichEditControl();
                        dummyRichEdit.Width = 200;
                        dummyRichEdit.Height = 48;
                        dummyRichEdit.ApplyTemplate();
                        var htmlConverter = new DevExpress.Xpf.RichEdit.HtmlToContentConverter();
                        dummyRichEdit.Content = (DevExpress.Xpf.RichEdit.RichEditDocumentContent)htmlConverter.Convert(
                            "<font size='2' face='Open Sans'>warmup</font>",
                            typeof(DevExpress.Xpf.RichEdit.RichEditDocumentContent),
                            null,
                            System.Globalization.CultureInfo.InvariantCulture);
                        dummyRichEdit.Measure(new System.Windows.Size(200, 48));
                        dummyRichEdit.Arrange(new System.Windows.Rect(0, 0, 200, 48));
                        dummyRichEdit.UpdateLayout();

                        // Force Theme Manager to load
                        //var theme = DevExpress.Xpf.Core.ThemeManager.ActualThemeName;
                    }
                    catch { }
                }, System.Windows.Threading.DispatcherPriority.ApplicationIdle);
            }
            catch
            {
                // If there are no printers or an error occurs, just ignore it.
                // The goal is just to try and load the libraries.
            }
        }

    }
}
