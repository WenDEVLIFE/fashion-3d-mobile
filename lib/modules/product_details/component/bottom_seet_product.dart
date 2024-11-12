import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '/widgets/capitalized_word.dart';
import '../../../core/remote_urls.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../../category/component/price_card_widget.dart';
import '../../home/model/product_model.dart';
import '../../setting/model/website_setup_model.dart';
import '../model/product_variant_model.dart';

class BottomSheetProduct extends StatelessWidget {
  const BottomSheetProduct(
      {super.key, required this.product, required this.variantItem});

  final ProductModel product;
  final Set<ActiveVariantModel> variantItem;

  @override
  Widget build(BuildContext context) {
    const double height = 120;
    final appSetting = context.read<AppSettingCubit>();
    double flashPrice = 0.0;
    double offerPrice = 0.0;
    double mainPrice = 0.0;
    final isFlashSale = appSetting.settingModel!.flashSaleProducts
        .contains(FlashSaleProductsModel(productId: product.id));

    if (product.offerPrice.toString().isNotEmpty) {
      if (variantItem.isNotEmpty) {
        double p = 0.0;
        for (var i in variantItem) {
          if (i.activeVariantsItems.isNotEmpty) {
            p += Utils.toDouble(i.activeVariantsItems.first.price.toString());
          }
        }
        offerPrice = p + double.parse(product.offerPrice.toString());
      } else {
        offerPrice = double.parse(product.offerPrice.toString());
      }
    }
    if (variantItem.isNotEmpty) {
      double p = 0.0;
      for (var i in variantItem) {
        if (i.activeVariantsItems.isNotEmpty) {
          p += Utils.toDouble(i.activeVariantsItems.first.price.toString());
        }
      }
      mainPrice = p + double.parse(product.price.toString());
    } else {
      mainPrice = double.parse(product.price.toString());
    }

    if (isFlashSale) {
      if (product.offerPrice.toString().isNotEmpty) {
        final discount =
            appSetting.settingModel!.flashSale.offer / 100 * offerPrice;

        flashPrice = offerPrice - discount;
      } else {
        final discount =
            appSetting.settingModel!.flashSale.offer / 100 * mainPrice;

        flashPrice = mainPrice - discount;
      }
    }

    if (isFlashSale) {
      if (product.offerPrice.toString().isNotEmpty) {
        final discount =
            appSetting.settingModel!.flashSale.offer / 100 * offerPrice;

        flashPrice = offerPrice - discount;
      } else {
        final discount =
            appSetting.settingModel!.flashSale.offer / 100 * mainPrice;

        flashPrice = mainPrice - discount;
      }
    }
    return Container(
      height: height,
      padding: const EdgeInsets.all(15),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(4),
      //   border: Border.all(color: const Color(0xffE8EEF2)),
      //   color: const Color(0xffE8EEF2),
      // ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: cardBgColor,
              borderRadius: Utils.borderRadius(r: 4.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CustomImage(
                path: RemoteUrls.imageUrl(product.thumbImage),
                fit: BoxFit.cover,
                height: 85.0,
                width: 85.0,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name.capitalizeByWord(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                      height: 1.6,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: white),
                ),
                const SizedBox(height: 5),
                if (isFlashSale) ...[
                  PriceCardWidget(
                    price: mainPrice.toString(),
                    offerPrice: flashPrice.toString(),
                    priceColor: white,
                  ),
                ] else ...[
                  PriceCardWidget(
                    price: mainPrice.toString(),
                    offerPrice: offerPrice.toString(),
                    priceColor: white,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
