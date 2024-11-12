import 'package:flutter/material.dart';
import '../model/product_model.dart';
import 'home_horizontal_list_product_card.dart';
import 'section_header.dart';

class CategoryAndListComponent extends StatelessWidget {
  const CategoryAndListComponent({
    super.key,
    required this.productList,
    required this.category,
    this.bgColor,
    this.onTap,
  });
  final List<ProductModel> productList;
  final String category;
  final Color? bgColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (productList.isEmpty) return const SliverToBoxAdapter();

    return SliverToBoxAdapter(
      child: Container(
        color: bgColor,
        child: Column(
          children: [
            const SizedBox(height: 20),
            SectionHeader(
              headerText: category,
              onTap: onTap,
            ),
            Container(
              height: 150,
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => HomeHorizontalListProductCard(
                  productModel: productList[index],
                  height: 150,
                  width: 280,
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemCount: productList.length > 5 ? 5 : productList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
