import 'package:do_an_tot_nghiep/screens/auth/forget_password/forget_password_screen.dart';
import 'package:do_an_tot_nghiep/screens/auth/otp/orp_screen.dart';
import 'package:do_an_tot_nghiep/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../screens/auth/login/login_screen.dart';
import '../screens/auth/register/register_screen.dart';
import '../screens/navigation_menu.dart';

class RouteName {
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = '/forget-password';
  static const String otp = '/otp';

  static const String home = '/';

  static const publicRoutes = [
    login,
    register,
    forgetPassword,
    otp,

    //   Test
    home
  ];
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  redirect: (context, state) {
    if (RouteName.publicRoutes.contains(state.fullPath)) {
      return null;
    }
    return RouteName.login;
  },
  initialLocation: RouteName.home,
  routes: [
    GoRoute(
      path: RouteName.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RouteName.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: RouteName.forgetPassword,
      builder: (context, state) => const ForgetPasswordScreen(),
    ),
    GoRoute(
      path: RouteName.otp,
      builder: (context, state) => const OtpScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return NavigationMenu(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _sectionNavigatorKey,
          routes: [
            GoRoute(
              path: RouteName.home,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteName.home,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteName.home,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteName.home,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteName.home,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
      ],
    )
  ],
);
