import 'package:do_an_tot_nghiep/utils/constants/colors.dart';
import 'package:do_an_tot_nghiep/utils/theme/widgets/appbar_theme,.dart';
import 'package:do_an_tot_nghiep/utils/theme/widgets/elevated_button_theme.dart';
import 'package:do_an_tot_nghiep/utils/theme/widgets/text_field_theme.dart';
import 'package:do_an_tot_nghiep/utils/theme/widgets/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      disabledColor: AppColors.grey,
      primaryColor: AppColors.primary,
      textTheme: AppTextTheme.lightTextTheme,
      scaffoldBackgroundColor: AppColors.primaryBackground,
      appBarTheme: AppbarTheme.lightAppBarTheme,
      inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
      elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme);
}
