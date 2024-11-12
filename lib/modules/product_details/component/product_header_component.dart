import 'package:flutter/material.dart';

import '../../../core/remote_urls.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/favorite_button.dart';
import '../../home/model/product_model.dart';
import '../model/product_details_product_model.dart';

class ProductHeaderComponent extends StatefulWidget {
  const ProductHeaderComponent(
      {super.key, required this.product, required this.gallery});

  final ProductDetailsProductModel product;
  final List<GalleryModel?> gallery;

  @override
  State<ProductHeaderComponent> createState() => _ProductHeaderComponentState();
}

class _ProductHeaderComponentState extends State<ProductHeaderComponent> {
  late List<String> allImages = [];
  int _currentIndex = 0;

  @override
  void initState() {
    sliderImages();
    super.initState();
    // productThumb = widget.product.thumbImage;
  }

  void sliderImages() {
    final img = widget.product;
    final galleryImg = widget.gallery;
    allImages.add(img.thumbImage);
    // for (int i = 0; i <= 4; i++) {
    //   allImages.add(img.thumbImage);
    // }
    if (galleryImg.isNotEmpty) {
      for (int i = 0; i < galleryImg.length; i++) {
        if (galleryImg[i]!.image.isNotEmpty) {
          allImages.add(galleryImg[i]!.image);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Utils.vSize(300.0),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: cardBgColor,
          ),
          child: PageView.builder(
              itemCount: allImages.length,
              onPageChanged: (int index) =>
                  setState(() => _currentIndex = index),
              itemBuilder: (context, index) {
                return CustomImage(
                  path: RemoteUrls.imageUrl(allImages[index]),
                  // path: KImages.detailImage,
                  fit: BoxFit.fitHeight,
                );
              }),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(
              allImages.length,
              (index) => AnimatedContainer(
                duration: kDuration,
                margin: Utils.only(
                    top: 10.0,
                    right: index == allImages.length - 1 ? 16.0 : 8.0,
                    left: index == 0 ? 16.0 : 0.0),
                height: Utils.vSize(3.0),
                width: Utils.hSize(60.0),
                color: _currentIndex == index
                    ? Utils.dynamicPrimaryColor(context)
                    : carouselColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFavBtn(int id) {
    return Positioned(
      right: 20,
      top: 0,
      child: FavoriteButton(productId: id),
    );
  }

// Widget _buildThumbImage() {
//   return Positioned(
//     top: 30,
//     left: 20,
//     right: 35,
//     bottom: 60,
//     child: CustomImage(
//       path: RemoteUrls.imageUrl(productThumb),
//       fit: BoxFit.contain,
//     ),
//   );
// }
}
