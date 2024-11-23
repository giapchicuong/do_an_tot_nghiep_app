import 'package:do_an_tot_nghiep/features/user/dtos/user_duration_option_success_dto.dart';
import 'package:do_an_tot_nghiep/screens/hisoty_review/hisoty_review_screen.dart';
import 'package:do_an_tot_nghiep/screens/home/home_screen.dart';
import 'package:do_an_tot_nghiep/screens/payment/payment_screen.dart';
import 'package:do_an_tot_nghiep/screens/update_vip/update_vip_screen.dart';
import 'package:do_an_tot_nghiep/screens/update_vip_detail/update_vip_detail_screen.dart';
import 'package:do_an_tot_nghiep/screens/user/user_screen.dart';
import 'package:do_an_tot_nghiep/screens/version/version_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/bloc/auth_bloc.dart';
import '../screens/auth/login/login_screen.dart';
import '../screens/auth/register/register_screen.dart';
import '../screens/history_update_account/history_update_account.dart';
import '../screens/navigation_menu.dart';
import '../screens/payment_result/payment_result.dart';

class RouteName {
  static const String login = '/login';
  static const String register = '/register';

  static const String home = '/';
  static const String user = '/user';

  static const String version = 'version';
  static const String updateVip = 'update-vip';
  static const String updateVipDetail = 'update-vip-detail/:id';
  static const String payment = 'payment';
  static const String paymentResult = '/paymentResult';

  static const String history = 'history';
  static const String historyUpdateVip = 'history-update-vip';
  static const publicRoutes = [
    login,
    register,
    home,
  ];
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: RouteName.home,
  navigatorKey: _rootNavigatorKey,
  redirect: (context, state) {
    if (RouteName.publicRoutes.contains(state.fullPath)) {
      return null;
    }
    if (context.read<AuthBloc>().state is AuthAuthenticatedSuccess) {
      return null;
    }
    return RouteName.login;
  },
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
      path: RouteName.paymentResult,
      builder: (context, state) {
        // Lấy dữ liệu từ state.extra
        final extra = state.extra as Map<String, dynamic>;
        final durationId = extra['durationId'] as int;
        final methodId = extra['methodId'] as int;

        return PaymentResult(
          durationId: durationId,
          methodId: methodId,
        );
      },
    ),
    GoRoute(
        path: RouteName.home,
        builder: (context, state) {
          final authBloc = context.read<AuthBloc>().state;
          if (authBloc is AuthAuthenticatedSuccess) {
            return HomeScreen(
              fullName: authBloc.data.email,
            );
          }
          return const HomeScreen();
        }),
    GoRoute(
        path: RouteName.user,
        builder: (context, state) => const UserScreen(),
        routes: [
          GoRoute(
            path: RouteName.version,
            builder: (context, state) {
              final authBloc = context.read<AuthBloc>().state;
              if (authBloc is AuthAuthenticatedSuccess) {
                return VersionScreen(
                  userId: authBloc.data.userId,
                );
              }
              return Container();
            },
          ),
          GoRoute(
            path: RouteName.history,
            builder: (context, state) {
              return const HistoryReviewScreen();
            },
          ),
          GoRoute(
            path: RouteName.historyUpdateVip,
            builder: (context, state) {
              return const HistoryUpdateAccountScreen();
            },
          ),
          GoRoute(
            path: RouteName.updateVip,
            builder: (context, state) {
              final authBloc = context.read<AuthBloc>().state;
              if (authBloc is AuthAuthenticatedSuccess) {
                if (authBloc.data.durations?.durationId != null) {
                  return UpdateVipScreen(
                    durationId: authBloc.data.durations!.durationId,
                  );
                }
              }
              return const UpdateVipScreen();
            },
            routes: [
              GoRoute(
                path: RouteName.updateVipDetail,
                builder: (context, state) {
                  UserDurationOptionSuccessDto data =
                      state.extra as UserDurationOptionSuccessDto;
                  return UpdateVipDetailScreen(
                    durationId: data.durationId,
                    durationTime: data.durationTime,
                    durationName: data.durationName,
                    durationPrice: data.durationPrice,
                  );
                },
              ),
              GoRoute(
                path: RouteName.payment,
                builder: (context, state) {
                  int durationId = state.extra as int;
                  return PaymentScreen(
                    durationId: durationId,
                  );
                },
              ),
            ],
          ),
        ]),
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
                builder: (context, state) {
                  final authBloc = context.read<AuthBloc>().state;
                  if (authBloc is AuthAuthenticatedSuccess) {
                    return HomeScreen(
                      fullName: authBloc.data.email,
                    );
                  }
                  return const HomeScreen();
                }),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: RouteName.user,
                builder: (context, state) => const UserScreen(),
                routes: [
                  GoRoute(
                    path: RouteName.version,
                    builder: (context, state) {
                      final authBloc = context.read<AuthBloc>().state;
                      if (authBloc is AuthAuthenticatedSuccess) {
                        return VersionScreen(
                          userId: authBloc.data.userId,
                        );
                      }
                      return Container();
                    },
                  ),
                  GoRoute(
                    path: RouteName.updateVip,
                    builder: (context, state) {
                      final authBloc = context.read<AuthBloc>().state;
                      if (authBloc is AuthAuthenticatedSuccess) {
                        if (authBloc.data.durations?.durationId != null) {
                          return UpdateVipScreen(
                            durationId: authBloc.data.durations!.durationId,
                          );
                        }
                      }
                      return const UpdateVipScreen();
                    },
                    routes: [
                      GoRoute(
                        path: RouteName.updateVipDetail,
                        builder: (context, state) {
                          UserDurationOptionSuccessDto data =
                              state.extra as UserDurationOptionSuccessDto;
                          return UpdateVipDetailScreen(
                            durationId: data.durationId,
                            durationTime: data.durationTime,
                            durationName: data.durationName,
                            durationPrice: data.durationPrice,
                          );
                        },
                      ),
                      GoRoute(
                        path: RouteName.payment,
                        builder: (context, state) {
                          int durationId = state.extra as int;
                          return PaymentScreen(
                            durationId: durationId,
                          );
                        },
                      )
                    ],
                  ),
                ]),
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
