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

  void _handleGoProductItem(productId) {
    print(productId);
    context.push(RouteName.product.replaceFirst(':id', productId));
  }

  @override
  Widget build(BuildContext context) {
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
                    const AvatarWidget(
                      userName: 'Giap Chi Cuong',
                      image:
                          'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1726358400&semt=ais_hybrid',
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
                            onTap: () => _handleGoProductItem(data.id),
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
                            onTap: () => _handleGoProductItem(data.id),
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
