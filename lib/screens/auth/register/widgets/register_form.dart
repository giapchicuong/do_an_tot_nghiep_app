import 'package:do_an_tot_nghiep/components/widgets/dialog/snack_bar.dart';
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

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  late final _fullNameController = TextEditingController(text: '');
  late final _emailController = TextEditingController(text: '');
  late final _phoneController = TextEditingController(text: '');
  late final _passwordController = TextEditingController(text: '');
  late final _rePasswordController = TextEditingController(text: '');

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthRegisterStarted(
              fullName: _fullNameController.text,
              phone: _phoneController.text,
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
    }
  }

  void _handleRetry() {
    context.read<AuthBloc>().add(AuthStarted());
  }

  Widget _buildInitialRegisterWidget() {
    return AutofillGroup(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // FullName
            TextFormField(
              controller: _fullNameController,
              decoration: const InputDecoration(
                labelText: AppText.fullName,
                prefixIcon: Icon(
                  Iconsax.direct_right_copy,
                ),
              ),
            ),
            const SizedBox(height: AppSizes.defaultSpace),
            // Phone
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: AppText.phone,
                prefixIcon: Icon(
                  Iconsax.direct_right_copy,
                ),
              ),
            ),
            const SizedBox(height: AppSizes.defaultSpace),

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
            const SizedBox(height: AppSizes.spaceBtwItems),

            // RePassword
            TextFormField(
              controller: _rePasswordController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: AppText.rePassword,
                prefixIcon: Icon(
                  Iconsax.direct_right_copy,
                ),
                suffixIcon: Icon(Iconsax.eye_slash_copy),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),

            //   Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppText.validatePassword,
                  style: context.text.bodyMedium!
                      .copyWith(color: AppColors.subText),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            //   Sign up button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _handleSubmit(),
                child: const Text(AppText.signUp),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            //   have account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppText.dontHaveAccount,
                  style: context.text.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w400, color: AppColors.subText),
                ),
                TextButton(
                  onPressed: () => context.go(RouteName.login),
                  child: Text(
                    AppText.signIn,
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
            const SizedBox(height: AppSizes.spaceBtwSections),

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

  Widget _buildInProgressRegisterWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildFailureRegisterWidget(message) {
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

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    var registerWidget = (switch (authState) {
      AuthAuthenticateUnauthenticated() => _buildInitialRegisterWidget(),
      AuthRegisterInProgress() => _buildInProgressRegisterWidget(),
      AuthRegisterFailure(message: final msg) =>
        _buildFailureRegisterWidget(msg),
      AuthRegisterSuccess() => Container(),
      _ => Container()
    });

    registerWidget = BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisterSuccess) {
          context.go(RouteName.login);
          AppShowSnackBar.show(
              context: context, message: AppText.registerSuccess);
          context.read<AuthBloc>().add(
                AuthLoginPrefilled(
                  email: _emailController.text,
                  password: _passwordController.text,
                ),
              );
        }
      },
      child: registerWidget,
    );

    return registerWidget;
  }
}
