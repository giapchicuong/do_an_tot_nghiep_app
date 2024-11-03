import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';

import '../helpers/help_function.dart';

class AppFormatter {
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
}
