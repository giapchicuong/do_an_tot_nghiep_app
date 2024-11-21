import 'package:do_an_tot_nghiep/configs/router.dart';
import 'package:do_an_tot_nghiep/utils/constants/colors.dart';
import 'package:do_an_tot_nghiep/utils/constants/image_strings.dart';
import 'package:do_an_tot_nghiep/utils/constants/sizes.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../features/auth/bloc/auth_bloc.dart';
import '../../../../utils/constants/text_strings.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late final _authState = context.read<AuthBloc>().state;

  late final _emailController = TextEditingController(
    text: (switch (_authState) {
      AuthLoginInitial(email: final email) => email,
      _ => ''
    }),
  );

  late final _passwordController = TextEditingController(
    text: (switch (_authState) {
      AuthLoginInitial(password: final password) => password,
      _ => ''
    }),
  );

  void _handleGo() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthLoginStarted(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
    }
  }

  void _handleRetry() {
    context.read<AuthBloc>().add(AuthStarted());
  }

  void _handleGoRegister() {
    context.push(RouteName.register);
    context.read<AuthBloc>().add(AuthStarted());
  }

  Widget _buildInProgressLoginWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildFailureLoginWidget(message) {
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
                  onPressed: () => _handleRetry(),
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

  Widget _buildInitialLoginWidget(BuildContext context) {
    return AutofillGroup(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Email
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: AppText.email,
                prefixIcon: Icon(
                  Iconsax.direct_right_copy,
                ),
              ),
            ),
            const SizedBox(height: AppSizes.defaultSpace),

            // Password
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: AppText.password,
                prefixIcon: Icon(
                  Iconsax.direct_right_copy,
                ),
                suffixIcon: Icon(Iconsax.eye_slash_copy),
              ),
            ),
            const SizedBox(height: AppSizes.sm),

            //   Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    AppText.fotgetPassword,
                    style: context.text.titleMedium!
                        .copyWith(color: AppColors.action),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            //   Sign in button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _handleGo(),
                child: const Text(AppText.signIn),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            //   Don't have account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppText.dontHaveAccount,
                  style: context.text.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w400, color: AppColors.subText),
                ),
                TextButton(
                  onPressed: () => _handleGoRegister(),
                  child: Text(
                    AppText.signUp,
                    style: context.text.bodyMedium!
                        .copyWith(color: AppColors.action),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),

            //   Or connect
            Text(
              AppText.orConnect,
              style: context.text.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w400, color: AppColors.subText),
            ),
            const SizedBox(height: AppSizes.spaceBtwSections * 2),

            // Social Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(AppImages.facebook),
                ),
                const SizedBox(width: AppSizes.sm),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(AppImages.instagram),
                ),
                const SizedBox(width: AppSizes.sm),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(AppImages.twitter),
                ),
                const SizedBox(width: AppSizes.sm),
              ],
            )
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    var loginWidget = (switch (authState) {
      AuthAuthenticateUnauthenticated() => _buildInitialLoginWidget(context),
      AuthLoginInitial() => _buildInitialLoginWidget(context),
      AuthLoginInProgress() => _buildInProgressLoginWidget(),
      AuthLoginFailure(message: final msg) => _buildFailureLoginWidget(msg),
      AuthLoginSuccess() => Container(),
      _ => Container(),
    });
    loginWidget = BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state) {
          case AuthLoginSuccess():
            context.read<AuthBloc>().add(AuthAuthenticatedStarted());
            break;
          case AuthAuthenticatedSuccess():
            context.pushReplacement(RouteName.home);
            break;
          default:
        }
      },
      child: loginWidget,
    );

    return loginWidget;
  }
}
