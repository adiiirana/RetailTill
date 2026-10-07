using System;
using System.Globalization;
using System.Windows.Data;

namespace YourNamespace // Change to your actual namespace
{
    public class AdjustThumbSizeConverter : IValueConverter
    {
        public class BooleanToTextConverter : IValueConverter
        {
            public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
            {
                return (bool)value ? "On" : "Off";
            }

            public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
            {
                return (string)value == "On";
            }
        }

        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is double height)
            {
                // Subtract 4 to account for 2 units of margin on the left and 2 on the right
                return height - 4;
            }
            return value;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}