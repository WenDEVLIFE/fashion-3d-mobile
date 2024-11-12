import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/modules/cart/controllers/cart/add_to_cart/add_to_cart_cubit.dart';
import '/modules/cart/model/add_to_cart_model.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/favorite_button.dart';
import '../../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../../home/model/product_model.dart';
import '../../product_details/model/product_variant_model.dart';
import '../../setting/model/website_setup_model.dart';
import 'price_card_widget.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productModel;
  final double? width;

  ProductCard({
    super.key,
    required this.productModel,
    this.width,
  });

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
    // return Column(
    //   mainAxisSize: MainAxisSize.min,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Container(
    //       width: width,
    //       height: singleProductHeight,
    //       margin: Utils.only(bottom: 10.0),
    //       decoration: const BoxDecoration(
    //         color: cardBgColor,
    //         // color: white,
    //         //  borderRadius: BorderRadius.circular(5.0),
    //         // border: borderSide,
    //       ),
    //       child: Stack(
    //         //mainAxisSize: MainAxisSize.min,
    //         fit: StackFit.expand,
    //         children: [
    //           GestureDetector(
    //             onTap: () => Navigator.pushNamed(
    //                 context, RouteNames.productDetailsScreen,
    //                 arguments: productModel.slug),
    //             child: SizedBox(
    //               //height: 235.0,
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 //mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   _buildImage(),
    //                   //const SizedBox(height: 8),
    //                   // _buildContent(appSetting),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //               bottom: 0.0, right: 0.0, child: addToCartButton(context)),
    //         ],
    //       ),
    //     ),
    //     Flexible(fit: FlexFit.loose, child: _buildContent(appSetting)),
    //   ],
    // );
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
            width: 45.0,
            height: 45.0,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 3.0),
            decoration: const BoxDecoration(
                //color: Utils.dynamicPrimaryColor(context).withOpacity(0.3),
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

  Widget _buildContent(AppSettingCubit appSetting) {
    double flashPrice = 0.0;
    double offerPrice = 0.0;
    double mainPrice = 0.0;
    final isFlashSale = appSetting.settingModel!.flashSaleProducts
        .contains(FlashSaleProductsModel(productId: productModel.id));

    if (productModel.offerPrice.toString().isNotEmpty) {
      if (productModel.productVariants.isNotEmpty) {
        double p = 0.0;
        for (var i in productModel.productVariants) {
          if (i.activeVariantsItems.isNotEmpty) {
            p += Utils.toDouble(i.activeVariantsItems.first.price.toString());
          }
        }
        offerPrice = p + productModel.offerPrice;
      } else {
        offerPrice = productModel.offerPrice;
      }
    }
    if (productModel.productVariants.isNotEmpty) {
      double p = 0.0;
      for (var i in productModel.productVariants) {
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
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     // const Icon(
          //     //   Icons.star,
          //     //   size: 14,
          //     //   color: Color(0xffF6D060),
          //     // ),
          //     // const SizedBox(width: 5),
          //     Text(
          //       productModel.rating.toStringAsFixed(1),
          //       style: headlineTextStyle(12.0),
          //     ),
          //     //CustomRatingBar(count: 5, initial: productModel.rating),
          //   ],
          // ),
          // const SizedBox(height: 4),
          AutoSizeText(
            productModel.name,
            textAlign: TextAlign.left,
            maxLines: 1,
            maxFontSize: 12,
            minFontSize: 12,
            overflow: TextOverflow.ellipsis,
            style: headlineTextStyle(12.0),
          ),
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
        ],
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      height: 180.0,
      //\width: double.infinity,
      // alignment: Alignment.center,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CustomImage(
            path: RemoteUrls.imageUrl(productModel.thumbImage),
            fit: BoxFit.fitHeight,
          ),
          // Positioned(
          //     left: 10.0,
          //     top: -50.0,
          //     child: FavoriteButton(productId: productModel.id))
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
}
