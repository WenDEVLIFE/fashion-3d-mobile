import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shop_us/widgets/capitalized_word.dart';
import 'package:shop_us/widgets/favorite_button.dart';

import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../../cart/controllers/cart/add_to_cart/add_to_cart_cubit.dart';
import '../../cart/model/add_to_cart_model.dart';
import '../../category/component/price_card_widget.dart';
import '../../product_details/model/product_variant_model.dart';
import '../../setting/model/website_setup_model.dart';
import '../model/product_model.dart';

class HomeHorizontalListProductCard extends StatelessWidget {
  final ProductModel productModel;

  HomeHorizontalListProductCard({
    super.key,
    this.height = 100,
    this.width = 215,
    required this.productModel,
  });
  final double height, width;

  final Set<ActiveVariantModel> variantItems = {};

  @override
  Widget build(BuildContext context) {
    final appSetting = context.read<AppSettingCubit>();
    double flashPrice = 0.0;
    double offerPrice = 0.0;
    double mainPrice = 0.0;
    final isFlashSale = appSetting.settingModel!.flashSaleProducts
        .contains(FlashSaleProductsModel(productId: productModel.id));

    if (productModel.offerPrice.toString().isNotEmpty) {
      double p = 0.0;
      if (productModel.productVariants.isNotEmpty) {
        for (var i in productModel.productVariants) {
          if (i.activeVariantsItems.isNotEmpty) {
            p += Utils.toDouble(i.activeVariantsItems.first.price.toString());
          }
        }
        offerPrice = p + double.parse(productModel.offerPrice.toString());
      } else {
        offerPrice = double.parse(productModel.offerPrice.toString());
      }
    }
    if (productModel.productVariants.isNotEmpty) {
      double p = 0.0;
      for (var i in productModel.productVariants) {
        if (i.activeVariantsItems.isNotEmpty) {
          p += Utils.toDouble(i.activeVariantsItems.first.price.toString());
        }
      }
      mainPrice = p + double.parse(productModel.price.toString());
    } else {
      mainPrice = double.parse(productModel.price.toString());
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
      height: height,
      width: width,
      margin: const EdgeInsets.only(right: 8),
      decoration: const BoxDecoration(
        color: white,
        //border: borderSide,
        //borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteNames.productDetailsScreen,
              arguments: productModel.slug);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                children: [
                  const SizedBox(height: 30.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          initialRating: productModel.rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          ignoreGestures: true,
                          itemCount: 5,
                          itemSize: 14,
                          glow: true,
                          // glowColor: lightningYellowColor,
                          tapOnlyMode: true,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 0.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        const SizedBox(height: 6.0),
                        AutoSizeText(
                          productModel.name.capitalizeByWord(),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          maxFontSize: 16,
                          minFontSize: 12,
                          overflow: TextOverflow.ellipsis,
                          style: headlineTextStyle(16.0),
                        ),
                        const SizedBox(height: 6.0),
                        if (isFlashSale) ...[
                          PriceCardWidget(
                            price: mainPrice.toString(),
                            offerPrice: flashPrice.toString(),
                          ),
                        ] else ...[
                          PriceCardWidget(
                            price: mainPrice.toString(),
                            offerPrice: offerPrice.toString(),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Spacer(),
                  addToCartButton(context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      margin: const EdgeInsets.all(12.0).copyWith(right: 4.0),
      decoration: BoxDecoration(
          color: cardBgColor, borderRadius: Utils.borderRadius(r: 6.0)),
      height: height - 2,
      width: width / 2.5,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            CustomImage(
              path: RemoteUrls.imageUrl(productModel.thumbImage),
              fit: BoxFit.fitHeight,
            ),
            Positioned(
                left: -14.0,
                top: -12.0,
                child: FavoriteButton(productId: productModel.id)),
          ],
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
