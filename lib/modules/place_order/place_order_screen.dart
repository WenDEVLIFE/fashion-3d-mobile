import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/modules/cart/model/checkout_response_model.dart';
import '/modules/place_order/controllers/bank/bank_cubit.dart';
import '/modules/place_order/controllers/stripe/stripe_cubit.dart';
import '/utils/k_images.dart';
import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '/widgets/custom_image.dart';
import '../../core/remote_urls.dart';
import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../widgets/rounded_app_bar.dart';
import '../authentication/controller/login/login_bloc.dart';
import 'controllers/cash_on_payment/cash_on_payment_cubit.dart';
import 'controllers/payment/payment_cubit.dart';
import 'controllers/razorpay/razorpay_cubit.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({
    super.key,
    // required this.body,
  });

  //final Map<String, dynamic> body;

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  CheckoutResponseModel? checkoutResponseModel;

  @override
  Widget build(BuildContext context) {
    final receivedValue =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final body = receivedValue['body'] as Map<String, dynamic>;
    final checkoutResponseModel =
        receivedValue['payment_status'] as CheckoutResponseModel;
    return MultiBlocListener(
      listeners: [
        BlocListener<CashOnPaymentCubit, CashPaymentState>(
          listener: (context, state) {
            if (state is CashPaymentStateLoading) {
              Utils.loadingDialog(context);
            } else {
              Utils.closeDialog(context);
              if (state is CashPaymentStateLoaded) {
                Utils.showSnackBar(context, state.message);
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.orderScreen, (route) {
                  if (route.settings.name == RouteNames.mainPage) {
                    return true;
                  }
                  return false;
                });
              } else if (state is CashPaymentStateError) {
                Utils.errorSnackBar(context, state.message);
              }
            }
          },
        ),
        BlocListener<PaymentCubit, PaymentState>(
          listener: (context, state) {
            if (state is PaymentLoading) {
              Utils.loadingDialog(context);
            } else {
              Utils.closeDialog(context);
              if (state is PaymentLoaded) {
                Utils.showSnackBar(context, state.transactionResponse.message!);
              } else if (state is PaymentError) {
                Utils.errorSnackBar(context, state.message);
              }
            }
          },
        ),
        // BlocListener<PaypalCubit, PaypalState>(
        //   listener: (context, state) {
        //     if (state is PaypalStateLoading) {
        //       Utils.loadingDialog(context);
        //     } else {
        //       Utils.closeDialog(context);
        //       if (state is PaypalStateLoaded) {
        //         Navigator.pushNamed(context, RouteNames.paypalScreen,
        //             arguments: state.message);
        //       } else if (state is PaypalStateError) {
        //         Utils.errorSnackBar(context, state.message);
        //       }
        //     }
        //   },
        // ),
        BlocListener<StripeCubit, StripeState>(
          listener: (context, state) {
            if (state is StripeLoading) {
              Utils.loadingDialog(context);
            } else {
              Utils.closeDialog(context);
              if (state is StripeLoaded) {
                Utils.showSnackBar(context, state.message);
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.orderScreen, (route) {
                  if (route.settings.name == RouteNames.mainPage) {
                    return true;
                  }
                  return false;
                });
              } else if (state is StripeError) {
                Utils.errorSnackBar(context, state.message);
              }
            }
          },
        ),
        BlocListener<BankCubit, BankState>(
          listener: (context, state) {
            if (state is BankStateLoading) {
              Utils.loadingDialog(context);
            } else {
              Utils.closeDialog(context);
              if (state is BankLoadedState) {
                Utils.showSnackBar(context, state.message);
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.orderScreen, (route) {
                  if (route.settings.name == RouteNames.mainPage) {
                    return true;
                  }
                  return false;
                });
              } else if (state is BankStateError) {
                Utils.errorSnackBar(context, state.message);
              }
            }
          },
        ),
        BlocListener<RazorpayCubit, RazorpayState>(listener: (context, state) {
          if (state is RazorStateLoading) {
            Utils.loadingDialog(context);
          } else {
            Utils.closeDialog(context);
            if (state is RazorStateError) {
              Utils.errorSnackBar(context, state.message);
            } else if (state is RazorStateLoaded) {
              final amount = state.razorOrder['amount'];
              final orderId = state.razorOrder['order_id'];
              Utils.showSnackBar(context, "$amount | $orderId");
              String params =
                  "shipping_method_id=${body['shipping_method_id']}&shipping_address_id=${body['shipping_address_id']}&billing_address_id=${body['billing_address_id']}&request_from=flutter_app&amount=$amount&order_id=$orderId";
              final token = context.read<LoginBloc>().userInfo!.accessToken;
              // debugPrint(RemoteUrls.razorOrder(token, params));
              Navigator.pushNamed(context, RouteNames.razorpayScreen,
                  arguments: RemoteUrls.payWithRazorpayWeb(token, params));
            } else if (state is RazorStateError) {
              Utils.errorSnackBar(context, state.message);
            }
          }
        }),
      ],
      child: Scaffold(
        backgroundColor: scaffoldBGColor,
        appBar: RoundedAppBar(
            titleText: Language.placeOrderNow.capitalizeByWord(),
            bgColor: scaffoldBGColor),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              Language.selectPaymentOption.capitalizeByWord(),
              style: headlineTextStyle(18.0),
            ),
            const SizedBox(height: 18),
            PaymentCard(
              status:
                  checkoutResponseModel.bankStatus!.status == 1 ? true : false,
              title: "Cash On Delivery",
              icon: KImages.codIcon,
              press: () {
                context.read<CashOnPaymentCubit>().cashOnDelivery(body);
              },
            ),
            PaymentCard(
              status: checkoutResponseModel.stripe!.status == 1 ? true : false,
              title: "Pay With Stripe",
              icon: KImages.stripeIcon,
              press: () {
                Navigator.pushNamed(context, RouteNames.stripeScreen,
                    arguments: body);
              },
            ),
            PaymentCard(
              status: checkoutResponseModel.paypalStatus!.status == 1
                  ? true
                  : false,
              title: "Pay With Paypal",
              icon: KImages.paypalIcon,
              press: () {
                String params =
                    "shipping_method_id=${body['shipping_method_id']}&shipping_address_id=${body['shipping_address_id']}&billing_address_id=${body['billing_address_id']}";
                final token = context.read<LoginBloc>().userInfo!.accessToken;
                debugPrint(RemoteUrls.payWithPaypalWeb(token, params));
                Navigator.pushNamed(context, RouteNames.paypalScreen,
                    arguments: RemoteUrls.payWithPaypalWeb(token, params));
              },
            ),
            PaymentCard(
              status: checkoutResponseModel.razorPayStatus!.status == 1
                  ? true
                  : false,
              title: "Pay With Razorpay",
              icon: KImages.razorpayIcon,
              press: () {
                context.read<RazorpayCubit>().payWithRazor(body);
              },
            ),
            PaymentCard(
              status:
                  checkoutResponseModel.flutterwave!.status == 1 ? true : false,
              title: "Pay with Flutter-wave",
              icon: KImages.flutterWaveIcon,
              press: () {
                String params =
                    "shipping_method_id=${body['shipping_method_id']}&shipping_address_id=${body['shipping_address_id']}&billing_address_id=${body['billing_address_id']}&request_from=flutter_app";
                final token = context.read<LoginBloc>().userInfo!.accessToken;
                // debugPrint(RemoteUrls.razorOrder(token, params));
                Navigator.pushNamed(context, RouteNames.flutterWaveScreen,
                    arguments: RemoteUrls.payWithFlutterWave(token, params));
              },
            ),
            PaymentCard(
              status:
                  checkoutResponseModel.payStackMolliStatus!.mollieStatus == 1
                      ? true
                      : false,
              title: "Pay With Mollie",
              icon: KImages.mollieIcon,
              press: () async {
                String params =
                    "shipping_method_id=${body['shipping_method_id']}&shipping_address_id=${body['shipping_address_id']}&billing_address_id=${body['billing_address_id']}&request_from=flutter_app";
                final token = context.read<LoginBloc>().userInfo!.accessToken;
                Navigator.pushNamed(context, RouteNames.molliePaymentScreen,
                        arguments: RemoteUrls.payWithMollieWeb(token, params))
                    .then((value) {
                  print("V: $value");
                  if (value == true) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RouteNames.orderScreen, (route) {
                      if (route.settings.name == RouteNames.mainPage) {
                        return true;
                      }
                      return false;
                    });
                  }
                });
              },
            ),
            PaymentCard(
              status: checkoutResponseModel.instamojoStatus!.status == 1
                  ? true
                  : false,
              title: "Pay With InstaMojo",
              icon: KImages.instamojoIcon,
              press: () {
                String params =
                    "shipping_method_id=${body['shipping_method_id']}&shipping_address_id=${body['shipping_address_id']}&billing_address_id=${body['billing_address_id']}&request_from=flutter_app";
                final token = context.read<LoginBloc>().userInfo!.accessToken;
                // debugPrint(RemoteUrls.razorOrder(token, params));
                Navigator.pushNamed(context, RouteNames.instamojoPaymentScreen,
                    arguments: RemoteUrls.payWithInstaMojoWeb(token, params));
              },
            ),
            PaymentCard(
              status:
                  checkoutResponseModel.payStackMolliStatus!.payStackStatus == 1
                      ? true
                      : false,
              title: "Pay With PayStack",
              icon: KImages.paystackIcon,
              press: () {
                String params =
                    "shipping_method_id=${body['shipping_method_id']}&shipping_address_id=${body['shipping_address_id']}&billing_address_id=${body['billing_address_id']}&request_from=flutter_app";
                final token = context.read<LoginBloc>().userInfo!.accessToken;
                // debugPrint(RemoteUrls.razorOrder(token, params));
                Navigator.pushNamed(context, RouteNames.paystackPaymentScreen,
                    arguments: RemoteUrls.payWithPayStackWeb(token, params));
              },
            ),
            PaymentCard(
              status: checkoutResponseModel.sslCommerzStatus!.status == 1
                  ? true
                  : false,
              title: "Pay with Ssl-commerce",
              icon: KImages.sslcommerz,
              press: () {
                String params =
                    "shipping_method_id=${body['shipping_method_id']}&shipping_address_id=${body['shipping_address_id']}&billing_address_id=${body['billing_address_id']}&request_from=flutter_app";
                final token = context.read<LoginBloc>().userInfo!.accessToken;
                Navigator.pushNamed(context, RouteNames.sslCommerceScreen,
                    arguments: RemoteUrls.payWithSslCommerz(token, params));
              },
            ),
            PaymentCard(
              status:
                  checkoutResponseModel.bankStatus!.cashOnDeliveryStatus == 1
                      ? true
                      : false,
              title: "Pay With Bank",
              icon: KImages.bankPayment,
              press: () {
                Navigator.pushNamed(context, RouteNames.bankScreen,
                    arguments: body);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  const PaymentCard(
      {super.key, this.title, this.icon, this.press, required this.status});

  final String? title;
  final String? icon;
  final VoidCallback? press;
  final bool status;

  @override
  Widget build(BuildContext context) {
    // bool isPng = icon!.split(".").last.toString() == "png" ? true : false;
    return Visibility(
      visible: status,
      child: InkWell(
        onTap: press,
        child: Container(
          height: 70,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
              color: borderColor,
              //borderRadius: BorderRadius.circular(40),
              border: Border.all(color: borderColor, width: 1)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: CustomImage(path: icon!),
              ),
              // const SizedBox(width: 8),
              // Expanded(
              //   flex: 3,
              //   child: Text(
              //     title!,
              //     style:
              //         const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              //   ),
              // ),

              const Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }
}
