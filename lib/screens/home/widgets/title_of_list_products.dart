import 'package:do_an_tot_nghiep/utils/constants/text_strings.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class TitleOfListProducts extends StatelessWidget {
  const TitleOfListProducts(
      {super.key, required this.title, required this.onPressed});

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: context.text.headlineLarge!.copyWith(
              fontSize: AppSizes.fontSize2Lg,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            AppText.seeAll,
            style: context.text.bodyLarge!.copyWith(
              color: AppColors.action,
            ),
          ),
        )
      ],
    );
  }
}
