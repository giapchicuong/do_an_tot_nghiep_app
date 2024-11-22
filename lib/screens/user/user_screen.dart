import 'package:do_an_tot_nghiep/common/widgets/custom_shapes/containers/arrow_back.dart';
import 'package:do_an_tot_nghiep/configs/router.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_account_infor_get_bloc.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_account_infor_get_event.dart';
import 'package:do_an_tot_nghiep/features/user/data/user_api_client.dart';
import 'package:do_an_tot_nghiep/features/user/data/user_repository.dart';
import 'package:do_an_tot_nghiep/features/user/dtos/user_account_get_success_dto.dart';
import 'package:do_an_tot_nghiep/mock_data/user.dart';
import 'package:do_an_tot_nghiep/screens/user/widgets/card_item.dart';
import 'package:do_an_tot_nghiep/screens/user/widgets/list_title_user.dart';
import 'package:do_an_tot_nghiep/utils/constants/sizes.dart';
import 'package:do_an_tot_nghiep/utils/formatters/formatter.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/user/bloc/user_account_infor_get_state.dart';
import '../../injection_container.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/text_strings.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void handleGoUpdateVip() {
      context.push('${RouteName.user}/${RouteName.updateVip}');
    }

    void handleGoHistory() {
      context.push('${RouteName.user}/${RouteName.history}');
    }

    void handleGoHistoryUpdateVip() {
      context.push('${RouteName.user}/${RouteName.historyUpdateVip}');
    }

    void handleGoVersion() {
      context.push('${RouteName.user}/${RouteName.version}');
    }

    void handleLogout() {
      context.read<AuthBloc>().add(AuthLogoutStarted());
    }

    final userRepository = UserRepository(sl<UserApiClient>());
    Widget widget = BlocProvider(
      create: (context) => UserAccountInforGetBloc(userRepository)
        ..add(UserAccountInforGetStarted()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColors.primary.withOpacity(0.15),
          leadingWidth: 80,
          actions: [
            const ArrowBack(),
            const Spacer(),
            Text(
              AppText.profile,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Spacer(),
            const Spacer(),
            const Spacer(),

            // Container(
            //   margin: const EdgeInsets.only(left: 20),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     color: Colors.white,
            //   ),
            //   child: IconButton(
            //     onPressed: () {},
            //     icon: const Icon(
            //       Icons.edit,
            //       color: AppColors.primary,
            //     ),
            //   ),
            // ),
            // const SizedBox(width: 20),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: AppSizes.spaceBtwSections),
              const UserAccountDetail(),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Column(
                children: [
                  ListTitleUser(
                    title: AppText.historyReview,
                    icon: Icons.history,
                    onTap: () => handleGoHistory(),
                  ),
                  ListTitleUser(
                    title: AppText.historyVip,
                    icon: Icons.manage_history,
                    onTap: () => handleGoHistoryUpdateVip(),
                  ),
                  ListTitleUser(
                    title: AppText.vipUser,
                    icon: Icons.account_tree_outlined,
                    onTap: () => handleGoUpdateVip(),
                  ),
                  ListTitleUser(
                    title: AppText.logout,
                    icon: Icons.logout,
                    onTap: () => handleLogout(),
                  ),
                  ListTitleUser(
                    title: AppText.versions,
                    icon: Icons.account_tree_sharp,
                    onTap: () => handleGoVersion(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

    widget = BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state) {
          case AuthLogoutSuccess():
            context.pushReplacement(RouteName.login);
            context.read<AuthBloc>().add(AuthStarted());
            break;
          case AuthLogoutFailure(message: final msg):
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Logout Failure'),
                    content: Text(msg),
                    backgroundColor: context.color.surface,
                  );
                });
          default:
        }
      },
      child: widget,
    );

    return widget;
  }
}

class UserAccountDetail extends StatelessWidget {
  const UserAccountDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userAccountInforGetBloc =
        context.watch<UserAccountInforGetBloc>().state;

    Widget buildFailureUserAcountWidget(context, message) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSizes.lg),
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.3),
              borderRadius: const BorderRadius.all(
                Radius.circular(AppSizes.borderRadiusLg),
              ),
            ),
            child: Column(
              children: [
                Text(
                  message,
                  style: context.text.bodyLarge!
                      .copyWith(color: context.color.error),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    label: const Text(AppText.reTry),
                    icon: const Icon(Icons.refresh),
                  ),
                ),
              ],
            ),
          ),
        ]
            .animate(
              interval: 50.ms,
            )
            .slideX(
              begin: -0.1,
              end: 0,
              curve: Curves.easeInOutCubic,
              duration: 400.ms,
            )
            .fadeIn(
              curve: Curves.easeInOutCubic,
              duration: 400.ms,
            ),
      );
    }

    Widget buildInProgressUserAccountWidget() {
      return const Center(child: CircularProgressIndicator());
    }

    Widget buildInitialUserAcountWidget(BuildContext context,
        UserAccountGetSuccessDto userAccountGetSuccessDto) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(userFake.avatar),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: AppSizes.md),
                Text(
                  userAccountGetSuccessDto.fullName,
                  style: context.text.headlineMedium,
                ),
                const SizedBox(height: AppSizes.xs),
                Text(
                  userAccountGetSuccessDto.email,
                  style: context.text.bodyMedium,
                )
              ],
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
            child: Row(
              children: [
                CardItem(
                  title: AppText.numberReview,
                  number: userAccountGetSuccessDto.totalResultReview.toString(),
                  borderLeft: true,
                ),
                Expanded(
                  child: CardItem(
                    title: AppText.accountStatus,
                    number: AppFormatter.formatLevelAccount(
                        userAccountGetSuccessDto.statusName),
                    day: userAccountGetSuccessDto.timeInDayEnd.toString(),
                    borderRight: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    var userAccountInforWidget = switch (userAccountInforGetBloc) {
      UserAccountInforGetInProgress() => buildInProgressUserAccountWidget(),
      UserAccountInforGetSuccess(userAccountGetSuccessDto: final data) =>
        buildInitialUserAcountWidget(context, data),
      UserAccountInforGetFailure(msg: final msg) =>
        buildFailureUserAcountWidget(context, msg),
      _ => Container()
    };
    return userAccountInforWidget;
  }
}
