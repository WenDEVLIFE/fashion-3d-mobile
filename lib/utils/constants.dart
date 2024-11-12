import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color white = Color(0xFFFFFFFF);
// const Color primaryColor = Color(0xFF000000);
const Color primaryColor = Color(0xFFAE1C9A);
const Color blackColor = Color(0xff0B2C3D);
const Color buttonTextColor = Color(0xff1D1D1D);
const Color bottomPanelColor = Color(0xFf232532);
const Color borderColor = Color(0xFFFAE8F7); //FAE8F7
// const Color borderColor = Color(0xFFFAE8F7); //FAE8F7
// const Color borderColor = Color(0xFFFFEBC4);
const Color greenColor = Color(0xFF34A853);
const Color redColor = Color(0xFFEF262C);
const Color deepGreenColor = Color(0xFF27AE60);
final Color grayColor = const Color(0xff0B2C3D).withOpacity(.3);
const Color lightningYellowColor = Color(0xffFFBB38);
const Color iconGreyColor = Color(0xff85959E);
const Color paragraphColor = Color(0xff18587A);
const Color appBgColor = Color(0xffFFFCF7);
const Color scaffoldBGColor = Color(0xFFFFFFFF);
// const Color scaffoldBGColor = Color(0xFFF8F3F7);
const Color cardBgGreyColor = Color(0xffEDF1F3);
const Color cardBgColor = Color(0xFFF6F6F6);
const Color textGreyColor = Color(0xff797979);
const Color inputFieldBgColor = Color(0xFFFCFBFB);
// const Color inputFieldBgColor = Color(0xFFFFFBFF);
const Color grayBorderColor = Color(0xffE8E8E8);
const Color imageBgColor = Color(0xFFFBF6FA);
const Color carouselColor = Color(0xFFD9D9D9);
const Color transparent = Colors.transparent;
const greenGradient = [lightningYellowColor, lightningYellowColor];

// #duration
const kDuration = Duration(milliseconds: 300);

final _borderRadius = BorderRadius.circular(4);

var inputDecorationTheme = InputDecoration(
  isDense: true,
  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
  hintStyle: const TextStyle(fontSize: 18, height: 1.667),
  border: OutlineInputBorder(
    borderRadius: _borderRadius,
    borderSide: const BorderSide(color: Colors.white),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: _borderRadius,
    borderSide: const BorderSide(color: Colors.white),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: _borderRadius,
    borderSide: const BorderSide(color: Colors.white),
  ),
  fillColor: white,
  filled: true,
  focusColor: white,
);

TextStyle headlineTextStyle(double size) => GoogleFonts.jost(
    fontWeight: FontWeight.w600, color: blackColor, fontSize: size);

TextStyle paragraphTextStyle(double size) => GoogleFonts.inter(
    fontWeight: FontWeight.w400, color: Colors.grey, fontSize: size);

final gredientColors = [
  [const Color(0xffF6290C), const Color(0xffC70F16)],
  [const Color(0xff019BFE), const Color(0xff0077C1)],
  [const Color(0xff161632), const Color(0xff3D364E)],
  [const Color(0xffF6290C), const Color(0xffC70F16)],
  [const Color(0xff019BFE), const Color(0xff0077C1)],
  [const Color(0xff161632), const Color(0xff3D364E)],
];

const double singleProductHeight = 244.0;
Border borderSide =
    Border.all(color: const Color.fromRGBO(174, 28, 154, 0.14), width: 1.5);

TextStyle simpleTextStyle(Color? color) => GoogleFonts.roboto(
    fontWeight: FontWeight.w400, fontSize: 16.0, color: color ?? textGreyColor);
