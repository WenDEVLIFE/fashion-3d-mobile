import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../../setting/model/website_setup_model.dart';
import '../model/cart_product_model.dart';

class CheckoutSingleItem extends StatelessWidget {
  const CheckoutSingleItem(
      {super.key, required this.product, required this.appSetting});

  final CartProductModel product;
  final AppSettingCubit appSetting;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 40;

    double flashPrice = 0.0;
    double offerPrice = 0.0;
    double mainPrice = 0.0;
    final isFlashSale = appSetting.settingModel!.flashSaleProducts
        .contains(FlashSaleProductsModel(productId: product.product.id));

    if (product.product.offerPrice.toString().isNotEmpty) {
      if (product.product.productVariants.isNotEmpty) {
        double p = 0.0;
        for (var i in product.product.productVariants) {
          if (i.activeVariantsItems.isNotEmpty) {
            p += Utils.toDouble(i.activeVariantsItems.first.price.toString());
          }
        }
        offerPrice = p + product.product.offerPrice;
      } else {
        offerPrice = product.product.offerPrice;
      }
    }
    if (product.product.productVariants.isNotEmpty) {
      double p = 0.0;
      for (var i in product.product.productVariants) {
        if (i.activeVariantsItems.isNotEmpty) {
          p += Utils.toDouble(i.activeVariantsItems.first.price.toString());
        }
      }
      mainPrice = p + product.product.offerPrice;
    } else {
      mainPrice = product.product.offerPrice;
    }

    if (isFlashSale) {
      if (product.product.offerPrice.toString().isNotEmpty) {
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
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor),
        color: Colors.white,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(
                context, RouteNames.productDetailsScreen,
                arguments: product.product.slug),
            child: Container(
              margin: const EdgeInsets.all(6.0).copyWith(right: 4.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(6.0),
              ),
              height: 110.0,
              width: 110.0,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CustomImage(
                  path: RemoteUrls.imageUrl(product.product.thumbImage),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 2.0),
                  child: Text(
                    product.product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        headlineTextStyle(16.0).copyWith(color: primaryColor),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Utils.formatPrice(
                          Utils.cartProductPrice(context, product), context),
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        'x ${product.qty}',
                        style: GoogleFonts.jost(
                            fontSize: 16.0,
                            color: blackColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  children: product.variants
                      .map(
                        (e) => Text(
                          '${e.varientItem!.name} : ${e.varientItem!.price}, ',
                          style: headlineTextStyle(10.0),
                        ),
                      )
                      .toList(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
