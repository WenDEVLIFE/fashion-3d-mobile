import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_us/utils/language_string.dart';
import 'package:shop_us/widgets/capitalized_word.dart';

import '/modules/cart/model/cart_calculation_model.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../controllers/cart/cart_cubit.dart';
import '../model/cart_response_model.dart';

class PanelCollaspComponent extends StatelessWidget {
  const PanelCollaspComponent(
      {super.key,
      required this.height,
      required this.cartResponseModel,
      required this.totalPrice});

  final CartResponseModel cartResponseModel;
  final double height;
  final double totalPrice;

  TextStyle headingTextStyle() => GoogleFonts.jost(
      fontWeight: FontWeight.w700, fontSize: 18.0, color: white);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: bottomPanelColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(2),
            ),
            height: 4,
            width: 60,
          ),
          // const SizedBox(height: 9),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Language.orderAmount.capitalizeByWord(),
                style: headlineTextStyle(16.0).copyWith(color: Colors.white),
              ),
              Text(
                Utils.formatPriceIcon(totalPrice.toString(), context),
                style: headlineTextStyle(16.0).copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              // Container(
              //   //height: Utils.vSize(50.0),
              //   padding: Utils.all(value: 10.0),
              //   margin: Utils.only(right: 10.0),
              //   decoration: BoxDecoration(
              //     color: greenColor,
              //     borderRadius: Utils.borderRadius(r: 8.0),
              //   ),
              //   child: const CustomImage(
              //     path: KImages.whatsAppIcon,
              //   ),
              // ),
              Expanded(
                child: PrimaryButton(
                  text: Language.placeOrderNow.capitalizeByWord(),
                  borderRadiusSize: Utils.radius(40.0),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.checkoutScreen);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PanelComponent extends StatefulWidget {
  const PanelComponent({
    super.key,
    this.controller,
    required this.cartResponseModel,
    required this.cartCalculation,
  });

  final CartResponseModel cartResponseModel;

  final ScrollController? controller;
  final CartCalculation? cartCalculation;

  @override
  State<PanelComponent> createState() => _PanelComponentState();
}

class _PanelComponentState extends State<PanelComponent> {
  final textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  TextStyle panelTextStyle(FontWeight? fw, double? fs) => GoogleFonts.roboto(
      fontWeight: fw ?? FontWeight.w700, fontSize: fs ?? 18.0, color: white);

  TextStyle headingTextStyle() => GoogleFonts.jost(
      fontWeight: FontWeight.w700, fontSize: 18.0, color: white);

  @override
  Widget build(BuildContext context) {
    final couponCubit = context.read<CartCubit>().couponResponseModel;
    // double total = double.parse(widget.cartCalculation!.total);
    // print('nullCoupon $couponCubit');
    // if (couponCubit != null) {
    //   double maxPrice = double.parse(couponCubit.minPurchasePrice);
    // }
    // // print('couponnnnn $couponCubit');
    return Container(
      decoration: const BoxDecoration(
          color: bottomPanelColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )),
      child: ListView(
        controller: widget.controller,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        children: [
          Text(Language.applyCoupon.capitalizeByWord(),
              style: panelTextStyle(FontWeight.w400, 16.0)),
          const SizedBox(height: 7),
          _buildTextField(),
          const SizedBox(height: 8),
          Text(
            Language.billDetails.capitalizeByWord(),
            style: panelTextStyle(FontWeight.w700, 20.0),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Language.subTotal.capitalizeByWord(),
                style: panelTextStyle(FontWeight.w400, 16.0),
              ),
              Text(
                Utils.formatPriceIcon(
                    widget.cartCalculation!.subTotal, context),
                style: panelTextStyle(FontWeight.w400, 16.0),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Language.discountCoupon.capitalizeByWord(),
                style: const TextStyle(fontSize: 16, color: redColor),
              ),
              BlocConsumer<CartCubit, CartState>(listener: (context, state) {
                if (state is CartCouponStateLoading) {
                  Utils.loadingDialog(context);
                } else {
                  Utils.closeDialog(context);
                }
              }, builder: (context, state) {
                if (state is CartCouponStateError) {
                  return Text(state.message);
                }
                if (state is CartCouponStateLoaded) {
                  double total = double.parse(widget.cartCalculation!.total);
                  double coupon =
                      double.parse(state.couponResponseModel.discount);
                  final maxPrice =
                      double.parse(state.couponResponseModel.minPurchasePrice);
                  if (total >= maxPrice) {
                    widget.cartCalculation!
                        .copyWith(total: (total - coupon).toString());
                  }
                  print('totalll ${widget.cartCalculation!}');

                  return Text(
                      Utils.formatPriceIcon(
                          state.couponResponseModel.discount, context),
                      style: panelTextStyle(FontWeight.w400, 16.0)
                          .copyWith(color: redColor));
                }
                return const SizedBox();
              }),
            ],
          ),
          const SizedBox(height: 8),
          // Container(
          //   height: 1,
          //   color: borderColor,
          // ),
          // const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Language.orderAmount.capitalizeByWord(),
                style: headingTextStyle(),
              ),
              Text(
                Utils.formatPriceIcon(widget.cartCalculation!.total, context),
                style: headingTextStyle(),
              )
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              // Container(
              //   //height: Utils.vSize(50.0),
              //   padding: Utils.all(value: 10.0),
              //   margin: Utils.only(right: 10.0),
              //   decoration: BoxDecoration(
              //     color: greenColor,
              //     borderRadius: Utils.borderRadius(r: 8.0),
              //   ),
              //   child: const CustomImage(
              //     path: KImages.whatsAppIcon,
              //   ),
              // ),
              Expanded(
                child: PrimaryButton(
                  text: Language.checkout.capitalizeByWord(),
                  // bgColor: white,
                  // textColor: blackColor,
                  borderRadiusSize: Utils.radius(40.0),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.checkoutScreen);
                  },
                ),
              ),
            ],
          ),
          // SizedBox(
          //   height: 50,
          //   child: PrimaryButton(
          //     text: Language.checkout.capitalizeByWord(),
          //     onPressed: () {
          //       Navigator.pushNamed(context, RouteNames.checkoutScreen);
          //     },
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return Container(
      height: 55.0,
      width: 335.0,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD9D9D9)),
        borderRadius: BorderRadius.circular(55.0),
      ),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              controller: textController,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: Language.promoCode.capitalizeByWord(),
                hintStyle: panelTextStyle(FontWeight.w400, 16.0),
                isDense: true,
                fillColor: transparent,
                filled: true,
              ),
              style: headingTextStyle(),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (textController.text.isEmpty) {
                return;
              }
              // else if (total < maxPrice) {
              //   Utils.errorSnackBar(
              //       context, 'Minimum price for applying coupon $maxPrice');
              // }
              else {
                context
                    .read<CartCubit>()
                    .applyCoupon(textController.text.trim());
              }
              setState(() {});
            },
            child: Container(
              height: 52.0,
              width: 102.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // color: primaryColor,
                color: Utils.dynamicPrimaryColor(context),
                borderRadius: BorderRadius.circular(55.0),
              ),
              child: Text(Language.apply.capitalizeByWord(),
                  style: panelTextStyle(FontWeight.w600, 16.0)
                      .copyWith(color: blackColor)),
            ),
          ),
        ],
      ),
    );
  }
}
