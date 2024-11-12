import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/modules/product_details/component/loader_screen.dart';
import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../widgets/toggle_button_component.dart';
import '../cart/controllers/cart/cart_cubit.dart';
import '../home/component/home_app_bar.dart';
import 'component/bottom_sheet_widget.dart';
import 'component/description_component.dart';
import 'component/product_details_component.dart';
import 'component/product_header_component.dart';
import 'component/rating_list_component.dart';
import 'component/related_products_list.dart';
import 'component/seller_info_component.dart';
import 'controller/cubit/product_details_cubit.dart';
import 'model/product_details_model.dart';
import 'model/product_details_product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.slug});

  final String slug;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<ProductDetailsCubit>().getProductDetails(widget.slug));
  }

  final _className = 'ProductDetailsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsStateLoading) {
              return const Center(child: DetailsPageLoading());
            }
            if (state is ProductDetailsStateError) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(color: redColor),
                ),
              );
            }
            if (state is ProductDetailsStateLoaded) {
              return _buildLoadedPage(state.productDetailsModel);
            }
            log(state.toString(), name: _className);
            return const SizedBox();
          },
        );
      }),
    );
  }

  Widget _buildLoadedPage(ProductDetailsModel productDetailsModel) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverAppBar(
              backgroundColor: cardBgColor,
              title: Text(
                Language.productDetails.capitalizeByWord(),
                style: headlineTextStyle(18.0),
              ),
            ),
            SliverToBoxAdapter(
              child: ProductHeaderComponent(
                  product: productDetailsModel.product,
                  gallery: productDetailsModel.gallery),
            ),
            // SliverToBoxAdapter(
            //     child: ProductHeaderComponent(
            //         productDetailsModel.product, productDetailsModel.gallery)),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: ProductDetailsComponent(
                detailsModel: productDetailsModel,
                product: productDetailsModel.product,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 25)),
            SliverToBoxAdapter(
              child: ToggleButtonComponent(
                textList: [
                  Language.description.capitalizeByWord(),
                  '${Language.reviews.capitalizeByWord()} (${productDetailsModel.productReviews.length})',
                  productDetailsModel.isSellerProduct == true
                      ? Language.sellerInfo
                      : '',
                ],
                initialLabelIndex: 0,
                onChange: (int i) {
                  setState(() {
                    selectedIndex = i;
                  });
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(child: getChild(productDetailsModel)),
            SliverToBoxAdapter(
              child: RelatedProductsList(productDetailsModel.relatedProducts),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 95)),
          ],
        ),
        _buildBottomButtons(productDetailsModel.product),
      ],
    );
  }

  Widget getChild(ProductDetailsModel productDetailsModel) {
    debugPrint(
        'product-details ${productDetailsModel.product.longDescription}');
    if (selectedIndex == 0) {
      return DescriptionComponent(productDetailsModel.product.longDescription);
    } else if (selectedIndex == 1) {
      return ReviewListComponent(productDetailsModel.productReviews);
    } else if (selectedIndex == 2) {
      return SellerInfo(productDetailsModel: productDetailsModel);
    }
    return const SizedBox();
  }

  Widget _buildBottomButtons(ProductDetailsProductModel product) {
    final cartProducts = context.read<CartCubit>();
    return Container(
      padding: Utils.all(value: 20.0),
      decoration: const BoxDecoration(
        color: bottomPanelColor,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(.2),
        //     offset: const Offset(-9, -1),
        //     blurRadius: 30,
        //     spreadRadius: 30,
        //   )
        // ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RouteNames.cartScreen);
            },
            child: Container(
              height: 50,
              width: 50,
              padding: Utils.all(value: 12.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.cartScreen);
                },
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return CartBadge(
                      count: cartProducts.cartCount.toString(),
                      // badgeColor: lightningYellowColor,
                      // countColor: primaryColor,
                      badgeColor: Utils.dynamicPrimaryColor(context),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: bottomPanelColor,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    builder: (_) => BottomSheetWidget(product: product));
              },
              child: Container(
                width: double.infinity,
                height: 50.0,
                padding: const EdgeInsets.only(bottom: 6.0),
                decoration: BoxDecoration(
                    // color: white,
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
                          fontSize: 18.0, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
