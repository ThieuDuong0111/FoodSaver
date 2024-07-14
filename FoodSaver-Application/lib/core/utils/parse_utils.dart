import 'package:intl/intl.dart';

class ParseUtils {
  static String formatCurrency(double amount) {
    final NumberFormat formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'VND');
    return formatter.format(amount);
  }

  static String formatDateTime(String originalDateTime) {
    final DateFormat originalFormat = DateFormat('yyyy-MM-dd HH:mm:ss.S');

    DateTime dateTime = originalFormat.parse(originalDateTime);
    dateTime = dateTime.add(const Duration(hours: 7));

    final DateFormat newFormat = DateFormat('dd/MM/yyyy-HH:mm:ss');

    return newFormat.format(dateTime);
  }
}
