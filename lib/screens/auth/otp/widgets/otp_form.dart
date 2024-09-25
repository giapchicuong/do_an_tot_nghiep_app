import 'package:do_an_tot_nghiep/configs/router.dart';
import 'package:do_an_tot_nghiep/utils/constants/colors.dart';
import 'package:do_an_tot_nghiep/utils/constants/sizes.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../../utils/constants/text_strings.dart';
import 'otp_count_down_timer.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // OTP TITLE
            Text(AppText.otpCode, style: context.text.headlineMedium),
            const SizedBox(height: AppSizes.spaceBtwItems),

            // OTP FORM
            Pinput(
              length: 4,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              defaultPinTheme: PinTheme(
                width: AppSizes.otpWidth,
                height: AppSizes.appBarHeight,
                textStyle: context.text.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                decoration: BoxDecoration(
                  color: AppColors.borderPrimary,
                  borderRadius: BorderRadius.circular(AppSizes.md),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.defaultSpace),

            //   OTP button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.go(RouteName.login);
                },
                child: const Text(AppText.verify),
              ),
            ),
            const SizedBox(height: AppSizes.md),

            //   Resend OTP
            const OtpCountdownTimer(
              minutes: 2,
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
