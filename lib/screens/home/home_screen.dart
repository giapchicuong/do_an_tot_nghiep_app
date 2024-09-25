import 'package:do_an_tot_nghiep/utils/constants/colors.dart';
import 'package:do_an_tot_nghiep/utils/constants/sizes.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //   Avatar && Notification Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Avatar
                    Container(
                      padding: const EdgeInsets.all(AppSizes.sm),
                      decoration: BoxDecoration(
                        color: AppColors.grey.withOpacity(0.5),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(AppSizes.borderRadiusFull),
                        ),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: AppSizes.iconSm,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1726358400&semt=ais_hybrid',
                            ),
                          ),
                          const SizedBox(width: AppSizes.sm),
                          Text(
                            'Giap Chi Cuong',
                            style: context.text.bodyMedium!
                                .copyWith(color: AppColors.text),
                          )
                        ],
                      ),
                    ),

                    // Button Notification
                    CircleAvatar(
                      radius: AppSizes.iconMd,
                      backgroundColor: AppColors.grey.withOpacity(0.5),
                      child: IconButton(
                        iconSize: AppSizes.iconMd,
                        highlightColor: Colors.transparent,
                        icon: const Icon(
                          Iconsax.notification_bing_copy,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),

                // Introduction text
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explore the',
                      style: context.text.headlineLarge!.copyWith(
                        fontSize: AppSizes.fontSize2xl,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Fresh',
                            style: context.text.headlineLarge!.copyWith(
                              fontSize: AppSizes.fontSize2xl,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const WidgetSpan(
                              alignment: PlaceholderAlignment.baseline,
                              baseline: TextBaseline.alphabetic,
                              child: SizedBox(width: AppSizes.sm)),
                          TextSpan(
                            text: 'Fruits!',
                            style: context.text.headlineLarge!.copyWith(
                              fontSize: AppSizes.fontSize2xl,
                              fontWeight: FontWeight.w500,
                              color: AppColors.action,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title && See All
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Best Favorite Fruits',
                          style: context.text.headlineLarge!.copyWith(
                            fontSize: AppSizes.fontSize2Lg,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'View all',
                            style: context.text.bodyLarge!.copyWith(
                              color: AppColors.action,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: AppSizes.xs),

                    // List view horizontal
                    SizedBox(
                      width: double.infinity,
                      height: 400,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return const ProductItem();
                        },
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Top Trending Product',
                          style: context.text.headlineLarge!.copyWith(
                            fontSize: AppSizes.fontSize2Lg,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'View all',
                            style: context.text.bodyLarge!.copyWith(
                              color: AppColors.action,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: AppSizes.xs),
                    // List view horizontal
                    SizedBox(
                      width: double.infinity,
                      height: 400,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return const ProductItem();
                        },
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(AppSizes.md),
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.xs),
      decoration: BoxDecoration(
          color: AppColors.grey.withOpacity(0.1),
          borderRadius:
              const BorderRadius.all(Radius.circular(AppSizes.borderRadiusLg))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 286,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(
                AppSizes.borderRadiusLg,
              )),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://images.pexels.com/photos/1313267/pexels-photo-1313267.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwItems / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Water Melon',
                  style: context.text.headlineSmall,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.shield_fill,
                    color: AppColors.info,
                  ),
                  const SizedBox(width: AppSizes.xs),
                  Text(
                    '85%',
                    style: context.text.headlineSmall!.copyWith(
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
                  const Icon(Iconsax.camera_copy),
                  const SizedBox(width: AppSizes.xs),
                  Text('Số người đánh giá', style: context.text.titleSmall),
                ],
              ),
              Row(
                children: [
                  Text('10+', style: context.text.titleSmall),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
