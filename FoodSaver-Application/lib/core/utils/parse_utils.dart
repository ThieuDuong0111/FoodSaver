import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ParseUtils {
  static String formatCurrency(double amount) {
    final NumberFormat formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'VND');
    return formatter.format(amount);
  }

  static String formatCurrencyWithoutSymbol(double amount) {
    final NumberFormat formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '');
    return formatter.format(amount);
  }

  static String formatDateTime(String originalDateTime) {
    final DateFormat originalFormat = DateFormat('yyyy-MM-dd HH:mm:ss.S');

    DateTime dateTime = originalFormat.parse(originalDateTime);
    dateTime = dateTime.add(const Duration(hours: 7));

    final DateFormat newFormat = DateFormat('dd/MM/yyyy-HH:mm');

    return newFormat.format(dateTime);
  }

  static String formatTimeDifference(String dateTimeString) {
    final DateTime inputTime = DateTime.parse(dateTimeString);
    final DateTime now = DateTime.now();

    final Duration difference = now.difference(inputTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ trước';
    } else {
      return '${difference.inDays} ngày trước';
    }
  }

  static String convertStatusTypeText(int statusType) {
    switch (statusType) {
      case 0:
        {
          return 'Đang chờ';
        }
      case 1:
        {
          return 'Xác nhận';
        }
      case 2:
        {
          return 'Đã hủy';
        }
      case 3:
        {
          return 'Hoàn thành';
        }
      default:
        return '';
    }
  }

  static Color convertStatusTypeColor(int statusType) {
    switch (statusType) {
      case 0:
        {
          return Colors.amber.shade600;
        }
      case 1:
        {
          return Colors.blue;
        }
      case 2:
        {
          return Colors.red;
        }
      case 3:
        {
          return Colors.green;
        }
      default:
        return Colors.black;
    }
  }
}
