import 'dart:io';

import 'package:do_an_tot_nghiep/configs/router.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_payment_post_bloc.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_payment_post_event.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_payment_post_state.dart';
import 'package:do_an_tot_nghiep/utils/constants/sizes.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../common/widgets/images/rounded_image.dart';
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

  static const EventChannel eventChannel =
      EventChannel('flutter.native/eventPayOrder');
  static const MethodChannel platform =
      MethodChannel('flutter.native/channelPayOrder');
  AppLifecycleState? _lastLifecycleState;
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
    }
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

    if (state == AppLifecycleState.paused) {
      print("App is in the background.");
    } else if (state == AppLifecycleState.resumed) {
      print("App is in the foreground.");
    }
  }

  void _onEvent(dynamic event) {
    print("_onEvent: '$event'.");
    if (event is Map<String, dynamic>) {
      final errorCode = event["errorCode"];
      print('Results: ${errorCode}');

      if (errorCode == 1) {
        context.read<UserPaymentPostBloc>().add(UserPaymentPostSuccessEvent());
      } else if (errorCode == 4) {
        context
            .read<UserPaymentPostBloc>()
            .add(UserPaymentPostFailureEvent(msg: "User hủy thanh toán"));
      } else {
        print(errorCode);
        context
            .read<UserPaymentPostBloc>()
            .add(UserPaymentPostFailureEvent(msg: "Giao dịch thất bại"));
      }
    } else {
      // Nếu không phải là Map thì báo lỗi hoặc xử lý sự kiện khác
      context
          .read<UserPaymentPostBloc>()
          .add(UserPaymentPostFailureEvent(msg: "Không nhận được dữ liệu"));
    }
  }

  void _onError(Object error) {
    print("_onError: '$error'.");
    context
        .read<UserPaymentPostBloc>()
        .add(UserPaymentPostFailureEvent(msg: "Giao dịch thất bại"));
  }

  Future<void> makePayment(String zpToken) async {
    print(zpToken);
    try {
      final String result =
          await platform.invokeMethod('payOrder', {"zptoken": zpToken});
      print('Payment result: $result');
    } on PlatformException catch (e) {
      print('Failed to invoke method: ${e.message}');
      // Xử lý lỗi hiển thị thông báo cho người dùng
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi thanh toán: ${e.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.primary.withOpacity(0.15),
        leadingWidth: 80,
        actions: [
          const Spacer(),
          Text(
            'Kết quả thanh toán',
            style: context.text.headlineSmall!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          const Spacer(),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocListener<UserPaymentPostBloc, UserPaymentPostState>(
          listener: (context, state) async {
            if (state is UserPaymentPostSuccess) {
              // await makePayment(state.userPaymentSuccessDto.zpTransToken);
              orderUrl = state.userPaymentSuccessDto.orderUrl;
              appTransId = state.userPaymentSuccessDto.appTransId;
            } else if (state is UserPaymentPostFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.msg)),
              );
            }
          },
          child: BlocBuilder<UserPaymentPostBloc, UserPaymentPostState>(
            builder: (context, state) {
              if (state is UserPaymentPostResultSuccess) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Thanh Toán thành công'),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.pushReplacement(RouteName.home);
                        },
                        child: const Text('Trở về Home'),
                      ),
                    )
                  ],
                );
              }
              if (state is UserPaymentPostResultInProgress) {
                return const CircularProgressIndicator();
              }
              if (state is UserPaymentPostSuccess) {
                return const PaymentFailure();
              }

              if (state is UserPaymentPostResultFailure) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(state.msg),
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () {
                          context.pushReplacement(RouteName.home);
                        },
                        child: const Text('Trở về Home'),
                      ),
                    )
                  ],
                );
              }
              return Container();
            },
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
    return Column(
      children: [
        const AppRoundedImage(
          padding: EdgeInsets.all(20),
          isNetworkImage: false,
          imageUrl: AppImages.loading,
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
              context.pushReplacement(RouteName.home);
            },
            child: const Text('Trở về trang home'),
          ),
        ),
      ],
    );
  }
}

class PaymentFailure extends StatelessWidget {
  const PaymentFailure({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppRoundedImage(
          padding: EdgeInsets.all(20),
          isNetworkImage: false,
          imageUrl: AppImages.error,
          applyImageRadius: true,
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        Text(
          'Thanh toán thất bại',
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
    );
  }
}

class PaymentLoading extends StatelessWidget {
  const PaymentLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppRoundedImage(
          padding: EdgeInsets.all(20),
          isNetworkImage: false,
          imageUrl: AppImages.loading,
          applyImageRadius: true,
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        Text(
          'Đang tiến thành thanh toán',
          style: context.text.titleLarge,
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              context.pushReplacement(RouteName.home);
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
    );
  }
}
