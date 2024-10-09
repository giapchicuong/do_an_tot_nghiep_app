import 'package:do_an_tot_nghiep/utils/constants/colors.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'configs/router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.cubeGrid
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = AppColors.white
      ..backgroundColor = AppColors.black
      ..indicatorColor = AppColors.white
      ..textColor = AppColors.white
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      builder: (context, child) {
        return EasyLoading.init()(context, child);
      },
    );
  }
}
