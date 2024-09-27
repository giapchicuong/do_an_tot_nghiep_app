import 'package:do_an_tot_nghiep/mock_data/products.dart';
import 'package:do_an_tot_nghiep/screens/auth/forget_password/forget_password_screen.dart';
import 'package:do_an_tot_nghiep/screens/auth/otp/orp_screen.dart';
import 'package:do_an_tot_nghiep/screens/hisoty_review/hisoty_review_screen.dart';
import 'package:do_an_tot_nghiep/screens/home/home_screen.dart';
import 'package:do_an_tot_nghiep/screens/nutritional_statistics/nutritional_statistics_screen.dart';
import 'package:do_an_tot_nghiep/screens/product_screen/product_screen.dart';
import 'package:do_an_tot_nghiep/screens/products_favorite/products_favorite_screen.dart';
import 'package:do_an_tot_nghiep/screens/products_trending/products_trending_screen.dart';
import 'package:do_an_tot_nghiep/screens/search/search_screen.dart';
import 'package:do_an_tot_nghiep/screens/user/user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../screens/auth/login/login_screen.dart';
import '../screens/auth/register/register_screen.dart';
import '../screens/navigation_menu.dart';
import '../screens/settings/settings_screen.dart';

class RouteName {
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = '/forget-password';
  static const String otp = '/otp';

  static const String home = '/';

  // Product
  static const String products = '/';
  static const String product = '/product/:id';
  static const String productsFavorites = '/products-favorites';
  static const String productsTrending = '/products-trending';

  static const String search = '/search';
  static const String favorite = '/favorite';
  static const String message = '/message';

  // User
  static const String user = '/user';
  static const String history = 'history';
  static const String analyst = 'analyst';
  static const String settings = 'settings';

  static const publicRoutes = [
    login,
    register,
    forgetPassword,
    otp,

    //   Test
    home,
    user,
    search,
    favorite,
    productsFavorites,
    productsTrending,
    product,
    history,
    analyst,
    settings,
  ];
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: RouteName.home,
  navigatorKey: _rootNavigatorKey,
  // redirect: (context, state) {
  //   if (RouteName.publicRoutes.contains(state.fullPath)) {
  //     return null;
  //   }
  //   return RouteName.login;
  // },
  routes: [
    GoRoute(
      path: RouteName.login,
      builder: (context, state) => const LoginScreen(),
      pageBuilder: defaultPageBuilder(const LoginScreen()),
    ),
    GoRoute(
      path: RouteName.register,
      builder: (context, state) => const RegisterScreen(),
      pageBuilder: defaultPageBuilder(const RegisterScreen()),
    ),
    GoRoute(
      path: RouteName.forgetPassword,
      builder: (context, state) => const ForgetPasswordScreen(),
      pageBuilder: defaultPageBuilder(const ForgetPasswordScreen()),
    ),
    GoRoute(
      path: RouteName.otp,
      builder: (context, state) => const OtpScreen(),
      pageBuilder: defaultPageBuilder(const OtpScreen()),
    ),
    GoRoute(
      path: RouteName.productsFavorites,
      builder: (context, state) => const ProductsFavoriteScreen(),
      pageBuilder: defaultPageBuilder(const ProductsFavoriteScreen()),
    ),
    GoRoute(
      path: RouteName.productsTrending,
      builder: (context, state) => const ProductsTrendingScreen(),
      pageBuilder: defaultPageBuilder(const ProductsTrendingScreen()),
    ),
    GoRoute(
      path: RouteName.product,
      builder: (context, state) {
        Product product = state.extra as Product;
        return ProductScreen(
          id: state.pathParameters['id']!,
          product: product,
        );
      },
      pageBuilder: (context, state) {
        Product product = state.extra as Product;
        return buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: ProductScreen(
            product: product,
            id: state.pathParameters['id']!,
          ),
        );
      },
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
              path: RouteName.favorite,
              builder: (context, state) => const ProductsFavoriteScreen(),
              pageBuilder: defaultPageBuilder(const ProductsFavoriteScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteName.search,
              builder: (context, state) => const SearchScreen(),
              pageBuilder: defaultPageBuilder(const SearchScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteName.message,
              builder: (context, state) => Container(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteName.user,
              builder: (context, state) => const UserScreen(),
              pageBuilder: defaultPageBuilder(const UserScreen()),
              routes: [
                GoRoute(
                  path: RouteName.history,
                  builder: (context, state) => const HistoryReviewScreen(),
                  pageBuilder: defaultPageBuilder(const HistoryReviewScreen()),
                ),
                GoRoute(
                  path: RouteName.analyst,
                  builder: (context, state) => const NutritionalStatistics(),
                  pageBuilder:
                      defaultPageBuilder(const NutritionalStatistics()),
                ),
                GoRoute(
                  path: RouteName.settings,
                  builder: (context, state) => const SettingsScreen(),
                  pageBuilder: defaultPageBuilder(const SettingsScreen()),
                ),
              ],
            ),
          ],
        ),
      ],
    )
  ],
);

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

Page<dynamic> Function(BuildContext, GoRouterState) defaultPageBuilder<T>(
        Widget child) =>
    (BuildContext context, GoRouterState state) {
      return buildPageWithDefaultTransition<T>(
        context: context,
        state: state,
        child: child,
      );
    };
