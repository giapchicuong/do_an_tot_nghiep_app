import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../helpers/help_function.dart';

class AppFormatter {
  static double roundToSingleDecimal(double value) {
    return (value * 10).floorToDouble() / 10;
  }

  static String formatLevelAccount(String value) {
    switch (value) {
      case 'Nomal':
        return 'Thường';
      default:
        return value;
    }
  }

  static String getVietnameseName(String fruit) {
    switch (fruit) {
      case 'banana':
        return 'Trái chuối';
      case 'custardapple':
        return 'Quả na';
      case 'dragon':
        return 'Trái thanh Long';
      case 'guavas':
        return 'Trái ổi';
      case 'mango':
        return 'Trái xoài';
      case 'orange':
        return 'Trái cam';
      case 'passionfruit':
        return 'Trái chanh dây';
      case 'strawberry':
        return 'Trái dâu tây';
      case 'waxapple':
        return 'Trái mận';
      default:
        return 'Không xác định';
    }
  }

  static String formatTime(String value) {
    switch (value) {
      case 'months':
        return 'tháng';
      case 'days':
        return 'ngày';
      default:
        return value;
    }
  }

  static String formatLabelModel(data) {
    String name = '';
    String number = '';
    data.split('').forEach((ch) {
      if (AppHelpFunction.checkIsNumeric(ch)) {
        return number = number + ch;
      } else {
        return name = name + ch;
      }
    });
    return '${name.capitalize()} - $number%';
  }

  static String formatLabelModelGetName(data) {
    String name = '';
    String number = '';
    data.split('').forEach((ch) {
      if (AppHelpFunction.checkIsNumeric(ch)) {
        return number = number + ch;
      } else {
        return name = name + ch;
      }
    });
    return name.capitalize();
  }

  static String formatLabelModelGetNumber(data) {
    String number = '';
    data.split('').forEach((ch) {
      if (AppHelpFunction.checkIsNumeric(ch)) {
        return number = number + ch;
      }
    });
    return number;
  }

  static String getFormattedDateDayMonthYear(DateTime timestamp) {
    timeago.setLocaleMessages('vi', timeago.ViMessages());

    DateTime now = DateTime.now();

    if (timestamp.year == now.year &&
        timestamp.month == now.month &&
        timestamp.day == now.day) {
      return timeago.format(timestamp,
          locale: 'vi', allowFromNow: false, clock: now);
    } else {
      String format = 'dd/MM/yyyy';
      return DateFormat(format).format(timestamp);
    }
  }

  static String getFormattedDateDayMonthYearVN(DateTime timestamp) {
    timeago.setLocaleMessages('vi', timeago.ViMessages());

    String format = 'dd/MM/yyyy';
    return DateFormat(format).format(timestamp);
  }

  static String formatVNDCurrency(int amount) {
    final format = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: 'đ',
      decimalDigits: 0,
    );
    return format.format(amount);
  }

  static String extractFilenameFromUrl(String url) {
    return url.substring(url.lastIndexOf('/') + 1);
  }
}
