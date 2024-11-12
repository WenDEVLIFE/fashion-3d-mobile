import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '/widgets/capitalized_word.dart';
import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../utils/language_string.dart';
import '../../utils/utils.dart';
import '../../widgets/rounded_app_bar.dart';
import 'component/drawer_filter.dart';
import 'component/product_card.dart';
import 'controller/cubit/category_cubit.dart';

class SingleCategoryProductScreen extends StatefulWidget {
  const SingleCategoryProductScreen({
    super.key,
  });

  @override
  State<SingleCategoryProductScreen> createState() =>
      _SingleCategoryProductScreenState();
}

class _SingleCategoryProductScreenState
    extends State<SingleCategoryProductScreen> {
  @override
  Widget build(BuildContext context) {
    final receivedValue =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final appBarName = receivedValue['app_bar'] as String;
    final keyword = receivedValue['keyword'] as String;
    context.read<CategoryCubit>().getCategoryProduct(keyword);

    return Scaffold(
        endDrawer: const DrawerFilter(),
        appBar: RoundedAppBar(
          actions: const [SizedBox()],
          titleText: appBarName.capitalizeByWord(),
          onTap: () {
            Navigator.popAndPushNamed(
                context, RouteNames.allCategoryListScreen);
          },
        ),
        body: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoryLoadedState) {
              if (state.categoryProducts.isEmpty) {
                return Center(
                    child: Text(Language.noItemsFound.capitalizeByWord()));
              }
              // _buildProductGrid(state.productCategoriesModel.products);
              return const CategoryLoad();
            } else if (state is CategoryErrorState) {
              return Center(
                child: Text(state.errorMessage),
              );
            }
            return Center(
              child: SizedBox(
                child: Text(Language.somethingWentWrong.capitalizeByWord()),
              ),
            );
          },
        ));
  }
}

class CategoryLoad extends StatelessWidget {
  const CategoryLoad({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryProduct = context.read<CategoryCubit>().categoryProducts;
    return CustomScrollView(slivers: [
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        sliver: MultiSliver(
          children: [
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // const SizedBox(),
                  GestureDetector(
                    onTap: () => Scaffold.of(context).openEndDrawer(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Utils.dynamicPrimaryColor(context),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 6, vertical: 0)
                              .copyWith(bottom: 4),
                      child: Text(
                        Language.filter.capitalizeByWord(),
                        style: GoogleFonts.roboto(color: white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: singleProductHeight + 60.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ProductCard(productModel: categoryProduct[index]);
                },
                childCount: categoryProduct.length,
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
