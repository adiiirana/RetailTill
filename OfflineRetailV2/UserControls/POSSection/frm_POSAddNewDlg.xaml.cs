using OfflineRetailV2.Data;
using System;
using System.Windows;

namespace OfflineRetailV2.UserControls.POSSection
{
    /// <summary>
    /// Interaction logic for frm_POSAddNewDlg.xaml
    /// </summary>
    public partial class frm_POSAddNewDlg : Window
    {
        private void OnCloseCommand(object obj)
        {
            Close();
        }
        public int ReceivedParentID { get; set; }
        public event EventHandler SaveButtonClicked;
        public frm_POSAddNewDlg()
        {
            InitializeComponent();
            ModalWindow.CloseCommand = new CommandBase(OnCloseCommand);
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            try
            {
                if ((!SecurityPermission.AcssProductAdd) && (SystemVariables.CurrentUserID > 0))
                {
                    DocMessage.MsgPermission();
                    return;
                }
                AddProductWindow2 frm_ProductDlg = new AddProductWindow2
                {
                    Owner = Application.Current.MainWindow,
                    WindowStartupLocation = WindowStartupLocation.CenterOwner,
                    PreselectedCategoryID = ReceivedParentID,
                    
                };

                // Close this form before opening the next
                Close();

                frm_ProductDlg.ShowDialog();
            }
            catch (Exception ex)
            {
                
            }
        }

        private void Button_Click_Action(object sender, RoutedEventArgs e)
        {
            try
            {
                if ((!SecurityPermission.AcssCategory) && (SystemVariables.CurrentUserID > 0))
                {
                    DocMessage.MsgPermission();
                    return;
                }
                frm_CategoryDlg2 categoryDialog = new frm_CategoryDlg2
                {
                    Owner = Application.Current.MainWindow,
                    WindowStartupLocation = WindowStartupLocation.CenterOwner,
                    PreselectedCategoryID = ReceivedParentID
                };

                // Close this form before opening the next
                Close();

                categoryDialog.ShowDialog();
            }
            catch (Exception ex)
            {
                
            }
        }

        private void Button_Click_Save(object sender, RoutedEventArgs e)
        {
            try
            {
                // ✅ Raise the global event defined in AppEvents
                Close();
                AppEvents.RaiseRunMiscFunctionRequested();

                // Optionally close this window if needed
            }
            catch (Exception ex)
            {
                //MessageBox.Show($"Error while triggering RunMiscFunction event: {ex.Message}",
                //                "Error",
                //                MessageBoxButton.OK,
                //                MessageBoxImage.Error);
            }
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            //PreselectedCategoryID = ReceivedParentID
        }
    }
}
