import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '/modules/home/component/home_app_bar.dart';
import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '../../core/router_name.dart';
import '../../dummy_data/all_dummy_data.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/rounded_app_bar.dart';
import '../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../profile/controllers/address/address_cubit.dart';
import '../profile/model/address_model.dart';
import 'component/address_card_component.dart';
import 'component/checkout_single_item.dart';
import 'component/shiping_method_list.dart';
import 'controllers/cart/cart_cubit.dart';
import 'controllers/checkout/checkout_cubit.dart';
import 'controllers/shipping_charges/shipping_charges_cubit.dart';
import 'model/cart_calculation_model.dart';
import 'model/checkout_response_model.dart';
import 'model/shipping_response_model.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  CartCalculation? cartCalculation;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (context.read<CartCubit>().couponResponseModel != null) {
        context.read<CheckoutCubit>().getCheckOutData(
            context.read<CartCubit>().couponResponseModel!.code);
      } else {
        context.read<CheckoutCubit>().getCheckOutData("");
      }
      context.read<AddressCubit>().getAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    final addressCubit = context.read<AddressCubit>();
    print('nullAddress: ${addressCubit.address}');
    if (addressCubit.address == null) {
      log('address re-loaded');
      addressCubit.getAddress();
    }
    return Scaffold(
      backgroundColor: cardBgColor,
      appBar: RoundedAppBar(
          titleText: Language.checkout.capitalizeByWord(),
          bgColor: scaffoldBGColor),
      body: BlocConsumer<CheckoutCubit, CheckoutState>(
        listener: (_, state) {
          //   if (state is CheckoutStateLoading) {
          //     Utils.loadingDialog(context);
          //   } else {
          //     Utils.closeDialog(context);
          //     if (state is CartStateDecIncretError) {
          //       Utils.errorSnackBar(context, state.message);
          //     }
          //   }
        },
        builder: (context, state) {
          if (state is CheckoutStateLoading || state is CheckoutStateInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CheckoutStateError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: redColor),
              ),
            );
          }
          return const _LoadedWidget();
        },
      ),
    );
  }
}

class _LoadedWidget extends StatefulWidget {
  const _LoadedWidget();

  @override
  State<_LoadedWidget> createState() => _LoadedWidgetState();
}

class _LoadedWidgetState extends State<_LoadedWidget> {
  final double height = 140;
  String addressTypeSelect = Language.billingAddress.capitalizeByWord();

  final headerStyle =
      GoogleFonts.inter(fontSize: 18.0, fontWeight: FontWeight.w600);

  CheckoutResponseModel? checkoutResponseModel;
  CartCalculation? cartCalculation;
  PageController pageController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  final body = <String, dynamic>{};
  final shippingMethodList = <ShippingResponseModel>[];

