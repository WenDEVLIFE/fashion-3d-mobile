import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/k_images.dart';
import '../../../utils/k_strings.dart';
import '../../../widgets/custom_image.dart';

class AnimationSplashWidget extends StatelessWidget {
  const AnimationSplashWidget({
    super.key,
    required this.animation,
  });

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned(
          left: 0,
          top: 30,
          child: CustomImage(
            path: KImages.splashRoundLogo,
            width: animation.value * 320,
            height: animation.value * 320,
          ),
        ),
        Positioned(
          bottom: 60,
          left: 0,
          right: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomImage(
                path: KImages.logoIcon,
                width: animation.value * 168,
                height: animation.value * 40,
              ),
              const SizedBox(height: 10),
              Text(
                Kstrings.splashTitle,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  height: 1,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
