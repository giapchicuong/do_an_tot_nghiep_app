import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class AppRoundedContainer extends StatelessWidget {
  const AppRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = AppSizes.borderRadiusLg,
    this.child,
    this.showBorder = false,
    this.backgroundColor = AppColors.white,
    this.borderColor = AppColors.borderPrimary,
    this.padding,
    this.margin,
  });

  final double? width, height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color backgroundColor;
  final Color borderColor;
  final EdgeInsetsGeometry? padding, margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
