import 'package:do_an_tot_nghiep/common/widgets/custom_shapes/containers/rouded_container.dart';
import 'package:do_an_tot_nghiep/common/widgets/styles/shadow_styles.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class ImageFileCardWidget extends StatelessWidget {
  const ImageFileCardWidget({
    super.key,
    required this.title,
    required this.file,
    this.isAssetImage = false,
    this.isMemoryImage = false,
    this.subTitle,
  });

  final String title;
  final String? subTitle;
  final dynamic file;
  final bool isAssetImage;
  final bool isMemoryImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
              children: [
                AspectRatio(
                    aspectRatio: 16 / 9,
                    child:
                        isAssetImage ? Image.asset(file) : Image.network(file)
                    // : isMemoryImage
                    //     ? Image.memory(file)
                    //     : Image.file(
                    //         file,
                    //         fit: BoxFit.cover,
                    //       ),
                    ),
                //   Title
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: context.text.headlineMedium!
                            .copyWith(color: AppColors.primary),
                      ),
                      if (subTitle != null)
                        Text(
                          subTitle ?? '',
                          style: context.text.headlineMedium!
                              .copyWith(color: AppColors.primary),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
