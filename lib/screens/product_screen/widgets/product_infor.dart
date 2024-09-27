import 'package:do_an_tot_nghiep/screens/product_screen/widgets/bar_chart.dart';
import 'package:do_an_tot_nghiep/screens/product_screen/widgets/pie_chart.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

import '../../../utils/constants/colors.dart';

class ProductInfor extends StatelessWidget {
  const ProductInfor({
    super.key,
    required this.title,
    required this.description,
    required this.numberPerson,
    required this.percent,
  });

  final String title, description, numberPerson, percent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.text.headlineLarge!.copyWith(fontSize: 35),
        ),
        Row(
          children: [
            RatingBar.builder(
              initialRating: 4,
              itemSize: 30,
              allowHalfRating: true,
              itemBuilder: (context, index) => const Icon(
                Icons.star_rounded,
                color: Colors.orange,
              ),
              onRatingUpdate: (rating) {},
            ),
            Text(
              " ($numberPerson)",
              style: context.text.titleLarge!.copyWith(color: Colors.grey),
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  percent.toString(),
                  style: context.text.headlineSmall,
                ),
                const SizedBox(width: 10),
              ],
            )
          ],
        ),
        const SizedBox(height: 20),
        Text(
          "Mô tả",
          style: context.text.headlineSmall,
        ),
        const SizedBox(height: 20),
        ReadMoreText(
          description,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            height: 1.5,
            color: Colors.black26,
          ),
          trimLength: 110,
          trimCollapsedText: "Xem thêm",
          trimExpandedText: " Thu gọn",
          colorClickableText: AppColors.primary,
          moreStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Thống kê dinh dưỡng",
          style: context.text.headlineSmall,
        ),
        const SizedBox(height: 20),
        const PieChartSample2(),
        const SizedBox(height: 20),
        BarChartSample2()
      ],
    );
  }
}
