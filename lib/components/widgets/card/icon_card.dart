import 'package:do_an_tot_nghiep/common/widgets/custom_shapes/containers/rouded_container.dart';
import 'package:do_an_tot_nghiep/common/widgets/images/rounded_image.dart';
import 'package:do_an_tot_nghiep/common/widgets/styles/shadow_styles.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class IconCardWidget extends StatelessWidget {
  const IconCardWidget({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
    this.isNetworkImage = false,
  });

  final String title, image;
  final VoidCallback onTap;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppSizes.widthIconCard,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [AppShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppRoundedContainer(
              padding: const EdgeInsets.all(AppSizes.sm),
              backgroundColor: AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      //   Thumbnail Image
                      AppRoundedImage(
                        imageUrl: image,
                        isNetworkImage: isNetworkImage,
                        applyImageRadius: true,
                      ),
                    ],
                  ),
                  //   Title
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: context.text.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
