import 'package:do_an_tot_nghiep/utils/constants/sizes.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../common/widgets/layout/grid_layout.dart';
import '../../common/widgets/products/product_card.dart';
import '../../mock_data/products.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/text_strings.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary.withOpacity(0.15),
        leadingWidth: 80,
        actions: [
          const SizedBox(width: AppSizes.lg),
          Text(
            AppText.search,
            style: context.text.headlineSmall!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Text(
            AppText.cancel,
            style: context.text.headlineSmall!.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.action,
            ),
          ),
          const SizedBox(width: AppSizes.lg),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Column(
            children: [
              TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: AppText.searchFruist,
                  labelStyle:
                      context.text.titleLarge!.copyWith(color: AppColors.grey),
                  prefixIcon: const Icon(
                    Iconsax.search_normal_1_copy,
                    color: AppColors.grey,
                  ),
                  suffixIcon: const Icon(Iconsax.microphone_2_copy,
                      color: AppColors.grey),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppText.hisory,
                    style: context.text.headlineSmall!.copyWith(
                      fontSize: AppSizes.fontSizeLg,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  AppGridLayout(
                    itemCount: productFake.length,
                    itemBuilder: (_, index) {
                      final data = productFake[index];
                      return ProductCardWidget(
                        title: data.title,
                        image: data.image,
                        onTap: () {},
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
