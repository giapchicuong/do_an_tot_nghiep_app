import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class ForgetPasswordTitle extends StatelessWidget {
  const ForgetPasswordTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppText.fotgetPassword,
          style: context.text.headlineMedium,
        ),
        const SizedBox(
          height: AppSizes.defaultSpace,
        ),
        Text(
          AppText.forgetPasswordSubText,
          textAlign: TextAlign.center,
          style: context.text.titleSmall!.copyWith(color: AppColors.subText),
        ),
      ],
    );
  }
}
