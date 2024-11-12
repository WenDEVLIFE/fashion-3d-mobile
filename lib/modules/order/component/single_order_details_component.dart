import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_us/utils/language_string.dart';
import 'package:shop_us/widgets/capitalized_word.dart';

import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../model/product_order_model.dart';

class SingleOrderDetailsComponent extends StatelessWidget {
  const SingleOrderDetailsComponent({
    super.key,
    required this.orderItem,
    this.isOrdered = false,
  });

  final bool isOrdered;

  final OrderedProductModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 14, left: 14),
      child: InkWell(
        onTap: () {
          // Navigator.pushNamed(context, RouteNames.productDetailsScreen,
          //     arguments: orderItem.slug);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CustomImage(
            //   path: RemoteUrls.imageUrl(orderItem.thumbImage),
            //   height: 70,
            //   width: 70,
            //   fit: BoxFit.cover,
            // ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderItem.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: headlineTextStyle(15.0),
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: 'X',
                        style: paragraphTextStyle(12.0)
                            .copyWith(color: blackColor.withOpacity(0.6))),
                    const TextSpan(text: ' '),
                    TextSpan(
                        text: orderItem.qty.toString(),
                        style: GoogleFonts.roboto(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: Utils.dynamicPrimaryColor(context))),
                  ])),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Utils.formatPrice(orderItem.unitPrice, context),
                          style: GoogleFonts.roboto(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              color: Utils.dynamicPrimaryColor(context))),
                      if (isOrdered)
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteNames.submitFeedBackScreen,
                                arguments: orderItem);
                          },
                          child: Text(
                            Language.reviews.capitalizeByWord(),
                            style: headlineTextStyle(16.0),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
