import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_us/utils/utils.dart';

import '../modules/animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../utils/constants.dart';

// ignore: must_be_immutable
class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    super.key,
    this.maximumSize = const Size(double.infinity, 52),
    required this.text,
    this.gradientColor = greenGradient,
    this.fontSize = 18.0,
    required this.onPressed,
    this.minimumSize = const Size(double.infinity, 52),
    this.borderRadiusSize = 0.0,
    this.bgColor,
    this.textColor = white,
  });

  final VoidCallback? onPressed;
  final List<Color> gradientColor;
  final String text;
  final Size maximumSize;
  final Size minimumSize;
  final double fontSize;
  final double borderRadiusSize;
  Color? bgColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final color = context.read<AppSettingCubit>().settingModel!.setting;
    if (color != null && color.themeOne.isNotEmpty) {
      bgColor = Utils.dynamicPrimaryColor(context);
    } else {
      bgColor = primaryColor;
    }

    final borderRadius = BorderRadius.circular(borderRadiusSize);
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: borderRadius)),
        minimumSize: WidgetStateProperty.all(minimumSize),
        maximumSize: WidgetStateProperty.all(maximumSize),
        backgroundColor: WidgetStateProperty.all(bgColor),
        overlayColor: WidgetStateProperty.all(transparent),
        elevation: WidgetStateProperty.all(0.0),
      ),
      child: Text(
        text,
        style: GoogleFonts.roboto(
            color: textColor,
            fontSize: fontSize,
            height: 1.5,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
