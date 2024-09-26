import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key, required this.userName, required this.image});

  final String userName, image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.sm),
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSizes.borderRadiusFull),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: AppSizes.iconSm,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(image),
          ),
          const SizedBox(width: AppSizes.sm),
          Text(
            userName,
            style: context.text.bodyMedium!.copyWith(color: AppColors.text),
          )
        ],
      ),
    );
  }
}
