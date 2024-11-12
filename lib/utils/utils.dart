import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '/modules/cart/model/cart_response_model.dart';
import '/widgets/capitalized_word.dart';
import '../modules/animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../modules/cart/model/cart_product_model.dart';
import '../modules/home/model/product_model.dart';
import '../modules/product_details/model/details_product_reviews_model.dart';
import '../modules/setting/model/website_setup_model.dart';
import 'constants.dart';
import 'language_string.dart';

class Utils {
  static final _selectedDate = DateTime.now();

  static final _initialTime = TimeOfDay.now();

  static Size mediaQuery(BuildContext context) => MediaQuery.sizeOf(context);

  static Widget verticalSpace(double size) {
    return SizedBox(height: size.h);
  }

  static Widget horizontalSpace(double size) {
    return SizedBox(width: size.w);
  }

  static double hSize(double size) {
    return size.w;
  }

  static double vSize(double size) {
    return size.h;
  }

  static EdgeInsets symmetric({double h = 20.0, v = 0.0}) {
    return EdgeInsets.symmetric(
        horizontal: Utils.hPadding(size: h), vertical: Utils.vPadding(size: v));
  }

  static double radius(double radius) {
    return radius.sp;
  }

  static BorderRadius borderRadius({double r = 10.0}) {
    return BorderRadius.circular(Utils.radius(r));
  }

  static EdgeInsets all({double value = 0.0}) {
    return EdgeInsets.all(value.dm);
  }

  static double vPadding({double size = 20.0}) {
    return size.h;
  }

  static double hPadding({double size = 20.0}) {
    return size.w;
  }

