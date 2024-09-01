import 'package:do_an_tot_nghiep/screens/auth/forget_password/widgets/forget_password_form.dart';
import 'package:do_an_tot_nghiep/screens/auth/forget_password/widgets/forget_password_title.dart';
import 'package:do_an_tot_nghiep/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../utils/constants/colors.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          style: IconButton.styleFrom(backgroundColor: AppColors.borderPrimary),
          icon: const Icon(Iconsax.arrow_left_2_copy),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.lg),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                // title login
                ForgetPasswordTitle(),
                SizedBox(height: AppSizes.spaceBtwSections),

                //   Form input
                ForgetPasswordForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
