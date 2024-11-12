import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_us/utils/language_string.dart';
import 'package:shop_us/widgets/capitalized_word.dart';

import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../../cart/controllers/cart/add_to_cart/add_to_cart_cubit.dart';
import '../../cart/model/add_to_cart_model.dart';
import '../../home/model/product_model.dart';
import '../../setting/model/website_setup_model.dart';
import '../model/product_details_product_model.dart';
import '../model/product_variant_model.dart';
import '../model/variant_items_model.dart';
import 'bottom_seet_product.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key, required this.product});

  final ProductDetailsProductModel product;

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  Set<ActiveVariantModel> variantItems = {};

  int quantity = 1;

  @override
  void initState() {
    super.initState();
    _variantsInit();
  }

  void _variantsInit() {
    for (var element in widget.product.activeVariantModel) {
      final item = element.activeVariantsItems.first;
      variantItems.add(element.copyWith(activeVariantsItems: [item]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetProduct(
            product: ProductModel.fromMap(
              widget.product.toMap(),
            ),
            variantItem: variantItems,
          ),
          Container(
            color: borderColor,
            height: 1,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 15),
          ),
          _VarientItemsWidget(
            productVariants: widget.product.activeVariantModel,
            variantItems: variantItems,
            onChange: (item) {
              setState(() {
                // Update your logic here
                for (var element in variantItems.toList()) {
                  if (element.id == item.id) {
                    variantItems.remove(element);
                  }
                }
                variantItems.add(item);
              });
            },
          ),

          // _VarientItemsWidget(
          //   productVariants: widget.product.activeVariantModel,
          //   variantItems: variantItems,
          //   onChange: (item) {
          //     setState(() {
          //       for (var element in variantItems.toList()) {
          //         if (element.id == item.id) {
          //           variantItems.remove(element);
          //           print('Element Id: ${element.name}');
          //           print('Item Id: ${item.name}');
          //         }
          //       }
          //       variantItems.add(item);
          //     });
          //   },
          // ),
          const SizedBox(height: 10),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  Language.quantity.capitalizeByWord(),
                  style: const TextStyle(
                      fontSize: 18, color: white, fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                onTap: () {
                  if (quantity > 1) {
                    quantity--;
                    setState(() {});
                  }
                },
                child: CircleAvatar(
                  radius: 12,
                  foregroundColor: transparent,
                  backgroundColor: white,
                  child: Icon(
                    Icons.remove,
                    color: Utils.dynamicPrimaryColor(context),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: Text(
                  quantity.toString(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600, color: white),
                ),
              ),
              InkWell(
                onTap: () {
                  quantity++;
                  setState(() {});
                },
                child: CircleAvatar(
                  radius: 12,
                  foregroundColor: transparent,
                  backgroundColor: white,
                  child: Icon(Icons.add,
                      color: Utils.dynamicPrimaryColor(context)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                "${Language.totalPrice.capitalizeByWord()} : ${totalPrice()}",
                style: const TextStyle(color: redColor),
              ),
            ],
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              final dataModel = AddToCartModel(
                image: widget.product.thumbImage,
                productId: widget.product.id,
                slug: widget.product.slug,
                quantity: quantity,
                token: '',
                variantItems: variantItems,
              );
              context.read<AddToCartCubit>().addToCart(dataModel);
            },
            child: Container(
              width: double.infinity,
              height: 50.0,
              padding: const EdgeInsets.only(bottom: 6.0),
              decoration: BoxDecoration(
                  color: Utils.dynamicPrimaryColor(context),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0, right: 6.0),
                    child: Icon(Icons.add, color: white, size: 30.0),
                  ),
                  Text(
                    Language.addToCart.capitalizeByWord(),
                    style: simpleTextStyle(white).copyWith(
                        fontSize: 18.0,
                        color: white,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*String totalPrice() {
    double price;
    if(widget.product.offerPrice.isNotEmpty){
      price = Utils.toDouble(widget.product.offerPrice) * quantity;
    }else{
      price = Utils.toDouble(widget.product.price) * quantity;

    }


    for (var element in variantItems) {
      if (element.variantItems.isNotEmpty) {
        price += Utils.toDouble(element.variantItems.first.price);
      }
    }
    return Utils.formatPrice(price);
  }*/

  // String totalPrice() {
  //   final appSetting = context.read<AppSettingCubit>();
  //   double flashPrice = 0.0;
  //   double offerPrice = 0.0;
  //   double mainPrice = 0.0;
  //   double price;
  //   final isFlashSale = appSetting.settingModel!.flashSaleProducts
  //       .contains(FlashSaleProductsModel(productId: widget.product.id));
  //   if (widget.product.offerPrice.toString().isNotEmpty) {
  //     if (widget.product.activeVariantModel.isNotEmpty) {
  //       double p = 0.0;
  //       for (var i in widget.product.activeVariantModel) {
  //         if (i.activeVariantsItems.isNotEmpty) {
  //           // p += Utils.toDouble(i.activeVariantsItems.first.price);
  //         }
  //       }
  //       offerPrice = p + widget.product.offerPrice;
  //     } else {
  //       offerPrice = widget.product.offerPrice;
  //     }
  //   }
  //   if (widget.product.activeVariantModel.isNotEmpty) {
  //     double p = 0.0;
  //     for (var i in widget.product.activeVariantModel) {
  //       if (i.activeVariantsItems.isNotEmpty) {
  //         // p += Utils.toDouble(i.activeVariantsItems.first.price);
  //       }
  //     }
  //     mainPrice = p + widget.product.price;
  //   } else {
  //     mainPrice = widget.product.price;
  //   }
  //   if (isFlashSale) {
  //     if (widget.product.offerPrice.toString().isNotEmpty) {
  //       final discount =
  //           appSetting.settingModel!.flashSale.offer / 100 * offerPrice;
  //
  //       flashPrice = offerPrice - discount;
  //     } else {
  //       final discount =
  //           appSetting.settingModel!.flashSale.offer / 100 * mainPrice;
  //
  //       flashPrice = mainPrice - discount;
  //     }
  //     price = Utils.toDouble(flashPrice.toString()) * quantity;
  //   } else {
  //     if (widget.product.offerPrice.toString().isNotEmpty) {
  //       price = Utils.toDouble(offerPrice.toString()) * quantity;
  //     } else {
  //       price = Utils.toDouble(mainPrice.toString()) * quantity;
  //     }
  //   }
  //
  //   for (var element in variantItems) {
  //     if (element.activeVariantsItems.isNotEmpty) {
  //       price +=
  //           Utils.toDouble(element.activeVariantsItems.first.price.toString());
  //     }
  //   }
  //   return Utils.formatPrice(price, context);
  // }
  String totalPrice() {
    final appSetting = context.read<AppSettingCubit>();
    double price;
    double flashPrice = 0.0;
    double offerPrice = widget.product.offerPrice;
    double mainPrice = widget.product.price;

    final isFlashSale = appSetting.settingModel!.flashSaleProducts
        .contains(FlashSaleProductsModel(productId: widget.product.id));

    // Calculate the price based on the flash sale status
    if (isFlashSale) {
      final discount = appSetting.settingModel!.flashSale.offer / 100 * (offerPrice > 0 ? offerPrice : mainPrice);
      flashPrice = (offerPrice > 0 ? offerPrice : mainPrice) - discount;
      price = flashPrice;
    } else {
      // If offer price is 0, use the main price
      price = (offerPrice > 0 ? offerPrice : mainPrice);
    }

    // Update the price based on selected variant items
    for (var element in variantItems) {
      if (element.activeVariantsItems.isNotEmpty) {
        price += Utils.toDouble(element.activeVariantsItems.first.price.toString());
      }
    }

    // Calculate the final price based on quantity
    price *= quantity;

    return Utils.formatPrice(price, context);
  }


}

class _VarientItemsWidget extends StatelessWidget {
  const _VarientItemsWidget({
    required this.productVariants,
    required this.variantItems,
    required this.onChange,
  });

  final List<ActiveVariantModel> productVariants;
  final Set<ActiveVariantModel> variantItems;

  final ValueChanged<ActiveVariantModel> onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: productVariants.map(_buildSIngleVarient).toList(),
    );
  }

  Widget _buildSIngleVarient(ActiveVariantModel singleVarient) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (singleVarient.activeVariantsItems.isNotEmpty) ...[
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                "${singleVarient.name} : ",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 16.0, color: white),
              ),
            ),
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Wrap(
                children: singleVarient.activeVariantsItems.map(
                  (itemModel) {
                    return _buildVarientItemBox(singleVarient, itemModel);
                  },
                ).toList(),
              ),
            )
          ]
        ],
      ),
    );
  }

  Widget _buildVarientItemBox(
    ActiveVariantModel singleVariant,
    ActiveVariantItemModel itemModel,
  ) {
    final varient = singleVariant.copyWith(activeVariantsItems: [itemModel]);
    return InkWell(
      onTap: () => onChange(varient),
      child: Container(
        margin: Utils.symmetric(h: 4.0),
        padding: Utils.symmetric(h: 4.0, v: 4.0),
        decoration: BoxDecoration(
          color: variantItems.contains(varient) ? redColor : null,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: borderColor),
        ),
        child: Text(
          itemModel.name.capitalizeByWord(),
          style: const TextStyle(
            color: white,
            // color: variantItems.contains(varient) ? white : white,
          ),
        ),
      ),
    );
  }
}
