import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '/modules/animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '/modules/category/component/price_card_widget.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/favorite_button.dart';
import '../../home/model/product_model.dart';
import '../../setting/model/website_setup_model.dart';

class PopularProductCard extends StatelessWidget {
  final ProductModel productModel;

  const PopularProductCard({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    final appSetting = context.read<AppSettingCubit>();
    const double height = 125;
    return InkWell(
      onTap: () => Navigator.pushNamed(context, RouteNames.productDetailsScreen,
          arguments: productModel.slug),
      child: Container(
        height: height,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          color: white,
          //borderRadius: BorderRadius.circular(4),
          //border: borderColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(height),
            const SizedBox(width: 14),
            _buildContent(appSetting),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(double height) {
    return Container(
      margin: Utils.all(value: 8.0),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: Utils.borderRadius(r: 6.0),
        //border: Border(right: BorderSide(color: borderColor)),
      ),
      height: height,
      width: height,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(4)),
            child:
                CustomImage(path: RemoteUrls.imageUrl(productModel.thumbImage)),
          ),
          Positioned(
            top: 5.0,
            left: 5.0,
            child: FavoriteButton(productId: productModel.id),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    AppSettingCubit appSetting,
  ) {
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

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RatingBar.builder(
              initialRating: productModel.rating,
              minRating: 3,
              direction: Axis.horizontal,
              allowHalfRating: true,
              ignoreGestures: true,
              itemCount: 5,
              itemSize: 14,
              glow: true,
              glowColor: lightningYellowColor,
              tapOnlyMode: true,
              itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Color(0xffF6D060),
              ),
              onRatingUpdate: (rating) {},
            ),
            const SizedBox(height: 10),
            Text(
              productModel.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (isFlashSale) ...[
                  PriceCardWidget(
                    price: mainPrice.toString(),
                    offerPrice: flashPrice.toString(),
                    textSize: 16,
                  )
                ] else ...[
                  PriceCardWidget(
                    price: mainPrice.toString(),
                    offerPrice: offerPrice.toString(),
                    textSize: 16,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
