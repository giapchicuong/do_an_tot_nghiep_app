import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    this.borderLeft = false,
    this.borderRight = false,
    required this.title,
    required this.number,
    this.day,
  });
  final bool borderLeft, borderRight;
  final String title, number;
  final String? day;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground.withOpacity(0.1),
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(borderLeft ? AppSizes.borderRadiusLg : 0),
          right: Radius.circular(borderRight ? AppSizes.borderRadiusLg : 0),
        ),
        border: Border.all(width: 0.3, color: AppColors.grey),
      ),
      child: Column(
        children: [
          Text(title, style: context.text.bodyLarge),
          const SizedBox(height: AppSizes.xs),
          Text(
            day == null ? number : '$number - $day ngày ',
            style: context.text.titleLarge!
                .copyWith(color: AppColors.action, fontSize: 15),
          )
        ],
      ),
    );
  }
}
