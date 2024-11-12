import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_us/widgets/capitalized_word.dart';

import '/modules/category/component/price_card_widget.dart';
import '/widgets/favorite_button.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../../cart/controllers/cart/add_to_cart/add_to_cart_cubit.dart';
import '../../cart/model/add_to_cart_model.dart';
import '../../setting/model/website_setup_model.dart';
import '../model/product_details_product_model.dart';
import '../model/product_variant_model.dart';

class RelatedSingleProductCard extends StatelessWidget {
  final ProductDetailsProductModel productModel;
  final double? width;

  RelatedSingleProductCard({super.key, required this.productModel, this.width});

  final Set<ActiveVariantModel> variantItems = {};

  @override
  Widget build(BuildContext context) {
    final appSetting = context.read<AppSettingCubit>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          height: singleProductHeight,
          margin: Utils.only(bottom: 10.0),
          decoration: const BoxDecoration(
            color: cardBgColor,
            // color: white,
            //  borderRadius: BorderRadius.circular(5.0),
            // border: borderSide,
          ),
          child: Stack(
            //mainAxisSize: MainAxisSize.min,
            fit: StackFit.expand,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, RouteNames.productDetailsScreen,
                    arguments: productModel.slug),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildImage(),
                    //const SizedBox(height: 8),
                    // _buildContent(appSetting),
                  ],
                ),
              ),
              Positioned(
                  bottom: 0.0, right: 0.0, child: addToCartButton(context)),
              Positioned(
                  left: 10.0,
                  top: 10.0,
                  child: FavoriteButton(productId: productModel.id))
            ],
          ),
        ),
        Flexible(fit: FlexFit.loose, child: _buildContent(appSetting)),
      ],
    );
  }

  Widget _buildContent(AppSettingCubit appSetting) {
    double flashPrice = 0.0;
    double offerPrice = 0.0;
    double mainPrice = 0.0;
    final isFlashSale = appSetting.settingModel!.flashSaleProducts
        .contains(FlashSaleProductsModel(productId: productModel.id));

    if (productModel.offerPrice.toString().isNotEmpty) {
      if (productModel.activeVariantModel.isNotEmpty) {
        double p = 0.0;
        for (var i in productModel.activeVariantModel) {
          if (i.activeVariantsItems.isNotEmpty) {
            p += Utils.toDouble(i.activeVariantsItems.first.price.toString());
          }
        }
        offerPrice = p + productModel.offerPrice;
      } else {
        offerPrice = productModel.offerPrice;
      }
    }
    if (productModel.activeVariantModel.isNotEmpty) {
      double p = 0.0;
      for (var i in productModel.activeVariantModel) {
        if (i.activeVariantsItems.isNotEmpty) {
          p += Utils.toDouble(i.activeVariantsItems.first.price.toString());
        }
      }
      mainPrice = p + productModel.price;
    } else {
      mainPrice = productModel.price;
    }

    if (isFlashSale) {
      if (productModel.offerPrice.toString().isNotEmpty) {
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
      padding: const EdgeInsets.only(left: 10, right: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   children: [
          //     const Icon(
          //       Icons.star,
          //       size: 14,
          //       color: Color(0xffF6D060),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(bottom: 4.0, left: 5.0),
          //       child: Text(double.parse(productModel.averageRating.toString())
          //           .toStringAsFixed(1)),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 6),
          AutoSizeText(productModel.name.capitalizeByWord(),
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              maxFontSize: 15,
              minFontSize: 13,
              style: headlineTextStyle(15.0)),
          const SizedBox(height: 0),
          if (isFlashSale) ...[
            PriceCardWidget(
              price: mainPrice.toString(),
              offerPrice: flashPrice.toString(),
              textSize: 16,
            ),
          ] else ...[
            PriceCardWidget(
              price: mainPrice.toString(),
              offerPrice: offerPrice.toString(),
              textSize: 16,
            ),
          ],
          // PriceCardWidget(
          //     price: Utils.formatPrice(productModel.price),
          //     offerPrice: Utils.formatPrice(productModel.offerPrice))
          // Row(
          //   children: [
          //     Text(
          //       Utils.formatPrice(productModel.offerPrice),
          //       style: const TextStyle(
          //           color: redColor,
          //           height: 1.5,
          //           fontSize: 18,
          //           fontWeight: FontWeight.w600),
          //     ),
          //     const SizedBox(width: 10),
          //     Text(
          //       Utils.formatPrice(productModel.price),
          //       style: const TextStyle(
          //         decoration: TextDecoration.lineThrough,
          //         color: Color(0xff85959E),
          //         height: 1.5,
          //         fontSize: 14,
          //       ),
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      alignment: Alignment.center,
      //padding: Utils.symmetric(h: 10.0),
      height: 200.0,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomImage(
              path: RemoteUrls.imageUrl(productModel.thumbImage),
              fit: BoxFit.fitHeight),
          // Positioned(
          //     top: -2.0,
          //     left: 10.0,
          //     child: FavoriteButton(productId: productModel.id)),
        ],
      ),
    );
  }

  Widget _buildOfferInPercentage() {
    if (productModel.offerPrice.toString().isEmpty) {
      return const Positioned(
        top: 8,
        right: 8,
        child: SizedBox(),
      );
    }

    final percentage = Utils.dorpPricePercentage(
        productModel.price.toString(), productModel.offerPrice.toString());

    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        height: 22,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: lightningYellowColor.withOpacity(0.6),
            borderRadius:
                const BorderRadius.only(topRight: Radius.circular(2))),
        child: Text(
          percentage,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: blackColor,
          ),
        ),
      ),
    );
  }

  Widget addToCartButton(BuildContext context) {
    return SizedBox(
      height: 38.0,
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {
            final AddToCartModel addToCart = AddToCartModel(
              quantity: 1,
              productId: productModel.id,
              image: productModel.thumbImage,
              slug: productModel.slug,
              token: "",
              variantItems: variantItems,
            );
            context.read<AddToCartCubit>().addToCart(addToCart);
          },
          child: Container(
            width: 40.0,
            height: 36.0,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 3.0),
            decoration: const BoxDecoration(
                // color: Utils.dynamicPrimaryColor(context).withOpacity(0.2),
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              bottomRight: Radius.circular(4.0),
            )),
            child: Icon(
              Icons.add,
              color: Utils.dynamicPrimaryColor(context),
              size: 30.0,
            ),
          ),
        ),
      ),
    );
  }
}
