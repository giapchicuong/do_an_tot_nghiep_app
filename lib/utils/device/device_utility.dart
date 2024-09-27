import 'package:flutter/material.dart';

class AppDeviceUtils {
  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
