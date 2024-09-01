import 'package:do_an_tot_nghiep/screens/auth/login/widgets/login_form.dart';
import 'package:do_an_tot_nghiep/screens/auth/login/widgets/login_title.dart';
import 'package:do_an_tot_nghiep/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.lg),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                // title login
                LoginTitle(),
                SizedBox(height: AppSizes.spaceBtwSections),

                //   Form input
                LoginForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
