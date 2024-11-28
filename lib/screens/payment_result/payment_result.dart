import 'package:do_an_tot_nghiep/configs/router.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_payment_post_bloc.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_payment_post_event.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_payment_post_state.dart';
import 'package:do_an_tot_nghiep/utils/constants/sizes.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../common/widgets/images/rounded_image.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/user/data/user_api_client.dart';
import '../../features/user/data/user_repository.dart';
import '../../injection_container.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';

class PaymentResult extends StatelessWidget {
  const PaymentResult(
      {super.key, required this.methodId, required this.durationId});

  final int methodId;
  final int durationId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserPaymentPostBloc(UserRepository(sl<UserApiClient>()))
            ..add(UserPaymentPostStarted(
              durationId: durationId,
              methodId: methodId,
            )),
      child: const PaymentResultContent(),
    );
  }
}

class PaymentResultContent extends StatefulWidget with WidgetsBindingObserver {
  const PaymentResultContent({super.key});

  @override
  State<PaymentResultContent> createState() => _PaymentResultContentState();
}

class _PaymentResultContentState extends State<PaymentResultContent>
    with WidgetsBindingObserver {
  String orderUrl = '';
  String appTransId = '';

  AppLifecycleState? _lastLifecycleState;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _lastLifecycleState = state;
    });

    if (state == AppLifecycleState.paused) {}
    if (state == AppLifecycleState.resumed) {
      context
          .read<UserPaymentPostBloc>()
          .add(UserCheckStatusPaymentPostStarted(appTransId: appTransId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.primary.withOpacity(0.15),
        title: Text(
          'Kết quả thanh toán',
          style:
              context.text.headlineSmall!.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocListener<UserPaymentPostBloc, UserPaymentPostState>(
          listener: (context, state) async {
            if (state is UserPaymentPostSuccess) {
              orderUrl = state.userPaymentSuccessDto.orderUrl;
              appTransId = state.userPaymentSuccessDto.appTransId;
            } else if (state is UserPaymentPostFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.msg)),
              );
            }
          },
          child: SizedBox(
            width: double.infinity,
            height: height,
            child: BlocBuilder<UserPaymentPostBloc, UserPaymentPostState>(
              builder: (context, state) {
                if (state is UserPaymentPostSuccess) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is UserCheckStatusPaymentSuccess) {
                  if (state.isPaymentSuccess) {
                    return const PaymentSuccess();
                  }
                  if (!state.isPaymentSuccess && !state.isWaiting) {
                    return const PaymentFailure();
                  }
                  if (state.isWaiting) {
                    return PaymentLoading(
                      orderUrl: orderUrl,
                    );
                  }
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const AppRoundedImage(
            fit: BoxFit.contain,
            padding: EdgeInsets.all(20),
            isNetworkImage: false,
            imageUrl: AppImages.success,
            applyImageRadius: true,
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          Text(
            'Thanh toán thành công',
            style: context.text.titleLarge,
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                context.read<AuthBloc>().add(AuthAuthenticatedStarted());
                context.pushReplacement(RouteName.home);
              },
              child: const Text('Trở về trang home'),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentFailure extends StatelessWidget {
  const PaymentFailure({
    super.key,
    this.msg,
  });
  final String? msg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const AppRoundedImage(
            fit: BoxFit.contain,
            padding: EdgeInsets.all(20),
            isNetworkImage: false,
            imageUrl: AppImages.error,
            applyImageRadius: true,
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          Text(
            msg ?? 'Thanh toán thất bại',
            style: context.text.titleLarge,
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                context.pushReplacement(RouteName.home);
              },
              child: const Text('Trở về home'),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentLoading extends StatelessWidget {
  const PaymentLoading({
    super.key,
    this.orderUrl,
  });

  final String? orderUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const AppRoundedImage(
            fit: BoxFit.cover,
            padding: EdgeInsets.all(20),
            isNetworkImage: false,
            imageUrl: AppImages.loading,
            borderRadius: 20,
            applyImageRadius: true,
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          Text(
            'Đang chờ thanh toán',
            style: context.text.titleLarge,
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (orderUrl != null) {
                  context.read<UserPaymentPostBloc>().add(
                      UserPaymentOpenUrlPostStarted(orderUrl: orderUrl ?? ''));
                }
              },
              child: const Text('Tiếp tục thanh toán'),
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              onPressed: () async {
                context.pushReplacement(RouteName.home);
              },
              child: const Text('Hủy và trở về home'),
            ),
          ),
        ],
      ),
    );
  }
}
