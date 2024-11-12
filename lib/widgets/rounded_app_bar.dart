import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants.dart';
import 'app_bar_leading.dart';

class RoundedAppBar extends AppBar {
  final String? titleText;

  final Color bgColor;
  final Color textColor;
  final void Function()? onTap;
  final List<Widget>? actions;

  RoundedAppBar({
    this.titleText,
    this.textColor = Colors.black,
    this.bgColor = appBgColor,
    this.onTap,
    this.actions,
    super.key,
  }) : super(
          titleSpacing: 0,
          backgroundColor: bgColor,
          leading: const AppbarLeading(),
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: GoogleFonts.jost(
              color: textColor, fontSize: 18.0, fontWeight: FontWeight.w600),
          title: titleText != null ? Text(titleText) : null,
          elevation: 0.0,
          actions: actions,
          automaticallyImplyLeading: false,
        );
}
