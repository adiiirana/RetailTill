using System;
using System.Drawing;
using System.Windows;
using System.Windows.Forms;

namespace OfflineRetailV2
{
    public static class SharedData
    {
        public static DualWindow DualWindowInstance { get; private set; }

        static SharedData()
        {
            InitializeDualWindow();
        }

        private static void InitializeDualWindow()
        {
            // Default dimensions
            int posL = 0;
            int posT = 0;
            int posW = 600;
            int posH = 800;

            // Log available screens for debugging
            Console.WriteLine("Available screens:");
            foreach (var screen in Screen.AllScreens)
            {
                Console.WriteLine($"Screen: {screen.DeviceName}, Bounds: {screen.Bounds}");
            }

            // Identify the second screen
            if (Screen.AllScreens.Length > 1)
            {
                Screen secondScreen = Screen.AllScreens[1];
                if (secondScreen != null)
                {
                    Console.WriteLine($"Second screen detected: {secondScreen.DeviceName}");
                    Rectangle workingArea = secondScreen.WorkingArea;

                    // Set window dimensions based on the second screen
                    posL = workingArea.Left;
                    posT = workingArea.Top;
                    posW = workingArea.Width;
                    posH = workingArea.Height;
                }
            }
            else
            {
                Console.WriteLine("Second monitor not detected. Defaulting to primary screen.");
            }

            // Initialize and configure the DualWindow instance
            DualWindowInstance = new DualWindow
            {
                Left = posL,
                Top = posT,
                Width = posW,
                Height = posH,
                WindowStyle = WindowStyle.None,
                ResizeMode = ResizeMode.NoResize,
                WindowStartupLocation = WindowStartupLocation.Manual, // Use manual positioning
                WindowState = WindowState.Normal // Start in normal state
            };

            // Forcefully position and maximize the window
            DualWindowInstance.Loaded += (s, e) =>
            {
                DualWindowInstance.Left = posL;
                DualWindowInstance.Top = posT;
                DualWindowInstance.Width = posW;
                DualWindowInstance.Height = posH;
                DualWindowInstance.WindowState = WindowState.Maximized; // Maximize after setting size
                Console.WriteLine("DualWindow positioned and maximized.");
            };
        }

        public static void ShowDualWindow()
        {
            if (DualWindowInstance != null)
            {
                DualWindowInstance.Show(); // Show the window on the second monitor
                DualWindowInstance.Activate(); // Bring it to the foreground
                Console.WriteLine("DualWindow shown.");
            }
            else
            {
                Console.WriteLine("DualWindowInstance is not initialized.");
            }
        }
    }
}
