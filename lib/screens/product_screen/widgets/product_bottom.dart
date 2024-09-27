import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class ProductBottom extends StatelessWidget {
  const ProductBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hiện tại",
                  style:
                      context.text.headlineSmall!.copyWith(color: Colors.grey),
                ),
                Text(
                  "0%",
                  style: context.text.headlineLarge,
                )
              ],
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 40,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: AppColors.gradientColor,
              ),
              child: const Text(
                "Đánh giá",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
