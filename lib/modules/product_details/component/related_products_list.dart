import 'package:flutter/material.dart';
import 'package:shop_us/utils/language_string.dart';
import 'package:shop_us/widgets/capitalized_word.dart';

import '../../../utils/constants.dart';
import '../../home/component/section_header.dart';
import '../model/product_details_product_model.dart';
import 'related_single_product_card.dart';

class RelatedProductsList extends StatelessWidget {
  const RelatedProductsList(
    this.relatedProducts, {
    super.key,
  });
  final List<ProductDetailsProductModel> relatedProducts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: SectionHeader(
            headerText: Language.relatedProduct.capitalizeByWord(),
            isSeeAll: false,
            // onTap: () =>Navigator.pushNamed(context, RouteNames.allCategoryListScreen),
          ),
        ),
        SizedBox(
          height: singleProductHeight + 60.0,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            itemCount: relatedProducts.length,
            itemBuilder: (context, index) => RelatedSingleProductCard(
                productModel: relatedProducts[index], width: 180),
          ),
        ),
        const SizedBox(
          height: 30.0,
        )
      ],
    );
  }
}
