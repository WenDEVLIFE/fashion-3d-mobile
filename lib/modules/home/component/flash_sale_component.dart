import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:google_fonts/google_fonts.dart';

import '/core/router_name.dart';
import '/widgets/capitalized_word.dart';
import '../../../core/remote_urls.dart';
import '../../../utils/constants.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../../category/component/price_card_widget.dart';
import '../../category/component/product_card.dart';
import '../../flash/controller/cubit/flash_cubit.dart';
import '../../flash/model/flash_model.dart';
import '../../setting/model/website_setup_model.dart';
import '../model/flash_sale_model.dart';
import '../model/product_model.dart';

class FlashSaleComponent extends StatelessWidget {
  const FlashSaleComponent({
    super.key,
    required this.flashSale,
  });

  final FlashSaleModel flashSale;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FlashCubit>();
    cubit.getFalshSale();
    if (cubit.flashModel == null) {
      cubit.getFalshSale();
    }
    if (cubit.flashModel!.products.isNotEmpty) {
      print('flash-product ${cubit.flashModel!.products.length}');
    }

    int endTime =
        DateTime.parse(flashSale.endTime).millisecondsSinceEpoch + 1000 * 30;
    // DateTime.now().millisecondsSinceEpoch + 1000 * 30;
    if (cubit.flashModel!.products.isNotEmpty) {
      return Container(
        height: 400.0,
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFBD7E9),
              Color(0xFFFFD7AB),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Language.saleOver.capitalizeByWord(),
                    style: headlineTextStyle(16.0),
                  ),
                  CountdownTimer(
                    endTime: endTime,
                    widgetBuilder: (_, time) {
                      if (time == null) {
                        return Text(
                          Language.saleOver.capitalizeByWord(),
                          style: headlineTextStyle(16.0),
                        );
                      }
                      return Row(
                        children: [
                          _MyCircularProgressCustomValue(
                            maxValue: time.days! + 10,
                            title: Language.days.capitalizeByWord(),
                            value: time.days!,
                            key: UniqueKey(),
                            color: const Color(0xffEB5757),
                          ),
                          const SizedBox(width: 14.0),
                          _MyCircularProgressCustomValue(
                            maxValue: 24,
                            title: 'Hrs',
                            value: time.hours!,
                            key: UniqueKey(),
                            color: const Color(0xff2F80ED),
                          ),
                          const SizedBox(width: 14.0),
                          _MyCircularProgressCustomValue(
                            maxValue: 60,
                            title: 'Min',
                            value: time.min!,
                            key: UniqueKey(),
                            color: const Color(0xff219653),
                          ),
                          const SizedBox(width: 14.0),
                          _MyCircularProgressCustomValue(
                            maxValue: 60,
                            title: 'Sec',
                            value: time.sec!,
                            key: UniqueKey(),
                            color: const Color(0xffEB5757),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
            BlocConsumer<FlashCubit, FlashState>(
              listener: (context, state) {
                if (state is FlashSaleError) {
                  if (state.statusCode == 503) {
                    context.read<FlashCubit>().getFalshSale();
                  }
                }
              },
              builder: (context, state) {
                if (state is FlashSaleLoading) {
                  //return const Center(child: CircularProgressIndicator());
                } else if (state is FlashSaleError) {
                  return Center(child: Text(state.errorMessage));
                } else if (state is FlashSaleLoaded) {
                  // return FlashLoadedProduct(flashModel: state.flashModel);
                  return loadedFlash(state.flashModel.products, context);
                }
                return const SizedBox();
              },
            )
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget loadedFlash(List<ProductModel> productModel, BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              productModel.length > 2 ? 4 : productModel.length,
              (index) => Container(
                margin:
                    EdgeInsets.only(left: index == 0 ? 10.0 : 0.0, right: 14.0),
                child: ProductCard(
                    width: 170.0, productModel: productModel[index]),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5.0),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteNames.flashScreen);
          },
          child: Text(
            Language.seeAll.capitalizeByWord(),
            style: headlineTextStyle(16.0),
          ),
        ),
      ],
    );
  }

  Widget shopNowButton(BuildContext context) {
    return GestureDetector(
      onTap: () => debugPrint('Print Show Now....'),
      child: Container(
        height: 30.0,
        width: 80.0,
        padding: const EdgeInsets.only(bottom: 4.0),
        decoration: BoxDecoration(
          color: Utils.dynamicPrimaryColor(context),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Shop Now',
              style: simpleTextStyle(white).copyWith(fontSize: 11.0),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(
                Icons.arrow_forward_ios,
                color: white,
                size: 14.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _MyCircularProgressCustomValue extends StatelessWidget {
  const _MyCircularProgressCustomValue({
    super.key,
    required this.value,
    required this.title,
    required this.maxValue,
    required this.color,
  }) : assert(maxValue > value, "maxValue must be greter then value");
  final int value;
  final String title;
  final int maxValue;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // double percent = 1 - (value / maxValue);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "$value",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                height: 1,
                color: color),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1,
              color: Colors.black),
        ),
      ],
    );
  }
}

class FlashLoadedProduct extends StatelessWidget {
  const FlashLoadedProduct({super.key, required this.flashModel});

  final FlashModel flashModel;

  @override
  Widget build(BuildContext context) {
    final appSetting = context.read<AppSettingCubit>();
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              flashModel.products.length > 4 ? 4 : flashModel.products.length,
              (index) {
                final product = flashModel.products[index];
                return Container(
                  height: 174.0,
                  width: 115.0,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: const Color.fromRGBO(174, 28, 154, 0.14),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildImage(product),
                      _buildContent(appSetting, flashModel.products[index])
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteNames.flashScreen);
            },
            child: const Text('See All'))
      ],
    );
  }

  Widget buildImage(ProductModel product) {
    return Container(
      height: 90.0,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
      // color: Colors.red,
      alignment: Alignment.center,
      child: CustomImage(
        path: RemoteUrls.imageUrl(product.thumbImage),
      ),
    );
  }

  Widget _buildContent(AppSettingCubit appSetting, ProductModel productModel) {
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

    return Column(
      children: [
        Row(
          children: [
            ...List.generate(
              1,
              (index) => const Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Icon(
                  Icons.star,
                  size: 18.0,
                  color: Colors.yellow,
                ),
              ),
            ),
            const SizedBox(width: 5.0),
            Text(productModel.rating.toStringAsFixed(1)),
          ],
        ),
        Text(
          productModel.name,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.jost(
              fontWeight: FontWeight.w700, fontSize: 10.0, color: blackColor),
        ),
        Row(
          children: [
            /* Text(
              '\$${productModel.offerPrice}',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
                color: const Color(0xFF8E8E8E),
                decoration: TextDecoration.lineThrough,
              ),
            ),*/
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
            ]
            // Text(
            //   '\$${productModel.price}',
            //   style: GoogleFonts.poppins(
            //       fontWeight: FontWeight.w500,
            //       fontSize: 20.0,
            //       color: Utils.dynamicPrimaryColor(context),
            // ),
          ],
        ),
      ],
    );
  }
}
