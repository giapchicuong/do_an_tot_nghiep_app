import 'package:flutter/cupertino.dart';

import '../../../utils/constants/colors.dart';

class AppShadowStyle {
  static final verticalProductShadow = BoxShadow(
    color: AppColors.darkerGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );

  static final horizontalProductShadow = BoxShadow(
    color: AppColors.darkerGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );
}
