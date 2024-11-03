import 'package:do_an_tot_nghiep/utils/constants/colors.dart';
import 'package:do_an_tot_nghiep/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppShowSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    bool isSuccess = true,
    bool isShowForever = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: isShowForever
            ? const Duration(days: 365)
            : const Duration(seconds: 2),
        content: AppSnackBar(
          messsage: message,
          isSuccess: isSuccess,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  static void hide(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}

class AppSnackBar extends StatelessWidget {
  const AppSnackBar({
    super.key,
    required this.messsage,
    required this.isSuccess,
  });

  final String messsage;
  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isSuccess
              ? CupertinoIcons.checkmark_alt_circle_fill
              : CupertinoIcons.xmark_circle_fill,
          color: isSuccess ? AppColors.success : AppColors.error,
        ),
        const SizedBox(width: AppSizes.sm),
        Text(
          messsage,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontSize: AppSizes.fontSizeLg,
                color: AppColors.black,
              ),
        ),
      ],
    );
  }
}
