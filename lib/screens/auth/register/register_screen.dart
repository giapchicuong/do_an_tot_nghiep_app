import 'package:do_an_tot_nghiep/screens/auth/register/widgets/register_form.dart';
import 'package:do_an_tot_nghiep/screens/auth/register/widgets/register_title.dart';
import 'package:do_an_tot_nghiep/utils/constants/colors.dart';
import 'package:do_an_tot_nghiep/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
          child: Center(
            child: Column(
              children: [
                // title login
                RegisterTitle(),
                SizedBox(height: AppSizes.spaceBtwSections),

                //   Form input
                RegisterForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
