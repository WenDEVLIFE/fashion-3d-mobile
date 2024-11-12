import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../core/router_name.dart';
import '../model/home_seller_model.dart';
import 'section_header.dart';
import 'single_circuler_seller.dart';

class BestSellerGridView extends StatelessWidget {
  const BestSellerGridView({
    super.key,
    required this.sellers,
    required this.sectionTitle,
  });
  final List<HomeSellerModel> sellers;
  final String sectionTitle;

  @override
  Widget build(BuildContext context) {
    if (sellers.isEmpty) return const SliverToBoxAdapter();
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 10, left: 0, right: 0),
      sliver: MultiSliver(
        children: [
          const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
          SliverToBoxAdapter(
            child: SectionHeader(
              headerText: sectionTitle,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.allSellerList,
                    arguments: sellers);
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 15.0)),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(
                  sellers.length > 5 ? 5 : sellers.length,
                  (index) => SingleCircularSeller(seller: sellers[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
