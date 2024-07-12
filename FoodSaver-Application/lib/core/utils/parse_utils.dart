import 'package:intl/intl.dart';

class ParseUtils {
  static String formatCurrency(double amount) {
    final NumberFormat formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'VND');
    return formatter.format(amount);
  }
}
