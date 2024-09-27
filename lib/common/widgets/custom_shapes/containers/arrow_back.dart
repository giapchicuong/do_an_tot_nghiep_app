import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/constants/colors.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void handleBack() {
      context.pop();
    }

    return Container(
      margin: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: IconButton(
        onPressed: () => handleBack(),
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
