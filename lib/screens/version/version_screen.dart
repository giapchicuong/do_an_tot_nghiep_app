import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

import '../../common/widgets/custom_shapes/containers/arrow_back.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';

class VersionScreen extends StatefulWidget {
  const VersionScreen({super.key});

  @override
  State<VersionScreen> createState() => _VersionScreenState();
}

class _VersionScreenState extends State<VersionScreen> {
  double ratingValue = 0;
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
            AppText.versions,
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
                '${AppText.versions}: 1.0.0',
                style: context.text.headlineSmall!.copyWith(
                  fontSize: AppSizes.fontSizeMd,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              Text(
                'Ngày tạo: 20/05/2023',
                style: context.text.headlineSmall!.copyWith(
                  fontSize: AppSizes.fontSizeMd,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              Container(
                color: AppColors.grey,
                padding: const EdgeInsets.all(AppSizes.sm),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              '3.0',
                              style: context.text.headlineSmall!.copyWith(
                                fontSize: AppSizes.fontSizeLg,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: AppSizes.spaceBtwItems / 2),
                            StarRating(
                              size: 30,
                              color: AppColors.star,
                              allowHalfRating: true,
                              rating: 3.5,
                            ),
                            const SizedBox(height: AppSizes.spaceBtwItems / 2),
                            Text(
                              '45N',
                              style: context.text.headlineSmall!.copyWith(
                                fontSize: AppSizes.fontSizeLg,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Đánh giá model',
                                style: context.text.headlineSmall!.copyWith(
                                  fontSize: AppSizes.fontSizeMd,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              StarRating(
                                size: 40,
                                color: AppColors.star,
                                rating: ratingValue,
                                allowHalfRating: false,
                                onRatingChanged: (rating) {
                                  setState(() {
                                    ratingValue = rating;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
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
