import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shop_us/utils/language_string.dart';
import 'package:shop_us/widgets/capitalized_word.dart';

import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../../category/component/price_card_widget.dart';
import '../../setting/model/website_setup_model.dart';
import '../model/product_details_model.dart';
import '../model/product_details_product_model.dart';

class ProductDetailsComponent extends StatefulWidget {
  const ProductDetailsComponent({
    required this.product,
    required this.detailsModel,
    super.key,
  });

  final ProductDetailsProductModel product;
  final ProductDetailsModel detailsModel;

  @override
  State<ProductDetailsComponent> createState() =>
      _ProductDetailsComponentState();
}

class _ProductDetailsComponentState extends State<ProductDetailsComponent> {
  List<String> weightList = [
    '500 Gram',
    '600 Gram',
    '700 Gram',
    '800 Gram',
    '900 Gram',
  ];
  String weight = '500 Gram';

  @override
  Widget build(BuildContext context) {
    final appSetting = context.read<AppSettingCubit>();
    double flashPrice = 0.0;
    double offerPrice = 0.0;
    double mainPrice = 0.0;
    final isFlashSale = appSetting.settingModel!.flashSaleProducts
        .contains(FlashSaleProductsModel(productId: widget.product.id));

    if (widget.product.offerPrice.toString().isNotEmpty) {
      if (widget.product.activeVariantModel.isNotEmpty) {
        double p = 0.0;
        for (var i in widget.product.activeVariantModel) {
          if (i.activeVariantsItems.isNotEmpty) {
            p += Utils.toDouble(i.activeVariantsItems.first.price.toString());
          }
        }
        offerPrice = p + widget.product.offerPrice;
      } else {
        offerPrice = widget.product.offerPrice;
      }
    }
    if (widget.product.activeVariantModel.isNotEmpty) {
      double p = 0.0;
      for (var i in widget.product.activeVariantModel) {
        if (i.activeVariantsItems.isNotEmpty) {
          p += Utils.toDouble(i.activeVariantsItems.first.price.toString());
        }
      }
      mainPrice = p + widget.product.price;
    } else {
      mainPrice = widget.product.price;
    }

    if (isFlashSale) {
      if (widget.product.offerPrice.toString().isNotEmpty) {
        final discount =
            appSetting.settingModel!.flashSale.offer / 100 * offerPrice;

        flashPrice = offerPrice - discount;
      } else {
        final discount =
            appSetting.settingModel!.flashSale.offer / 100 * mainPrice;

        flashPrice = mainPrice - discount;
      }
    }

    widget.product.copyWith(
      offerPrice: isFlashSale ? flashPrice : offerPrice,
      price: mainPrice,
    );
    int qty = int.parse(widget.product.qty.toString());
    int qty2 = qty > 0 ? qty : 0;
    String result = qty2.toString();
    bool availability = widget.product.qty.toString().contains('-') ||
        widget.product.qty.toString() == '0';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.category!.name.toUpperCase(),
                      style: paragraphTextStyle(12.0),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      widget.product.name.capitalizeByWord(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: headlineTextStyle(18.0),
                    ),
                  ],
                ),
              ),
              /*  Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: borderColor,
                ),
                child: const Icon(Icons.share, color: Utils.dynamicPrimaryColor(context), size: 26.0),
              ),*/
            ],
          ),
          const SizedBox(height: 10.0),
          if (isFlashSale) ...[
            PriceCardWidget(
              price: mainPrice.toString(),
              offerPrice: flashPrice.toString(),
              textSize: 22,
            ),
          ] else ...[
            PriceCardWidget(
              price: mainPrice.toString(),
              offerPrice: offerPrice.toString(),
              textSize: 22,
            ),
          ],
          const SizedBox(height: 10.0),
          _builtRating(),
          const SizedBox(height: 10.0),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0)
                .copyWith(bottom: 6.0),
            decoration: BoxDecoration(
              color: greenColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: '${Language.availability.capitalizeByWord()}: ',
                  style: paragraphTextStyle(14.0)),
              TextSpan(
                  text: availability
                      ? Language.stockOut
                      : '${widget.product.qty} ${Language.productsAvailable}',
                  style: headlineTextStyle(15.0))
            ])),
          ),
          const SizedBox(height: 10.0),
          Text(
            widget.product.shortDescription,
            textAlign: TextAlign.justify,
            style: paragraphTextStyle(14.0),
          ),
          const SizedBox(height: 26),
        ],
      ),
    );
  }

  Widget _builtRating() {
    return Row(
      children: [
        RatingBar.builder(
          initialRating: widget.product.averageRating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          ignoreGestures: true,
          itemCount: 5,
          itemSize: 15,
          itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {},
        ),
        Container(
            width: 1,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            height: 24,
            color: borderColor),
        Text(
          Utils.getRating(widget.detailsModel.productReviews)
              .toStringAsFixed(1),
          style: headlineTextStyle(13.0),
        )
      ],
    );
  }

  Widget _builtPrice(String offerPrice, String mainPrice) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (offerPrice != "0.0") ...[
              Row(
                children: [
                  Text(
                    Utils.formatPrice(offerPrice, context),
                    style: const TextStyle(
                        color: redColor,
                        height: 1.5,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    Utils.formatPrice(mainPrice, context),
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Color(0xff85959E),
                      height: 1.5,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ] else ...[
              Text(
                Utils.formatPrice(mainPrice, context),
                style: const TextStyle(
                    color: redColor,
                    height: 1.5,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ],
            const SizedBox(height: 6),
            Text(
              widget.product.brand!.name,
              style: const TextStyle(fontSize: 16, color: iconGreyColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDropdownButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Language.size.capitalizeByWord(),
          style: simpleTextStyle(textGreyColor).copyWith(fontSize: 15.0),
        ),
        const SizedBox(height: 14.0),
        Container(
          height: 40.0,
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: const Color(0xFFFAE8F7))),
          child: DropdownButton<String>(
            onChanged: (String? val) => setState(() => weight = val!),
            value: weight,
            underline: const SizedBox(),
            icon: const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Icon(Icons.keyboard_arrow_down),
            ),
            items: weightList.map<DropdownMenuItem<String>>((e) {
              return DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: simpleTextStyle(textGreyColor),
                  ));
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget buildChooseColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'COLOR',
          style: simpleTextStyle(textGreyColor).copyWith(fontSize: 15.0),
        ),
        const SizedBox(height: 14.0),
        Container(
          height: 40.0,
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              color: const Color(0xFFFAE8F7),
            ),
          ),
          child: Row(
            children: List.generate(
                colors.length,
                (index) => Container(
                      height: 26.0,
                      width: 26.0,
                      margin: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                          color: colors[index],
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(color: const Color(0xFFFAE8F7))),
                    )),
          ),
        ),
      ],
    );
  }
}

final List<Color> colors = [
  const Color(0xFF5D5FEF),
  const Color(0xFFEF5DA8),
  const Color(0xFF56CCF2),
  const Color(0xFFF2C94C),
];
