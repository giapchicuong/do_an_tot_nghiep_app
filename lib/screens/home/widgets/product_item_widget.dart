import 'package:do_an_tot_nghiep/utils/constants/text_strings.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.nameProduct,
    required this.percent,
    required this.quantityPerson,
    required this.image,
    required this.onTap,
  });

  final String nameProduct, percent, quantityPerson, image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(AppSizes.md),
        margin: const EdgeInsets.symmetric(horizontal: AppSizes.xs),
        decoration: BoxDecoration(
          color: AppColors.grey.withOpacity(0.1),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppSizes.borderRadiusLg),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: image,
              child: Container(
                height: 286,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(
                    AppSizes.borderRadiusLg,
                  )),
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(image),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems / 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    nameProduct,
                    style: context.text.headlineSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.shield_outlined,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: AppSizes.xs),
                    Text(
                      percent,
                      style: context.text.headlineSmall!.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwItems / 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.camera_alt_outlined),
                    const SizedBox(width: AppSizes.xs),
                    Text(AppText.numberPerson, style: context.text.titleSmall),
                  ],
                ),
                Row(
                  children: [
                    Text('$quantityPerson+', style: context.text.titleSmall),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
