import 'package:do_an_tot_nghiep/utils/theme/theme.dart';
import 'package:flutter/material.dart';

import 'configs/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
