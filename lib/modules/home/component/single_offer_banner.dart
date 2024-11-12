/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_us/widgets/custom_image.dart';
import '/utils/constants.dart';

import '../../../core/remote_urls.dart';
import '../model/slider_model.dart';

class SingleOfferBanner extends StatelessWidget {
  const SingleOfferBanner({
    Key? key,
    required this.slider,
    required this.onTap,
  }) : super(key: key);
  final SliderModel slider;

  // final double? padding;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomImage(path: RemoteUrls.imageUrl(slider.image),fit: BoxFit.cover),

        Positioned(
          top: 16.0,
          left: 50.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(slider.titleOne,
                  style: GoogleFonts.jost(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(height: 2.0),
              SizedBox(
                width: 180.0,
                height: 50.0,
                child: Text(
                  slider.titleTwo,
                  maxLines: 2,
                  style: GoogleFonts.jost(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      height: 1.3),
                ),
              ),
              GestureDetector(onTap: onTap, child: shopNowButton()),
            ],
          ),
        ),
      ],
    );
  }

  Container bannerImage(BuildContext context) {
    return Container(
      // height: 144.0,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 00.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            width: MediaQuery.of(context).size.width / 2.0,
            child: column(),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2.5,
            padding: const EdgeInsets.all(10.0),
            child: CustomImage(path: RemoteUrls.imageUrl(slider.image)),
          ),
        ],
      ),
    );
  }

  Widget column() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          slider.titleOne,
          style: GoogleFonts.jost(
              fontWeight: FontWeight.w600, fontSize: 14.0, color: blackColor),
          maxLines: 2,
        ),
        Text(
          slider.titleTwo,
          maxLines: 2,
          style: GoogleFonts.jost(
              fontWeight: FontWeight.w600, fontSize: 18.0, color: blackColor),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }

  Widget shopNowButton() {
    return Container(
      height: 30.0,
      width: 80.0,
      padding: const EdgeInsets.only(bottom: 4.0),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Shop Now',
            style: simpleTextStyle(white).copyWith(fontSize: 11.0),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(
              Icons.arrow_forward_ios,
              color: white,
              size: 14.0,
            ),
          )
        ],
      ),
    );
  }
}
*/

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/utils/constants.dart';
import '/utils/language_string.dart';
import '../../../core/remote_urls.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../model/slider_model.dart';

class SingleOfferBanner extends StatelessWidget {
  const SingleOfferBanner({
    super.key,
    required this.slider,
    required this.onTap,
  });
  final SliderModel slider;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: CustomImage(
                path: RemoteUrls.imageUrl(slider.image), fit: BoxFit.cover)),
        Positioned(
          left: 60.0,
          top: 10.0,
          child: Text(
            slider.titleOne,
            style: paragraphTextStyle(14.0),
          ),
        ),
        Positioned(
          left: 60.0,
          top: 30,
          child: Container(
            width: 180.0,
            height: 60.0,
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            child: AutoSizeText(
              slider.titleTwo,
              maxFontSize: 15.0,
              minFontSize: 12.0,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: GoogleFonts.jost(
                fontWeight: FontWeight.w600,
                color: blackColor,
                fontSize: 15.0,
              ),
            ),
          ),
        ),
        Positioned(
          left: 60.0,
          bottom: 30.0,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              height: 30.0,
              width: 80.0,
              margin: const EdgeInsets.only(top: 12.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Utils.dynamicPrimaryColor(context),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      Language.shopNow,
                      style: paragraphTextStyle(10.0).copyWith(color: white),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 6, left: 2.0),
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 10.0,
                        color: white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
