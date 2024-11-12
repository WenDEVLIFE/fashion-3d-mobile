import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '/utils/constants.dart';
import '../../../core/router_name.dart';
import '../../../utils/utils.dart';
import '../model/slider_model.dart';
import 'single_offer_banner.dart';

class OfferBannerSlider extends StatefulWidget {
  const OfferBannerSlider({
    super.key,
    required this.sliders,
  });

  final List<SliderModel> sliders;

  @override
  State<OfferBannerSlider> createState() => _OfferBannerSliderState();
}

class _OfferBannerSliderState extends State<OfferBannerSlider> {
  final double height = 180;
  final int initialPage = 0;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CarouselSlider(
            items: widget.sliders
                .map(
                  (e) => SingleOfferBanner(
                    slider: e,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteNames.productDetailsScreen,
                        arguments: e.productSlug,
                      );
                    },
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.2,
              initialPage: initialPage,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 2000),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal,
            ),
          ),
          buildDotIndicator(),
        ],
      ),
    );
  }

  Widget buildDotIndicator() {
    return Positioned(
      bottom: 2.0,
      right: 130.0,
      child: Container(
        width: 60.0,
        height: 20,
        margin: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border:
              Border.all(color: Utils.dynamicPrimaryColor(context), width: 1.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.sliders.length,
            (index) => AnimatedContainer(
              duration: kDuration,
              height: 6.0,
              width: 6.0,
              padding: EdgeInsets.all(_currentIndex == index ? 2.0 : 0.0),
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Utils.dynamicPrimaryColor(context),
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? white
                      : Utils.dynamicPrimaryColor(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onChangeFunction(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void callbackFunction(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentIndex = index;
    });
  }
}
