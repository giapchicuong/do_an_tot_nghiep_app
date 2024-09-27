import 'package:do_an_tot_nghiep/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/custom_shapes/containers/arrow_back.dart';
import '../../../utils/constants/colors.dart';

class AppbarProduct extends StatelessWidget implements PreferredSizeWidget {
  const AppbarProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 80,
      backgroundColor: AppColors.primary.withOpacity(0.15),
      actions: [
        const ArrowBack(),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppDeviceUtils.getAppBarHeight());
}
