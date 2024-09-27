import 'package:do_an_tot_nghiep/mock_data/products.dart';
import 'package:do_an_tot_nghiep/screens/product_screen/widgets/appbar_product.dart';
import 'package:do_an_tot_nghiep/screens/product_screen/widgets/clip_path_detail.dart';
import 'package:do_an_tot_nghiep/screens/product_screen/widgets/pie_chart.dart';
import 'package:do_an_tot_nghiep/screens/product_screen/widgets/product_bottom.dart';
import 'package:do_an_tot_nghiep/screens/product_screen/widgets/product_infor.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    super.key,
    required this.id,
    required this.product,
  });

  final Product product;

  final String id;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.primaryBackground,
        appBar: const AppbarProduct(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  const SizedBox(height: 350),
                  Positioned(
                    bottom: 30,
                    left: 20,
                    right: 20,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12,
                            spreadRadius: 20,
                            color: AppColors.primary.withOpacity(0.1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: ClipPathDetail(),
                    child: Container(
                      height: 300,
                      width: size.width,
                      color: AppColors.primary.withOpacity(0.15),
                    ),
                  ),
                  Positioned(
                    bottom: -30,
                    left: 20,
                    right: 20,
                    child: Hero(
                      tag: product.image,
                      child: Image.network(
                        product.image,
                        width: size.width,
                        height: 400,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ProductInfor(
                  title: product.title,
                  description: product.description,
                  numberPerson: product.numberPerson,
                  percent: product.percent,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const ProductBottom(),
      ),
    );
  }
}
