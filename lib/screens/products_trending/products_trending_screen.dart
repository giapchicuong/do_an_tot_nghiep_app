import 'package:do_an_tot_nghiep/common/widgets/products/product_card.dart';
import 'package:do_an_tot_nghiep/mock_data/products.dart';
import 'package:do_an_tot_nghiep/utils/constants/sizes.dart';
import 'package:do_an_tot_nghiep/utils/constants/text_strings.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/custom_shapes/containers/arrow_back.dart';
import '../../common/widgets/layout/grid_layout.dart';
import '../../utils/constants/colors.dart';

class ProductsTrendingScreen extends StatelessWidget {
  const ProductsTrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.primary.withOpacity(0.15),
        leadingWidth: 80,
        actions: [
          const ArrowBack(),
          const Spacer(),
          Text(
            AppText.productTrending,
            style: context.text.headlineSmall!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          const Spacer(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppText.trending,
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
        ),
      ),
    );
  }
}
