import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class IntroductionText extends StatelessWidget {
  const IntroductionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Đánh giá',
          style: context.text.headlineLarge!.copyWith(
            fontSize: AppSizes.fontSize2xl,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'độ tươi',
                style: context.text.headlineLarge!.copyWith(
                  fontSize: AppSizes.fontSize2xl,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: SizedBox(width: AppSizes.sm)),
              TextSpan(
                text: 'Trái cây!',
                style: context.text.headlineLarge!.copyWith(
                  fontSize: AppSizes.fontSize2xl,
                  fontWeight: FontWeight.w500,
                  color: AppColors.action,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