  @override
  void initState() {
    super.initState();
    load();
    if (context.read<CartCubit>().couponResponseModel != null) {
      body['coupon'] = context.read<CartCubit>().couponResponseModel!.code;
    }
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  load() {
    checkoutResponseModel = context.read<CheckoutCubit>().checkoutResponseModel;
    cartCalculation = context.read<CartCubit>().getCartCalculation();

    if (checkoutResponseModel == null) {
      return const SizedBox();
    }
    previousPrice = double.parse(cartCalculation!.total);
  }

  int shippingMethod = 0;
  int agreeTermsCondition = 1;
  int billingAddressId = 0;
  int shippingAddressId = 0;
  double totalPrice = 0.0;
  double previousPrice = 0.0;

  String basedOnWeight = 'base_on_weight';
  String basedOnPrice = 'base_on_price';
  String basedOnQty = 'base_on_qty';

  @override
  Widget build(BuildContext context) {
    context.read<ShippingChargesCubit>().getShippingCharge(previousPrice);
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildProductNumber()),
              _buildProductList(),
              SliverToBoxAdapter(child: _buildLocation()),
              if (shippingMethodList.isNotEmpty)
                SliverToBoxAdapter(
                  child: ShippingMethodList(
                    shippingMethods: shippingMethodList,
                    onChange: (int id) {
                      shippingMethod = id;
                      for (var i in shippingMethodList) {
                        if (i.id == id) {
                          totalPrice = previousPrice + i.shippingFee;
                          context
                              .read<ShippingChargesCubit>()
                              .getShippingCharge(totalPrice);
                        }
                        print('Total Price $totalPrice');
                      }
                    },
                  ),
                ),
              // SliverToBoxAdapter(child: _buildPaymentList(context)),
              SliverToBoxAdapter(
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    Language.agreeTermAndCondition.capitalizeByWord(),
                    style: paragraphTextStyle(14.0),
                  ),
                  value: agreeTermsCondition == 1 ? true : false,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  activeColor: Utils.dynamicPrimaryColor(context),
                  onChanged: (v) {
                    if (v != null) {
                      agreeTermsCondition = agreeTermsCondition == 1 ? 0 : 1;
                      setState(() {});
                    }
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
            ],
          ),
        ),
        _bottomBtn(),
      ],
    );
  }

  Widget _bottomBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
          color: bottomPanelColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )),
      height: 100.0,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<ShippingChargesCubit, ShippingChargesState>(
                  builder: (context, state) {
                    if (state is ShippingChargesInitial) {
                      return const Text('');
                    } else if (state is ShippingChargesAddedState) {
                      final value =
                          context.read<ShippingChargesCubit>().initialPrice;
                      return Text(
                        "${Language.total.capitalizeByWord()}: ${Utils.formatPrice(value, context)} ",
                        style: headlineTextStyle(20.0).copyWith(color: white),
                        // style: headlineTextStyle(20.0).copyWith(color: Utils.dynamicPrimaryColor(context)),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                Text(
                  " +${Language.shippingCost.capitalizeByWord()}",
                  style: paragraphTextStyle(12.0).copyWith(color: white),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
            child: PrimaryButton(
              text: Language.placeOrderNow.capitalizeByWord(),
              // bgColor: primaryColor,
              // textColor: white,
              borderRadiusSize: Utils.radius(40.0),
              onPressed: () {
                if (agreeTermsCondition != 1) {
                  Utils.errorSnackBar(context,
                      Language.agreeTermAndCondition.capitalizeByWord());
                  return;
                } else if (shippingAddressId < 1 ||
                    billingAddressId < 1 ||
                    shippingMethod < 1) {
                  Utils.errorSnackBar(context, Language.selectLocation);
                } else {
                  body['shipping_address_id'] = shippingAddressId.toString();
                  body['billing_address_id'] = billingAddressId.toString();
                  body['shipping_method_id'] = shippingMethod.toString();
                  debugPrint(body.toString());
                  Navigator.pushNamed(context, RouteNames.placeOrderScreen,
                      arguments: {
                        'body': body,
                        'payment_status': checkoutResponseModel,
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocation() {
    final addressCubit = context.read<AddressCubit>();
    return Column(
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Language.deliveryLocation.capitalizeByWord(),
                  style: headlineTextStyle(18.0)),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.addressScreen);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 22,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Utils.dynamicPrimaryColor(context),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(Language.add.capitalizeByWord(),
                          style: const TextStyle(fontSize: 12.0, color: white)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        BlocBuilder<AddressCubit, AddressState>(
          builder: (context, state) {
            if (state is AddressStateLoading) {
              return Text(Language.loading.capitalizeByWord());
            } else if (state is AddressStateError) {
              return Text(state.message);
            } else if (state is AddressStateLoaded) {
              if (state.address.addresses.isEmpty) {
                return Text(Language.noAddress.capitalizeByWord());
              } else {
                return singleAddressCard(context, state.address.addresses);
              }
            }
            return singleAddressCard(context, addressCubit.address!.addresses);
            // return Text('${Language.somethingWentWrong.capitalizeByWord()}!');
          },
        )
      ],
    );
  }

  Widget singleAddressCard(BuildContext context, List<AddressModel> address) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            ...addressType.asMap().entries.map(
                  (e) => InkWell(
                    onTap: () {
                      setState(() {
                        addressTypeSelect = e.value;
                        pageController.animateToPage(e.key,
                            duration: const Duration(microseconds: 500),
                            curve: Curves.ease);
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(microseconds: 300),
                      curve: Curves.ease,
                      decoration: BoxDecoration(
                          color: addressTypeSelect == e.value
                              ? Utils.dynamicPrimaryColor(context)
                              : transparent,
                          borderRadius: BorderRadius.circular(30.0)),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 10.0)
                          .copyWith(bottom: 12.0),
                      child: Text(
                        e.value,
                        style: TextStyle(
                          color: addressTypeSelect == e.value
                              ? white
                              : textGreyColor,
                        ),
                      ),
                    ),
                  ),
                ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.24,
          child: PageView.builder(
            itemCount: addressType.length,
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                padding: const EdgeInsets.only(left: 20),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      address.length,
                      (index) => shippingCharges(address, index),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget shippingCharges(List<AddressModel> address, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          if (addressTypeSelect == Language.billingAddress.capitalizeByWord()) {
            billingAddressId = address[index].id;
          } else {
            shippingMethodList.clear();
            shippingMethodList.addAll(checkoutResponseModel!.shippings
                .where((element) => element.cityId == "0")
                .toList());

            shippingMethodList.addAll(checkoutResponseModel!.shippings
                .where((element) => element.cityId == address[index].cityId)
                .toList());

            // for (var shipping in checkoutResponseModel!.shippings) {
            //   if (shipping.type == basedOnPrice) {
            //     if (shipping.conditionFrom <= previousPrice &&
            //         shipping.conditionTo >= previousPrice) {
            //       print('addressId $shippingAddressId');
            //       print('shippingId ${shipping.id}');
            //       if (shippingAddressId != shipping.id) {
            //         shippingMethodList.add(shipping);
            //       }
            //     }
            //   }
            //
            //   if (shipping.type == basedOnWeight) {
            //     if (shipping.conditionFrom <= previousPrice &&
            //         shipping.conditionTo >= previousPrice) {
            //       shippingMethodList.add(shipping);
            //       // if (shippingAddressId != shipping.id) {
            //       //   shippingMethodList.add(shipping);
            //       // }
            //     }
            //   }
            //
            //   if (shipping.type == basedOnQty) {
            //     if (shipping.conditionFrom <= previousPrice &&
            //         shipping.conditionTo >= previousPrice) {
            //       shippingMethodList.add(shipping);
            //     }
            //   }

            //shippingAddressId = state.address.addresses[index].id;
            //setState(() {});
            //}

            shippingAddressId = address[index].id;
          }
          setState(() {});
        },
        child: AddressCardComponent(
            isEditButtonShow: false,
            selectAddress:
                addressTypeSelect == Language.billingAddress.capitalizeByWord()
                    ? billingAddressId
                    : shippingAddressId,
            addressModel: address[index],
            type: address[index].type),
      ),
    );
  }

  Widget _buildProductList() {
    final appSetting = context.read<AppSettingCubit>();
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return CheckoutSingleItem(
              product: checkoutResponseModel!.cartProducts[index],
              appSetting: appSetting,
            );
          },
          childCount: checkoutResponseModel!.cartProducts.length,
          addAutomaticKeepAlives: true,
        ),
      ),
    );
  }

  Widget _buildProductNumber() {
    String totalProduct = checkoutResponseModel!.cartProducts.length.toString();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
      child: Row(
        children: [
          CartBadge(
              count: totalProduct,
              badgeColor: Utils.dynamicPrimaryColor(context),
              iconColor: blackColor),
          const SizedBox(width: 20),
          Text(
            "$totalProduct ${Language.products.capitalizeByWord()}",
            style: headlineTextStyle(16.0),
          ),
        ],
      ),
    );
  }
}
