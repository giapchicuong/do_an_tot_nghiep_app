import 'dart:io';

import 'package:do_an_tot_nghiep/features/user/bloc/user_payment_method_get_bloc.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_payment_method_get_event.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_payment_method_get_state.dart';
import 'package:do_an_tot_nghiep/features/user/data/user_api_client.dart';
import 'package:do_an_tot_nghiep/features/user/data/user_repository.dart';
import 'package:do_an_tot_nghiep/screens/update_vip_detail/repo/payment.dart';
import 'package:do_an_tot_nghiep/utils/formatters/formatter.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          body: SingleChildScrollView(
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: UpdateVipBody(),
            ),
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
  static const EventChannel eventChannel =
      EventChannel('flutter.native/eventPayOrder');
  static const MethodChannel platform =
      MethodChannel('flutter.native/channelPayOrder');
  final textStyle = TextStyle(color: Colors.black54);
  final valueStyle = TextStyle(
      color: Colors.orangeAccent, fontSize: 18.0, fontWeight: FontWeight.w400);
  String zpTransToken = "";
  String payResult = "";
  String payAmount = "10000";
  bool showResult = false;
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
    }
  }

  void _onEvent(dynamic event) {
    print("_onEvent: '$event'.");

    if (event is Map<String, dynamic>) {
      setState(() {
        if (event["errorCode"] == 1) {
          payResult = "Thanh toán thành công";
        } else if (event["errorCode"] == 4) {
          payResult = "User hủy thanh toán";
        } else {
          payResult = "Giao dịch thất bại";
        }
      });
    } else {
      print("Event is not a Map<String, dynamic>: $event");
    }
  }

  void _onError(Object error) {
    print("_onError: '$error'.");
    setState(() {
      payResult = "Giao dịch thất bại";
    });
  }

  // Button Create Order
  Widget _btnCreateOrder(String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: GestureDetector(
          onTap: () async {
            int amount = int.parse(value);
            if (amount < 1000 || amount > 1000000) {
              setState(() {
                zpTransToken = "Invalid Amount";
              });
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  });
              var result = await createOrder(amount);
              if (result != null) {
                Navigator.pop(context);
                zpTransToken = result.zptranstoken;
                setState(() {
                  zpTransToken = result.zptranstoken;
                  showResult = true;
                });
              }
            }
          },
          child: Container(
              height: 50.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text("Create Order",
                  style: TextStyle(color: Colors.white, fontSize: 20.0))),
        ),
      );

  /// Build Button Pay
  Widget _btnPay(String zpToken) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Visibility(
        visible: showResult,
        child: GestureDetector(
          onTap: () async {
            String response = "";
            try {
              final String result =
                  await platform.invokeMethod('payOrder', {"zptoken": zpToken});
              response = result;
              print("payOrder Result: '$result'.");
            } on PlatformException catch (e) {
              print("Failed to Invoke: '${e.message}'.");
              response = "Thanh toán thất bại";
            }
            print(response);
            setState(() {
              payResult = response;
            });
          },
          child: Container(
              height: 50.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text("Pay",
                  style: TextStyle(color: Colors.white, fontSize: 20.0))),
        ),
      ));

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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _quickConfig,
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Amount',
                      icon: Icon(Icons.attach_money),
                    ),
                    initialValue: payAmount,
                    onChanged: (value) {
                      setState(() {
                        payAmount = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                  ),
                  _btnCreateOrder(payAmount),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Visibility(
                      child: Text(
                        "zptranstoken:",
                        style: textStyle,
                      ),
                      visible: showResult,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      zpTransToken,
                      style: valueStyle,
                    ),
                  ),
                  _btnPay(zpTransToken),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Visibility(
                        child: Text("Transaction status:", style: textStyle),
                        visible: showResult),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      payResult,
                      style: valueStyle,
                    ),
                  ),
                ],
              )
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

  Widget _quickConfig = Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text("AppID: 2554"),
              ),
            ],
          ),
          // _btnQuickEdit,
        ],
      ));
}
