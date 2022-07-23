import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishColor = Color(0xFF4e5ae8);
const Color yellowColor = Color(0xFFFFB746);
const Color pinkColor = Color(0xFFff4667);
const Color whiteColor = Colors.white;
const Color darGreyColor = Color(0xFF121212);
Color arkHeaderColor = Colors.grey.shade800;
const primaryColor = bluishColor;

class Themes {
  static final dark = ThemeData(
    primaryColor: darGreyColor,
    backgroundColor: darGreyColor,
    brightness: Brightness.dark,
    // appBarTheme: AppBarTheme(
    //   backgroundColor: darGreyColor,
    // ),
  );

  static final light = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: primaryColor,
    brightness: Brightness.light,
    // appBarTheme: AppBarTheme(
    //   backgroundColor: primaryColor,
    // ),
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey.shade400 : Colors.grey,
    ),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.grey.shade100 : Colors.grey.shade600,
    ),
  );
}
