import 'package:do_an_tot_nghiep/features/user/bloc/user_payment_method_get_bloc.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_payment_method_get_event.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_payment_method_get_state.dart';
import 'package:do_an_tot_nghiep/features/user/data/user_api_client.dart';
import 'package:do_an_tot_nghiep/features/user/data/user_repository.dart';
import 'package:do_an_tot_nghiep/utils/formatters/formatter.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/custom_shapes/containers/arrow_back.dart';
import '../../injection_container.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class UpdateVipDetailScreen extends StatelessWidget {
  const UpdateVipDetailScreen({
    super.key,
    required this.durationId,
    required this.durationTime,
    required this.durationName,
    required this.durationPrice,
  });

  final int durationId;
  final int durationTime;
  final String durationName;
  final int durationPrice;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserPaymentMethodGetBloc(UserRepository(sl<UserApiClient>()))
            ..add(UserPaymentMethodGetStarted()),
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: AppColors.primary.withOpacity(0.15),
            leadingWidth: 80,
            actions: [
              const ArrowBack(),
              const Spacer(),
              Text(
                'Vip $durationId - $durationTime ${AppFormatter.formatTime(durationName)} - ${AppFormatter.formatVNDCurrency(durationPrice)}',
                style: context.text.headlineSmall!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              const Spacer(),
            ],
          ),
          body: const Padding(
            padding: EdgeInsets.all(20.0),
            child: UpdateVipBody(),
          )),
    );
  }
}

class UpdateVipBody extends StatefulWidget {
  const UpdateVipBody({
    super.key,
  });

  @override
  State<UpdateVipBody> createState() => _UpdateVipBodyState();
}

class _UpdateVipBodyState extends State<UpdateVipBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPaymentMethodGetBloc, UserPaymentMethodGetState>(
      builder: (context, state) {
        if (state is UserPaymentMethodGetSuccess) {
          return Column(
            children: [
              const SizedBox(height: AppSizes.spaceBtwSections),
              ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = state.userPaymentMethodSuccessDto[index];

                    return Padding(
                      padding: const EdgeInsets.all(AppSizes.xs),
                      child: CheckboxListTile(
                        dense: true,
                        visualDensity: VisualDensity.compact,
                        tileColor: AppColors.primary.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        title: Text(data.methodName),
                        value: data.methodId == 3,
                        onChanged: (bool? value) {},
                      ),
                    );
                  }),
              const SizedBox(height: AppSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {}, child: const Text('Thanh toán')),
              ),
            ],
          );
        }
        if (state is UserPaymentMethodGetFailure) {
          return Text(state.msg);
        }
        return Container();
      },
    );
  }
}
