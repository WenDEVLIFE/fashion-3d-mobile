import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/primary_button.dart';
import '../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import 'model/onboarding_data.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late int _numPages;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _numPages = onBoardingList.length;
    _pageController = PageController(initialPage: _currentPage);
  }

  Widget getContent() {
    final item = onBoardingList[_currentPage];
    return Column(
      key: ValueKey('$_currentPage'),
      children: [
        Text(
          item.title,
          style: headlineTextStyle(30.0),
        ),
        const SizedBox(height: 10),
        Text(
          item.paragraph,
          textAlign: TextAlign.center,
          style: paragraphTextStyle(16.0),
        ),
      ],
    );
  }

  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height:
                  _currentPage == 0 ? size.height * 0.58 : size.height * 0.62,
              width: _currentPage == 0 ? size.width * 0.88 : size.width,
              child: _buildImagesSlider(),
            ),
            _buildBottomContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: kDuration,
            transitionBuilder: (Widget child, Animation<double> anim) {
              return FadeTransition(opacity: anim, child: child);
            },
            child: getContent(),
          ),
          const SizedBox(height: 25.0),
          PrimaryButton(
            // text: _currentPage == _numPages - 1
            //     ? Language.enabledLocation.capitalizeByWord()
            //     : Language.next.capitalizeByWord(),
            text: Language.next.capitalizeByWord(),
            onPressed: () {
              if (_currentPage == _numPages - 1) {
                context.read<AppSettingCubit>().cachOnBoarding();
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.authenticationScreen, (route) => false);
                return;
              }
              _pageController.nextPage(
                  duration: kDuration, curve: Curves.easeInOut);
            },
            fontSize: 18.0,
          ),
          TextButton(
            onPressed: () {
              context.read<AppSettingCubit>().cachOnBoarding();
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.authenticationScreen, (route) => false);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(transparent),
              overlayColor: MaterialStateProperty.all(transparent),
            ),
            child: Text(
              // _currentPage == 3
              //     ? Language.notNow.capitalizeByWord()
              //     : Language.skipForNow.capitalizeByWord(),
              Language.skipForNow.capitalizeByWord(),
              //'Skip For Now',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  color: textGreyColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagesSlider() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          child: Padding(
            padding: EdgeInsets.only(left: _currentPage == 2 ? 30.0 : 0),
            child: PageView(
              physics: const ClampingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: onBoardingList
                  .map((e) => Padding(
                        padding: _currentPage == 3
                            ? const EdgeInsets.only(left: 50.0, right: 50.0)
                            : EdgeInsets.zero,
                        child: CustomImage(path: e.image),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  SizedBox sizedBox() {
    return SizedBox(
      width: size.width,
      height: size.height * 0.65,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(child: CustomImage(path: onBoardingList[2].image)),
        ],
      ),
    );
  }

  ///image 0 height 0.62 ,width 90,,StackFit.expand,
  ///image 1 height 0.62 ,width 100,,StackFit.expand,
  ///image 2 height 0.65 ,width 100,,StackFit.expand,
}