  static EdgeInsets only({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return EdgeInsets.only(
        left: left.w, top: top.h, right: right.w, bottom: bottom.h);
  }

  // final icon =  BlocProvider.of<AppSettingCubit>(_).settingModel!.setting!.currencyIcon;

  static String formatPrice(var price, BuildContext context) {
    final icon =
        context.read<AppSettingCubit>().settingModel!.setting!.currencyIcon;
    if (price is double) return '$icon${price.toStringAsFixed(1)}';
    if (price is String) {
      final p = double.tryParse(price) ?? 0.0;
      return '$icon${p.toStringAsFixed(1)}';
    }
    return price.toStringAsFixed(1);
  }

  static Color dynamicPrimaryColor(BuildContext context) {
    final color = context
        .read<AppSettingCubit>()
        .settingModel!
        .setting!
        .themeOne
        .replaceAll('#', '0xFF');
    return Color(int.parse(color));
    //return const Color(0xFF000000);
  }

  static String formatPriceIcon(var price, BuildContext context) {
    final icon =
        context.read<AppSettingCubit>().settingModel!.setting!.currencyIcon;
    if (price is double) return icon + price.toStringAsFixed(1);
    if (price is String) {
      final p = double.tryParse(price) ?? 0.0;
      return icon + p.toStringAsFixed(1);
    }
    return icon + price.toStringAsFixed(1);
  }

  static double cartProductPrice(
      BuildContext context, CartProductModel cartProductModel) {
    final appSetting = context.read<AppSettingCubit>();
    double productPrice = 0.0;
    double flashPrice = 0.0;
    double offerPrice = 0.0;
    double mainPrice = 0.0;
    final isFlashSale = appSetting.settingModel!.flashSaleProducts.contains(
        FlashSaleProductsModel(productId: cartProductModel.product.id));

    if (cartProductModel.product.offerPrice != 0) {
      if (cartProductModel.variants.isNotEmpty) {
        double p = 0.0;

        for (var i in cartProductModel.variants) {
          print("vItem1: $i");
          if (i.varientItem != null) {
            p += i.varientItem!.price;
          }
        }
        offerPrice = p + cartProductModel.product.offerPrice;
      } else {
        offerPrice = cartProductModel.product.offerPrice;
      }
      productPrice = offerPrice;
    } else {
      if (cartProductModel.variants.isNotEmpty) {
        double p = 0.0;
        for (var i in cartProductModel.variants) {
          print("vItem2: $i");
          if (i.varientItem != null) {
            p += i.varientItem!.price;
          }
        }
        mainPrice = p + cartProductModel.product.price;
      } else {
        mainPrice = cartProductModel.product.price;
      }
      productPrice = mainPrice;
    }

    if (isFlashSale) {
      if (cartProductModel.product.offerPrice != 0) {
        final discount =
            appSetting.settingModel!.flashSale.offer / 100 * offerPrice;

        flashPrice = offerPrice - discount;
      } else {
        final discount =
            appSetting.settingModel!.flashSale.offer / 100 * mainPrice;

        flashPrice = mainPrice - discount;
      }
      productPrice = flashPrice;
    }
    return productPrice;
  }

  // static double cartProductPrice(
  //     BuildContext context, CartProductModel cartProductModel) {
  //   final appSetting = context.read<AppSettingCubit>();
  //   double productPrice = 0.0;
  //   double flashPrice = 0.0;
  //   double offerPrice = 0.0;
  //   double mainPrice = 0.0;
  //   final isFlashSale = appSetting.settingModel!.flashSaleProducts.contains(
  //       FlashSaleProductsModel(productId: cartProductModel.product.id));
  //
  //   if (cartProductModel.product.offerPrice.toString().isNotEmpty) {
  //     if (cartProductModel.variants.isNotEmpty) {
  //       double p = 0.0;
  //       for (var i in cartProductModel.variants) {
  //         p += Utils.toDouble(i.varientItem!.price.toString());
  //       }
  //       offerPrice =
  //           p + double.parse(cartProductModel.product.offerPrice.toString());
  //     } else {
  //       offerPrice =
  //           double.parse(cartProductModel.product.offerPrice.toString());
  //     }
  //     productPrice = offerPrice;
  //   } else {
  //     if (cartProductModel.variants.isNotEmpty) {
  //       double p = 0.0;
  //       for (var i in cartProductModel.variants) {
  //         p += Utils.toDouble(i.varientItem!.price.toString());
  //       }
  //       mainPrice = p + double.parse(cartProductModel.product.price.toString());
  //     } else {
  //       mainPrice = double.parse(cartProductModel.product.price.toString());
  //     }
  //     productPrice = mainPrice;
  //   }
  //
  //   if (isFlashSale) {
  //     if (cartProductModel.product.offerPrice.toString().isNotEmpty) {
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
  //     productPrice = flashPrice;
  //   }
  //   return productPrice;
  // }

  static String calculatePrice(CartResponseModel cartResponseModel) {
    double price = 0.0;
    for (var i = 0; i < cartResponseModel.cartProducts.length; i++) {
      if (cartResponseModel.cartProducts[i].product.offerPrice
          .toString()
          .isNotEmpty) {
        final p = double.parse(
            cartResponseModel.cartProducts[i].product.offerPrice.toString());
        final q = double.parse(
            cartResponseModel.cartProducts[i].product.qty.toString());
        price = p * q;
      } else {
        final p = double.parse(
            cartResponseModel.cartProducts[i].product.price.toString());
        final q = double.parse(
            cartResponseModel.cartProducts[i].product.qty.toString());
        price = p * q;
      }
    }
    String price0 = price.toStringAsPrecision(2);
    debugPrint("Price: $price0");

    return "\$$price0";
  }

  ///Added below lines
  static double productPrice(BuildContext context, ProductModel product) {
    final appSetting = context.read<AppSettingCubit>();
    double productPrice = 0.0;
    double flashPrice = 0.0;
    double offerPrice = 0.0;
    double mainPrice = 0.0;
    final isFlashSale = appSetting.settingModel!.flashSaleProducts
        .contains(FlashSaleProductsModel(productId: product.id));

    if (product.offerPrice.toString().isNotEmpty) {
      if (product.productVariants.isNotEmpty) {
        double p = 0.0;
        for (var i in product.productVariants) {
          if (i.activeVariantsItems.isNotEmpty) {
            p += Utils.toDouble(i.activeVariantsItems.first.price.toString());
          }
        }
        offerPrice = p + double.parse(product.offerPrice.toString());
      } else {
        offerPrice = double.parse(product.offerPrice.toString());
      }
      productPrice = offerPrice;
    } else {
      if (product.productVariants.isNotEmpty) {
        double p = 0.0;
        for (var i in product.productVariants) {
          if (i.activeVariantsItems.isNotEmpty) {
            p += Utils.toDouble(i.activeVariantsItems.first.price.toString());
          }
        }
        mainPrice = p + double.parse(product.price.toString());
      } else {
        mainPrice = double.parse(product.price.toString());
      }
      productPrice = mainPrice;
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
      productPrice = flashPrice;
    }
    return productPrice;
  }

  ///Added above lines
  static String formatDate(var date) {
    late DateTime dateTime;
    if (date is String) {
      dateTime = DateTime.parse(date);
    } else {
      dateTime = date;
    }

    return DateFormat.yMd().format(dateTime.toLocal());
  }

  static String numberCompact(num number) =>
      NumberFormat.compact().format(number);

  static String timeAgo(String? time) {
    try {
      if (time == null) return '';
      return timeago.format(DateTime.parse(time));
    } catch (e) {
      return '';
    }
  }

  static double toDouble(String? number) {
    try {
      if (number == null) return 0;
      return double.tryParse(number) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  static String dorpPricePercentage(String priceS, String offerPriceS) {
    double price = Utils.toDouble(priceS);
    double offerPrice = Utils.toDouble(offerPriceS);
    double dropPrice = (price - offerPrice) * 100;

    double percentage = dropPrice / price;
    return "-${percentage.toStringAsFixed(1)}%";
  }

  static double toInt(String? number) {
    try {
      if (number == null) return 0;
      return double.tryParse(number) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  static Future<DateTime?> selectDate(BuildContext context) => showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1990, 1),
        lastDate: DateTime(2050),
      );

  static Future<TimeOfDay?> selectTime(BuildContext context) =>
      showTimePicker(context: context, initialTime: _initialTime);

  static loadingDialog(
    BuildContext context, {
    bool barrierDismissible = false,
  }) {
    // closeDialog(context);
    showCustomDialog(
      context,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(20),
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 15),
            Text(Language.pleaseWaitAMoment.capitalizeByWord())
          ],
        )),
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static Future showCustomDialog(BuildContext context,
      {Widget? child, bool barrierDismissible = false, double padding = 40.0}) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          //insetPadding: Utils.symmetric(h: padding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        );
      },
    );
  }

  static void appInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            Language.appInfo.capitalizeByWord(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoLabel(
                  label: Language.name.capitalizeByWord(),
                  text: Language.ecoShop.capitalizeByWord()),
              const SizedBox(height: 6),
              InfoLabel(
                  label: Language.version.capitalizeByWord(), text: "1.0.0"),
              const SizedBox(height: 6),
              InfoLabel(
                  label: Language.developedBy.capitalizeByWord(),
                  text: "QuomodoSoft"),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(Language.dismiss.capitalizeByWord()))
          ],
        );
      },
    );
  }

  static void serviceUnAvailable(BuildContext context, String msg,
      [Color textColor = Colors.white]) {
    final snackBar = SnackBar(
        backgroundColor: redColor,
        duration: const Duration(milliseconds: 500),
        content: Text(msg, style: TextStyle(color: textColor)));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static int calCulateMaxDays(String startDate, String endDate) {
    final startDateTime = DateTime.parse(startDate);
    final endDateTime = DateTime.parse(endDate);
    final totalDays = endDateTime.difference(startDateTime).inDays;

    return totalDays >= 0 ? totalDays : 0;
  }

  static int calCulateRemainingHours(String startDate, String endDate) {
    final startDateTime =
        DateTime.now().toLocal().subtract(const Duration(days: 9));
    final endDateTime = DateTime.parse(endDate).toLocal();
    final totalHours = endDateTime.difference(startDateTime).inHours;

    if (totalHours < 0) return 24;

    return 24 - (totalHours % 24);
  }

  static int calCulateRemainingMinutes(String startDate, String endDate) {
    final startDateTime = DateTime.now().toLocal();
    final endDateTime = DateTime.parse(endDate).toLocal();
    final totalMinutes = endDateTime.difference(startDateTime).inMinutes;

    if (totalMinutes < 0) return 60;

    return 60 - (totalMinutes % (24 * 60));
  }

  static int calCulateRemainingDays(String startDate, String endDate) {
    final endDateTime = DateTime.parse(endDate).toLocal();
    final totalDaysGone =
        endDateTime.difference(DateTime.now().toLocal()).inDays;
    final totalDays = calCulateMaxDays(startDate, endDate);
    return totalDaysGone >= 0 ? totalDays - totalDaysGone : totalDays;
  }

  /// Checks if string is a valid username.
  static bool isUsername(String s) =>
      hasMatch(s, r'^[a-zA-Z0-9][a-zA-Z0-9_.]+[a-zA-Z0-9]$');

  /// Checks if string is Currency.
  static bool isCurrency(String s) => hasMatch(s,
      r'^(S?\$|\₩|Rp|\¥|\€|\₹|\₽|fr|R\$|R)?[ ]?[-]?([0-9]{1,3}[,.]([0-9]{3}[,.])*[0-9]{3}|[0-9]+)([,.][0-9]{1,2})?( ?(USD?|AUD|NZD|CAD|CHF|GBP|CNY|EUR|JPY|IDR|MXN|NOK|KRW|TRY|INR|RUB|BRL|ZAR|SGD|MYR))?$');

  /// Checks if string is phone number.
  static bool isPhoneNumber(String s) {
    if (s.length > 16 || s.length < 9) return false;
    return hasMatch(s, r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  }

  /// Checks if string is email.
  static bool isEmail(String s) => hasMatch(s,
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  static bool isEmpty(dynamic value) {
    if (value is String) {
      return value.toString().trim().isEmpty;
    }
    if (value is Iterable || value is Map) {
      return value.isEmpty ?? false;
    }
    return false;
  }

  static void errorSnackBar(BuildContext context, String errorMsg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(errorMsg, style: const TextStyle(color: redColor)),
        ),
      );
  }

  static void showSnackBar(BuildContext context, String msg,
      [Color textColor = white]) {
    final snackBar =
        SnackBar(content: Text(msg, style: TextStyle(color: textColor)));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showSnackBarWithAction(
      BuildContext context, String msg, VoidCallback onPress,
      [Color textColor = white]) {
    final snackBar = SnackBar(
      content: Text(msg, style: TextStyle(color: textColor)),
      action: SnackBarAction(
        label: Language.active.capitalizeByWord(),
        onPressed: onPress,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static double getRating(List<DetailsProductReviewModel> productReviews) {
    if (productReviews.isEmpty) return 0;

    double rating = productReviews.fold(
        0.0,
        (previousValue, element) =>
            previousValue + Utils.toDouble(element.rating.toString()));
    rating = rating / productReviews.length;
    return rating;
  }

  static bool _isDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  static void closeDialog(BuildContext context) {
    if (_isDialogShowing(context)) {
      Navigator.pop(context);
    }
  }

  static void closeKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<String?> pickSingleImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image.path;
    }
    return null;
  }

  static String orderStatus(String orderStatus) {
    switch (orderStatus) {
      case '0':
        return Language.pending.capitalizeByWord();
      case '1':
        return Language.progress.capitalizeByWord();
      case '2':
        return Language.delivered.capitalizeByWord();
      case '3':
        return Language.completed.capitalizeByWord();
      // case '4':
      //   return 'Declined';
      default:
        return Language.declined.capitalizeByWord();
    }
  }
}

class InfoLabel extends StatelessWidget {
  const InfoLabel({
    super.key,
    this.label,
    this.text,
  });

  final String? label;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
        text: "${label!} : ",
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(
            text: text!,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ]));
  }
}
