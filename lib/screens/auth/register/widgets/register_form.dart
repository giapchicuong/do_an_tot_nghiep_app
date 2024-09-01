import 'package:do_an_tot_nghiep/configs/router.dart';
import 'package:do_an_tot_nghiep/utils/constants/colors.dart';
import 'package:do_an_tot_nghiep/utils/constants/image_strings.dart';
import 'package:do_an_tot_nghiep/utils/constants/sizes.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../utils/constants/text_strings.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Form(
        child: Column(
          children: [
            // Username
            TextFormField(
              decoration: const InputDecoration(
                labelText: AppText.userName,
                prefixIcon: Icon(
                  Iconsax.direct_right_copy,
                ),
              ),
            ),
            const SizedBox(height: AppSizes.defaultSpace),

            // Email
            TextFormField(
              decoration: const InputDecoration(
                labelText: AppText.valueLogin,
                prefixIcon: Icon(
                  Iconsax.direct_right_copy,
                ),
              ),
            ),
            const SizedBox(height: AppSizes.defaultSpace),

            // Password
            TextFormField(
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
                onPressed: () => context.push(RouteName.login),
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
                  onPressed: () => context.push(RouteName.login),
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
}
