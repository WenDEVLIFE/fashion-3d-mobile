import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_us/core/remote_urls.dart';
import 'package:shop_us/modules/home/model/home_categories_model.dart';
import 'package:shop_us/widgets/custom_image.dart';

import '../../../core/router_name.dart';
import '../../../utils/utils.dart';

class CategoryCircleCard extends StatelessWidget {
  const CategoryCircleCard({
    super.key,
    required this.homeCategories,
  });

  final HomePageCategoriesModel homeCategories;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.singleCategoryProductScreen,
            arguments: {
              'keyword': homeCategories.slug,
              'app_bar': homeCategories.name,
            });
      },
      child: Container(
        height: 54.0,
        margin: const EdgeInsets.only(right: 14.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            color: Utils.dynamicPrimaryColor(context).withOpacity(0.08),
            borderRadius: BorderRadius.circular(4.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // FaIcon(homeCategories.icon, color: blackColor),
            Container(
              alignment: Alignment.center,
              child: CustomImage(
                path: RemoteUrls.imageUrl(homeCategories.image),
                height: 34.0,
                width: 34.0,
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              homeCategories.name,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1B1B1B)),
            ),
          ],
        ),
      ),
    );
  }
}
