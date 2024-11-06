import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/custom_shapes/containers/arrow_back.dart';
import '../../utils/constants/colors.dart';

class UpdateVipDetailScreen extends StatefulWidget {
  const UpdateVipDetailScreen({super.key, required this.durationId});

  final String durationId;

  @override
  State<UpdateVipDetailScreen> createState() => _UpdateVipDetailScreenState();
}

class _UpdateVipDetailScreenState extends State<UpdateVipDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.primary.withOpacity(0.15),
        leadingWidth: 80,
        actions: [
          const ArrowBack(),
          const Spacer(),
          Text(
            'Vip 1 - 30 ngày',
            style: context.text.headlineSmall!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          const Spacer(),
        ],
      ),
    );
  }
}
