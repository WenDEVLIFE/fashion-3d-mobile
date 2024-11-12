import 'package:flutter/material.dart';
import 'package:shop_us/utils/constants.dart';
import 'package:shop_us/widgets/custom_image.dart';

import '/core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../model/home_seller_model.dart';

class SingleCircularSeller extends StatelessWidget {
  const SingleCircularSeller({
    super.key,
    required this.seller,
  });

  final HomeSellerModel seller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteNames.bestSellerScreen,
          arguments: {
            'name': seller.shopName,
            'keyword': seller.slug,
          },
        );
        // print(seller.shopName);
        // print(seller.slug);
      },
      child: Container(
        width: 95.0,
        height: 98.0,
        margin: const EdgeInsets.only(right: 12.0),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: cardBgColor, borderRadius: BorderRadius.circular(4.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 54.0,
              width: 54.0,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: white,
                shape: BoxShape.circle,
              ),
              child: CustomImage(
                height: 34.0,
                width: 35.0,
                path: RemoteUrls.imageUrl(seller.logo),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              seller.shopName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: headlineTextStyle(14.0),
            ),
          ],
        ),
      ),
    );
  }
}

//FAE8F7
