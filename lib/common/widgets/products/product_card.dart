import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shapes/containers/rouded_container.dart';
import '../images/rounded_image.dart';
import '../styles/shadow_styles.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
    this.subText,
    this.header,
    this.backgroundColor,
  });

  final String title, image;
  final String? subText, header;
  final VoidCallback onTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [AppShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        ),
        child: AppRoundedContainer(
          padding: const EdgeInsets.all(AppSizes.sm),
          backgroundColor:
              backgroundColor != null ? backgroundColor! : AppColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  //   Thumbnail Image
                  AppRoundedImage(
                    isNetworkImage: true,
                    imageUrl: image,
                    applyImageRadius: true,
                  ),
                ],
              ),

              //   Title
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (header != null)
                      Text(
                        header ?? '',
                        style: context.text.bodyLarge,
                      ),
                    Text(
                      title,
                      style: context.text.bodyLarge,
                    ),
                    if (subText != null)
                      Text(
                        subText ?? '',
                        style: context.text.bodyLarge,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
