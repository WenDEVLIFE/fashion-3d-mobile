import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '/utils/constants.dart';
import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '/widgets/custom_image.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/utils.dart';
import '../model/banner_model.dart';

class HotDealBanner extends StatelessWidget {
  const HotDealBanner({
    super.key,
    required this.banner,
    this.height,
  });
  final BannerModel banner;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomImage(
              path: RemoteUrls.imageUrl(banner.image), fit: BoxFit.fill),
          Positioned(
            top: 10.0,
            left: banner.slug == 'sweatshirt' ? 140.0 : 20.0,
            child: AutoSizeText(
              banner.titleOne.capitalizeByWord(),
              minFontSize: 12.0,
              maxFontSize: 15.0,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: paragraphTextStyle(15.0),
            ),
          ),
          Positioned(
            top: 30.0,
            left: banner.slug == 'sweatshirt' ? 140.0 : 20.0,
            // left: banner.slug == 'fruits' ? 140.0 : 20.0,
            child: Container(
              width: 140.0,
              height: 50.0,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: AutoSizeText(
                banner.titleTwo.capitalizeByWord(),
                minFontSize: 12.0,
                maxFontSize: 15.0,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: headlineTextStyle(15.0),
              ),
            ),
          ),
          Positioned(
              bottom: 20.0,
              left: banner.slug == 'sweatshirt' ? 150.0 : 20.0,
              child: shopNowButton(context)),
        ],
      ),
    );
  }

  Widget shopNowButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteNames.singleCategoryProductScreen,
          arguments: {
            'keyword': banner.slug,
            'app_bar': banner.slug,
          },
        );
      },
      child: Container(
        width: 96.0,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0)
            .copyWith(bottom: 10.0),
        decoration: BoxDecoration(
          color: Utils.dynamicPrimaryColor(context),
          //borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            Text(
              Language.shopNow.capitalizeByWord(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: white,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                color: white,
                size: 14.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
