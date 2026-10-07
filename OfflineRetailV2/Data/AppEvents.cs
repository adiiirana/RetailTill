using DevExpress.Xpf.Editors;
using System;
using System.Runtime.InteropServices;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Interop;
using System.Windows.Media;
using System.Windows.Media.Animation;


namespace OfflineRetailV2.Data
{
    /// <summary>
    /// Provides global application-wide events for communication between loosely coupled components.
    /// </summary>
    public static class AppEvents
    {
        public static event Action ConvenienceViewModeChanged;
        public static void RaiseConvenienceViewModeChanged()
        {
            ConvenienceViewModeChanged?.Invoke();
        }
        // 🔹 Existing global event: reload POS buttons
        public static event Action POSButtonsReloadRequested;

        /// <summary>
        /// Raises the POSButtonsReloadRequested event.
        public static event Action BoardingPassModeChanged;
        /// </summary>
        public static void RaisePOSButtonsReloadRequested()
        {
            POSButtonsReloadRequested?.Invoke();
        }
        public static event Action WholesaleModeChanged;

        /// <summary>
        /// Raises the WholesaleModeChanged event.
        /// </summary>
        public static void RaiseWholesaleModeChanged()
        {
            WholesaleModeChanged?.Invoke();
        }

        public static void RaiseBoardingPassModeChanged()
        {
            BoardingPassModeChanged?.Invoke();
        }

        // 🔹 New global event: RunMiscFunction
        public static event Action RunMiscFunctionRequested;

        /// <summary>
        /// Raises the RunMiscFunctionRequested event.
        /// </summary>
        public static void RaiseRunMiscFunctionRequested()
        {
            RunMiscFunctionRequested?.Invoke();
        }

        /// <summary>
        /// Optional: Clears all global event handlers (useful during app shutdown to prevent leaks).
        /// </summary>
        public static void ClearAllHandlers()
        {
            POSButtonsReloadRequested = null;
            RunMiscFunctionRequested = null;
            WholesaleModeChanged = null;
        }
    }

    /// <summary>
    /// Provides monitor-aware positioning helpers (for showing popups like on-screen keyboards
    /// relative to the window’s screen).
    /// </summary>
    public static class ScreenHelper
    {
        private const uint MONITOR_DEFAULTTONEAREST = 0x00000002;

        [DllImport("user32.dll")]
        private static extern IntPtr MonitorFromWindow(IntPtr hwnd, uint dwFlags);

        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        private static extern bool GetMonitorInfo(IntPtr hMonitor, ref MONITORINFOEX lpmi);

        [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Auto)]
        private struct MONITORINFOEX
        {
            public int cbSize;
            public RECT rcMonitor;
            public RECT rcWork;
            public uint dwFlags;

            [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)]
            public string szDevice;
        }

        [StructLayout(LayoutKind.Sequential)]
        private struct RECT
        {
            public int Left;
            public int Top;
            public int Right;
            public int Bottom;
        }

        /// <summary>
        /// Gets the working area (excluding taskbar) for the monitor that contains the specified window,
        /// converted into WPF coordinate space (DPI-aware).
        /// </summary>
        public static Rect GetWorkAreaForWindow(Window window)
        {
            if (window == null)
                throw new ArgumentNullException(nameof(window));

            var helper = new WindowInteropHelper(window);
            IntPtr hwnd = helper.Handle;
            if (hwnd == IntPtr.Zero)
                throw new InvalidOperationException("Window must be shown before getting work area.");

            IntPtr monitor = MonitorFromWindow(hwnd, MONITOR_DEFAULTTONEAREST);
            MONITORINFOEX info = new MONITORINFOEX();
            info.cbSize = Marshal.SizeOf(info);

            if (!GetMonitorInfo(monitor, ref info))
                throw new InvalidOperationException("GetMonitorInfo failed.");

            // Convert from device pixels → WPF DIPs (handles per-monitor DPI scaling)
            var src = HwndSource.FromHwnd(hwnd);
            if (src?.CompositionTarget == null)
                throw new InvalidOperationException("Unable to access CompositionTarget for DPI transform.");

            Matrix transform = src.CompositionTarget.TransformFromDevice;

            Point topLeft = transform.Transform(new Point(info.rcWork.Left, info.rcWork.Top));
            Point bottomRight = transform.Transform(new Point(info.rcWork.Right, info.rcWork.Bottom));

            return new Rect(topLeft, bottomRight);
        }
    }
    public class CustomToggleSwitch : ToggleSwitchEdit
    {
        private Border _switchTrack;
        private Border _switchThumb;
        private TranslateTransform _thumbTranslate;

        public Brush OnBackground
        {
            get { return (Brush)GetValue(OnBackgroundProperty); }
            set { SetValue(OnBackgroundProperty, value); }
        }

        public static readonly DependencyProperty OnBackgroundProperty =
            DependencyProperty.Register(nameof(OnBackground), typeof(Brush), typeof(CustomToggleSwitch),
                new PropertyMetadata(new SolidColorBrush(Color.FromRgb(41, 191, 106))));

        public Brush OffBackground
        {
            get { return (Brush)GetValue(OffBackgroundProperty); }
            set { SetValue(OffBackgroundProperty, value); }
        }

        public static readonly DependencyProperty OffBackgroundProperty =
            DependencyProperty.Register(nameof(OffBackground), typeof(Brush), typeof(CustomToggleSwitch),
                new PropertyMetadata(new SolidColorBrush(Color.FromRgb(224, 224, 224))));

        static CustomToggleSwitch()
        {
            DefaultStyleKeyProperty.OverrideMetadata(typeof(CustomToggleSwitch),
                new FrameworkPropertyMetadata(typeof(CustomToggleSwitch)));
        }

        public override void OnApplyTemplate()
        {
            base.OnApplyTemplate();

            _switchTrack = GetTemplateChild("PART_SwitchTrack") as Border;
            _switchThumb = GetTemplateChild("PART_SwitchThumb") as Border;

            if (_switchThumb != null)
            {
                _thumbTranslate = new TranslateTransform();
                _switchThumb.RenderTransform = _thumbTranslate;
            }

            // Initialize visuals
            UpdateVisualState(false);

            // Add click handler
            MouseLeftButtonUp += OnMouseLeftButtonUp;
        }

        private void OnMouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            IsChecked = !IsChecked;
            UpdateVisualState(true);
        }

        private void UpdateVisualState(bool animated)
        {
            if (_switchTrack == null || _switchThumb == null)
                return;

            var bg = IsChecked == true ? OnBackground : OffBackground;
            _switchTrack.Background = bg;

            double targetX = IsChecked == true ? 23 : 0;

            if (animated)
            {
                var anim = new DoubleAnimation(targetX, new Duration(TimeSpan.FromMilliseconds(150)))
                {
                    EasingFunction = new QuadraticEase { EasingMode = EasingMode.EaseInOut }
                };
                _thumbTranslate.BeginAnimation(TranslateTransform.XProperty, anim);
            }
            else
            {
                _thumbTranslate.X = targetX;
            }
        }
    }
}
