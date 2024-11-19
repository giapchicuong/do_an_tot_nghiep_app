import 'package:do_an_tot_nghiep/configs/router.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_payment_post_bloc.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../common/widgets/custom_shapes/containers/arrow_back.dart';
import '../../features/user/bloc/user_payment_method_get_bloc.dart';
import '../../features/user/bloc/user_payment_method_get_event.dart';
import '../../features/user/bloc/user_payment_method_get_state.dart';
import '../../features/user/data/user_api_client.dart';
import '../../features/user/data/user_repository.dart';
import '../../injection_container.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({
    super.key,
    required this.durationId,
  });

  final int durationId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              UserPaymentMethodGetBloc(UserRepository(sl<UserApiClient>()))
                ..add(
                  UserPaymentMethodGetStarted(),
                ),
        ),
        BlocProvider(
            create: (context) =>
                UserPaymentPostBloc(UserRepository(sl<UserApiClient>())))
      ],
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
                'Thanh toán',
                style: context.text.headlineSmall!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              const Spacer(),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  Text(
                    'Chọn phương thức thanh toán',
                    style: context.text.titleLarge,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  PaymentContent(
                    durationId: durationId,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class PaymentContent extends StatelessWidget {
  const PaymentContent({super.key, required this.durationId});

  final int durationId;

  @override
  Widget build(BuildContext context) {
    void handlePayment({required int methodId}) {
      context.pushReplacement(
        RouteName.paymentResult,
        extra: {
          'methodId': methodId,
          'durationId': durationId,
        },
      );
    }

    return BlocBuilder<UserPaymentMethodGetBloc, UserPaymentMethodGetState>(
      builder: (context, state) {
        if (state is UserPaymentMethodGetSuccess) {
          return Column(
            children: [
              ListView.builder(
                  itemCount: state.userPaymentMethodSuccessDto.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = state.userPaymentMethodSuccessDto[index];

                    return Padding(
                      padding: const EdgeInsets.all(AppSizes.xs),
                      child: CheckboxListTile(
                        dense: true,
                        visualDensity: VisualDensity.compact,
                        tileColor: data.methodId == 4
                            ? AppColors.primary.withOpacity(0.4)
                            : AppColors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        title: Text(data.methodName),
                        subtitle: Text(
                            data.methodId == 4 ? 'Đã hỗ trợ' : 'Chưa hỗ trợ'),
                        value: data.methodId == 4,
                        onChanged: (bool? value) {},
                      ),
                    );
                  }),
              const SizedBox(height: AppSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => handlePayment(methodId: 4),
                    child: const Text('Thanh toán')),
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
