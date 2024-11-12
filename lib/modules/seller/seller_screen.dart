import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../core/remote_urls.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_image.dart';
import '../category/component/product_card.dart';

import '../category/controller/cubit/category_cubit.dart';
import '/widgets/rounded_app_bar.dart';
import 'model/single_seller_model.dart';

class BestSellerInformation extends StatefulWidget {
  const BestSellerInformation({super.key});

  // final String slug;
  // final String keyword;

  @override
  State<BestSellerInformation> createState() => _BestSellerInformationState();
}

class _BestSellerInformationState extends State<BestSellerInformation> {
  @override
  Widget build(BuildContext context) {
    final sellerRoute =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final name = sellerRoute['name'] as String;
    final keyword = sellerRoute['keyword'] as String;
    context.read<CategoryCubit>().getSellerProduct(keyword);

    return Scaffold(
      backgroundColor: scaffoldBGColor ,
      appBar: RoundedAppBar(titleText: name,bgColor: scaffoldBGColor),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SellerProductState) {
            if (state.sellerModel.products.isEmpty) {
              return const Center(
                child: Text(
                  // Language.noItemsFound.capitalizeByWord(),
                  'No Item Found',
                ),
              );
            }
            return const SellerProduct();
          } else if (state is CategoryErrorState) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          return Center(
            child: SizedBox(
              child: Text(
                // Language.somethingWentWrong.capitalizeByWord(),
                'Something Went Wrong',
                style: GoogleFonts.openSans(color: Colors.red),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SingleSellerInfo extends StatelessWidget {
  const SingleSellerInfo({super.key, required this.singleSellerModel});
  final SingleSellerModel singleSellerModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 130.0,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CustomImage(
                  path: RemoteUrls.imageUrl(singleSellerModel.bannerImage),
                  fit: BoxFit.cover),
            )),
        Positioned.fill(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildSellerInfo(Icons.email, singleSellerModel.email),
                    buildSellerInfo(Icons.phone, singleSellerModel.phone),
                    buildSellerInfo(
                        Icons.location_on, singleSellerModel.address),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 60.0,
                      width: 60.0,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Center(
                        child: CustomImage(
                          path: RemoteUrls.imageUrl(singleSellerModel.logo),
                          height: 30.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      singleSellerModel.shopName,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                        color: blackColor,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSellerInfo(IconData icon, String info) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6.0, right: 10.0),
          child: Icon(
            icon,
            size: 20.0,
          ),
        ),
        Text(info),
      ],
    );
  }
}

class SellerProduct extends StatelessWidget {
  const SellerProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sellerProduct = context.read<CategoryCubit>().sellerProductModel;
    return CustomScrollView(slivers: [
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        sliver: MultiSliver(
          children: [
            SliverToBoxAdapter(
                child: SingleSellerInfo(
                    singleSellerModel: sellerProduct.singleSellerModel)),
            const SizedBox(height: 20),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 300,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ProductCard(
                      productModel: sellerProduct.products[index]);
                },
                childCount: sellerProduct.products.length,
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
