import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

class MyTheme {
  static final borderRadius = BorderRadius.circular(36.0);
  static final theme = ThemeData(
      brightness: Brightness.light,
      primaryColor: white,
      scaffoldBackgroundColor: Colors.white,
      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: white),
      colorScheme: const ColorScheme.light(secondary: lightningYellowColor),
      appBarTheme: const AppBarTheme(
        backgroundColor: white,
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: blackColor, fontSize: 20, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: blackColor),
        elevation: 0,
      ),
      textTheme: GoogleFonts.interTextTheme(
        const TextTheme(
          bodySmall: TextStyle(fontSize: 12, height: 1.83),
          bodyLarge: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, height: 1.375),
          bodyMedium: TextStyle(fontSize: 14, height: 1.5714),
          labelLarge:
              TextStyle(fontSize: 16, height: 2, fontWeight: FontWeight.w600),
          // titleLarge: const TextStyle(
          //     fontSize: 16, height: 2, fontWeight: FontWeight.w600),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 64),
          backgroundColor: lightningYellowColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
      ),
      /*  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 3,
        backgroundColor: Color(0x00ffffff),
        showUnselectedLabels: true,
      ),*/

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        // selectedLabelStyle: TextStyle(color: primaryColor),
        elevation: 3,
        backgroundColor: Color(0x00ffffff),
        selectedLabelStyle: TextStyle(color: redColor, fontSize: 14.0),
        unselectedLabelStyle: TextStyle(color: iconGreyColor, fontSize: 12.0),
        selectedItemColor: blackColor,
        unselectedItemColor: iconGreyColor,
        showUnselectedLabels: true,
      ),
      inputDecorationTheme: InputDecorationTheme(
        // contentPadding: const EdgeInsets.only(left: 15.0),
        isDense: true,
        hintStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w400, fontSize: 16.0, color: grayColor),
        labelStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w400, fontSize: 16.0, color: grayColor),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: borderColor.withOpacity(0.8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: borderColor.withOpacity(0.8)),
        ),
        fillColor: inputFieldBgColor,
        filled: true,
        focusColor: borderColor,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: blackColor,
        selectionColor: blackColor,
        selectionHandleColor: blackColor,
      ),
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: primaryColor));
}

// class MyTheme {
//   static final borderRadius = BorderRadius.circular(36.0);
//   static final theme = ThemeData(
//     brightness: Brightness.light,
//     primaryColor: white,
//     scaffoldBackgroundColor: Colors.white,
//     bottomSheetTheme: const BottomSheetThemeData(backgroundColor: white),
//     colorScheme: const ColorScheme.light(secondary: lightningYellowColor),
//     appBarTheme: const AppBarTheme(
//       backgroundColor: white,
//       centerTitle: true,
//       titleTextStyle: TextStyle(
//           color: blackColor, fontSize: 20, fontWeight: FontWeight.bold),
//       iconTheme: IconThemeData(color: blackColor),
//       elevation: 0,
//     ),
//     textTheme: GoogleFonts.interTextTheme(
//       const TextTheme(
//         bodySmall: TextStyle(fontSize: 12, height: 1.83),
//         bodyLarge:
//         TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 1.375),
//         bodyMedium: TextStyle(fontSize: 14, height: 1.5714),
//         labelLarge:
//         TextStyle(fontSize: 16, height: 2, fontWeight: FontWeight.w600),
//         // titleLarge: const TextStyle(
//         //     fontSize: 16, height: 2, fontWeight: FontWeight.w600),
//       ),
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         minimumSize: const Size(double.infinity, 64),
//         backgroundColor: lightningYellowColor,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//       ),
//     ),
//     bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//       elevation: 3,
//       backgroundColor: Color(0x00ffffff),
//       // selectedLabelStyle:
//       //     TextStyle(color: primaryColor, fontSize: 14.0),
//       // unselectedLabelStyle: TextStyle(color: paragraphColor, fontSize: 12.0),
//       // selectedItemColor: lightningYellowColor,
//       // unselectedItemColor: paragraphColor,
//       showUnselectedLabels: true,
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       // contentPadding: const EdgeInsets.only(left: 15.0),
//       isDense: true,
//       hintStyle: GoogleFonts.inter(
//           fontWeight: FontWeight.w400, fontSize: 16.0, color: grayColor),
//       labelStyle: GoogleFonts.inter(
//           fontWeight: FontWeight.w400, fontSize: 16.0, color: grayColor),
//       border: OutlineInputBorder(
//         borderRadius: borderRadius,
//         borderSide: BorderSide(color: borderColor.withOpacity(0.8)),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: borderRadius,
//         borderSide: const BorderSide(color: borderColor),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: borderRadius,
//         borderSide: BorderSide(color: borderColor.withOpacity(0.8)),
//       ),
//       fillColor: inputFieldBgColor,
//       filled: true,
//       focusColor: borderColor,
//     ),
//     textSelectionTheme: const TextSelectionThemeData(
//       cursorColor: blackColor,
//       selectionColor: blackColor,
//       selectionHandleColor: blackColor,
//     ),
//   );
// }
