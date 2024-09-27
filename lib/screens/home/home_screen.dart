import 'package:do_an_tot_nghiep/screens/home/widgets/avatar_widget.dart';
import 'package:do_an_tot_nghiep/screens/home/widgets/button_notification_widget.dart';
import 'package:do_an_tot_nghiep/screens/home/widgets/introduction_text_widget.dart';
import 'package:do_an_tot_nghiep/screens/home/widgets/product_item_widget.dart';
import 'package:do_an_tot_nghiep/screens/home/widgets/title_of_list_products.dart';
import 'package:do_an_tot_nghiep/utils/constants/colors.dart';
import 'package:do_an_tot_nghiep/utils/constants/sizes.dart';
import 'package:do_an_tot_nghiep/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../configs/router.dart';
import '../../mock_data/products.dart';
import '../../mock_data/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _handleGoFavoriteProducts() {
    context.push(RouteName.productsFavorites);
  }

  void _handleGoTrendingProducts() {
    context.push(RouteName.productsTrending);
  }

  void _handleGoProductItem(productId, product) {
    context.push(
      RouteName.product.replaceFirst(':id', productId),
      extra: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = userFake;
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
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
                    AvatarWidget(
                      userName: data.fullName,
                      image: data.avatar,
                    ),
                    // Button Notification
                    ButtonNotification(
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),

                // Introduction text
                const IntroductionText(),
                const SizedBox(height: AppSizes.spaceBtwSections),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title && See All
                    TitleOfListProducts(
                      title: AppText.favorite,
                      onPressed: () => _handleGoFavoriteProducts(),
                    ),
                    const SizedBox(height: AppSizes.xs),

                    // List view horizontal
                    SizedBox(
                      width: double.infinity,
                      height: 400,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: productFake.length,
                        itemBuilder: (context, index) {
                          final data = productFake[index];
                          return ProductItemWidget(
                            nameProduct: data.title,
                            percent: data.percent,
                            quantityPerson: data.numberPerson,
                            image: data.image,
                            onTap: () => _handleGoProductItem(data.id, data),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections),

                    // Title && See All
                    TitleOfListProducts(
                      title: AppText.trending,
                      onPressed: () => _handleGoTrendingProducts(),
                    ),
                    const SizedBox(height: AppSizes.xs),

                    // List view horizontal
                    SizedBox(
                      width: double.infinity,
                      height: 400,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: productFake.length,
                        itemBuilder: (context, index) {
                          final data = productFake[index];
                          return ProductItemWidget(
                            nameProduct: data.title,
                            percent: data.percent,
                            quantityPerson: data.numberPerson,
                            image: data.image,
                            onTap: () => _handleGoProductItem(data.id, data),
                          );
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
