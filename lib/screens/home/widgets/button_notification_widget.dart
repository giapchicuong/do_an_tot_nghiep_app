import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class ButtonNotification extends StatelessWidget {
  const ButtonNotification({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: AppSizes.iconMd,
      backgroundColor: AppColors.grey.withOpacity(0.5),
      child: IconButton(
        iconSize: AppSizes.iconMd,
        highlightColor: Colors.transparent,
        icon: const Icon(
          Iconsax.notification_bing_copy,
          color: Colors.black,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
