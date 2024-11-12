import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class PriceCardWidget extends StatelessWidget {
  const PriceCardWidget({
    super.key,
    required this.price,
    required this.offerPrice,
    this.textSize = 16,
    this.priceColor = primaryColor,
  });
  final String price;
  final double textSize;
  final String offerPrice;
  final Color priceColor;

  @override
  Widget build(BuildContext context) {
    if (offerPrice == "0.0") {
      return _buildPrice(Utils.formatPrice(price, context), context);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AutoSizeText(
          Utils.formatPrice(price, context),
          textAlign: TextAlign.left,
          maxFontSize: textSize - 4,
          minFontSize: textSize - 4,
          style: TextStyle(
            // fontWeight: FontWeight.w500,
            decoration: TextDecoration.lineThrough,
            decorationColor: priceColor,
            color: priceColor,
            height: 1.5,
            fontSize: textSize,
          ),
          maxLines: 1,
        ),
        const SizedBox(width: 10),
        _buildPrice(Utils.formatPrice(offerPrice, context), context),
      ],
    );
  }

  Widget _buildPrice(String price, BuildContext context) {
    return Text(
      price,
      style: GoogleFonts.roboto(
          // color: Utils.dynamicPrimaryColor(context),
          color: priceColor,
          height: 1.5,
          fontSize: textSize,
          fontWeight: FontWeight.w500),
    );
  }
}

// offerPrice = 15;
// price = 25;
//
// afterDiscount = 0.2 * 25 = 5;
// finalOfferPrice = price - afterDiscount = 20;
