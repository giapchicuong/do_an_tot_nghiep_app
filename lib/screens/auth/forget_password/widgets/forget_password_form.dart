import 'package:do_an_tot_nghiep/configs/router.dart';
import 'package:do_an_tot_nghiep/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../utils/constants/text_strings.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Form(
          child: Column(
        children: [
          // Email
          TextFormField(
            decoration: const InputDecoration(
              labelText: AppText.email,
              prefixIcon: Icon(
                Iconsax.direct_right_copy,
              ),
            ),
          ),
          const SizedBox(height: AppSizes.defaultSpace),

          //   Forget password button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.push(RouteName.otp);
              },
              child: const Text(AppText.resetPassword),
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
      )),
    );
  }
}
