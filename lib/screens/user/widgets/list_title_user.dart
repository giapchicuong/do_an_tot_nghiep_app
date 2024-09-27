import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class ListTitleUser extends StatelessWidget {
  const ListTitleUser({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(
            icon,
            color: AppColors.subText,
          ),
          title: Text(
            title,
            style: context.text.titleMedium,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.subText,
          ),
          shape: const Border(
            bottom: BorderSide(width: 0.5, color: AppColors.grey),
          ),
        ),
      ),
    );
  }
}
