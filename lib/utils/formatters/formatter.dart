import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../helpers/help_function.dart';

class AppFormatter {
  static double roundToSingleDecimal(double value) {
    return (value * 10).floorToDouble() / 10;
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
}
