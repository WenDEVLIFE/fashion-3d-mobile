import 'package:flutter/material.dart';
import 'package:shop_us/widgets/capitalized_word.dart';

import '/utils/k_images.dart';
import '/widgets/custom_image.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../model/order_model.dart';

class OrderedListComponent extends StatelessWidget {
  const OrderedListComponent({super.key, required this.orderedItem});

  final OrderModel orderedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 14),
      margin: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
      decoration: BoxDecoration(
          color: white,
          //borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: borderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _totalItem(context),
          const SizedBox(height: 10),
          _buildOrderNumber(context),
          const SizedBox(height: 10),
          // ...orderedItem.orderProducts.map((e) => SingleOrderDetailsComponent(
          //     orderItem: e, isOrdered: orderedItem.orderStatus == '3')),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: deepGreenColor,
                        backgroundColor: Colors.white,
                        side: BorderSide(
                            color: Utils.dynamicPrimaryColor(context),
                            width: 1.2),
                        shape: const RoundedRectangleBorder()),
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.singleOrderScreen,
                          arguments: orderedItem.orderId);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Text(
                        Language.viewDetails.capitalizeByWord(),
                        style: paragraphTextStyle(14.0).copyWith(
                            color: Utils.dynamicPrimaryColor(context)),
                      ),
                    )),
                Text(
                  Utils.orderStatus(orderedItem.orderStatus.toString()),
                  style: headlineTextStyle(16.0).copyWith(
                      color: orderedItem.orderStatus.toString() == '4'
                          ? Utils.dynamicPrimaryColor(context)
                          : deepGreenColor),
                  // style: TextStyle(
                  //     fontWeight: FontWeight.w600,
                  //     color: orderedItem.orderStatus == '4'
                  //         ? redColor
                  //         : deepGreenColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _totalItem(BuildContext context) {
    final total = Utils.formatPriceIcon(orderedItem.totalAmount, context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "${Language.quantity.capitalizeByWord()}: ",
                      style: headlineTextStyle(16.0),
                      children: [
                        TextSpan(
                          text: orderedItem.productQty.toString(),
                          style: headlineTextStyle(18.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text.rich(
                    TextSpan(
                      text: "${Language.totalAmount.capitalizeByWord()}: ",
                      style: paragraphTextStyle(16.0),
                      children: [
                        TextSpan(
                          text: total,
                          style: headlineTextStyle(16.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF222222).withOpacity(0.1),
                  //borderRadius: BorderRadius.circular(16.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Text(
                  Utils.formatDate(orderedItem.createdAt),
                  style: paragraphTextStyle(12.0)
                      .copyWith(color: const Color(0xff85959E)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    return Container(
      width: 70.0,
      height: 60.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: const CustomImage(path: KImages.female),
    );
  }

  Widget _buildOrderNumber(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: Utils.dynamicPrimaryColor(context).withOpacity(0.1),
        // borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* Text.rich(
            TextSpan(
              text: "Order No: ",
              style: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w400, color: blackColor),
              children: [
                TextSpan(
                  text: orderedItem.id.toString(),
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: blackColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6.0),*/
          _buildTrackingNumber(),
        ],
      ),
    );
  }

  Widget _buildTrackingNumber() {
    return Text.rich(
      TextSpan(
        text: "${Language.orderTrackingNumber.capitalizeByWord()}: ",
        // style: GoogleFonts.inter(
        //   fontSize: 16,
        //   fontWeight: FontWeight.w400,
        //   color: textGreyColor,
        //   decoration: TextDecoration.underline,
        // ),
        style: paragraphTextStyle(16.0)
            .copyWith(decoration: TextDecoration.underline),
        children: [
          TextSpan(
            text: ' ${orderedItem.orderId}',
            style: headlineTextStyle(16.0)
                .copyWith(decoration: TextDecoration.none),
          ),
        ],
      ),
    );
  }
}
