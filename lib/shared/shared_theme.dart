import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SharedTheme {
  static const thin = FontWeight.w100;
  static const extraLight = FontWeight.w200;
  static const light = FontWeight.w300;
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.w700;
  static const extraBold = FontWeight.w800;
  static const black = FontWeight.w900;

  static final _lightColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFFB16C3B),
  );

  static final _darkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color(0xFFB16C3B),
  );

  static const whiteColor = Color(0xFFFFFFFF);
  static const lightSuccessColor = Color.fromARGB(255, 21, 91, 83);
  static const darkSuccessColor = Color(0xFF249689);
  static const lightInfoColor = Color(0xFF1307B2);
  static const darkInfoColor = Color.fromARGB(255, 62, 49, 232);
  static const errorColor = Color(0xFFFF5963);
  static const warningColors = Color(0xFFF9CF58);
  static const darkWarningColor = Color.fromARGB(255, 255, 136, 10);
  static const lightWarningColor = Color(0xFFE57B09);

  static const filledApprovedColor = Color.fromARGB(255, 15, 203, 131);
  static const filledRejectedColor = Color(0xFFD93E3E);
  static const filledPendingColor = Color(0xFFEAB308);

  static final successColor =
      Get.isDarkMode ? darkSuccessColor : lightSuccessColor;
  static final warningColor =
      Get.isDarkMode ? darkWarningColor : lightWarningColor;
  static final infoColor = Get.isDarkMode ? darkInfoColor : lightInfoColor;

  static final TextTheme _textThemeStyle = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontWeight: SharedTheme.regular,
      fontSize: 57,
    ),
    displayMedium: GoogleFonts.poppins(
      fontWeight: SharedTheme.regular,
      fontSize: 45,
    ),
    displaySmall: GoogleFonts.poppins(
      fontWeight: SharedTheme.regular,
      fontSize: 36,
    ),
    headlineLarge: GoogleFonts.poppins(
      fontWeight: SharedTheme.regular,
      fontSize: 32,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontWeight: SharedTheme.regular,
      fontSize: 28,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontWeight: SharedTheme.regular,
      fontSize: 24,
    ),
    titleLarge: GoogleFonts.poppins(
      fontWeight: SharedTheme.regular,
      fontSize: 22,
    ),
    titleMedium: GoogleFonts.poppins(
      fontWeight: SharedTheme.medium,
      fontSize: 16,
    ),
    titleSmall: GoogleFonts.poppins(
      fontWeight: SharedTheme.medium,
      fontSize: 14,
    ),
    bodyLarge: GoogleFonts.openSans(
      fontWeight: SharedTheme.regular,
      fontSize: 16,
    ),
    bodyMedium: GoogleFonts.openSans(
      fontWeight: SharedTheme.regular,
      fontSize: 14,
    ),
    bodySmall: GoogleFonts.openSans(
      fontWeight: SharedTheme.regular,
      fontSize: 12,
    ),
    labelLarge: GoogleFonts.openSans(
      fontWeight: SharedTheme.medium,
      fontSize: 14,
    ),
    labelMedium: GoogleFonts.openSans(
      fontWeight: SharedTheme.medium,
      fontSize: 12,
    ),
    labelSmall: GoogleFonts.openSans(
      fontWeight: SharedTheme.medium,
      fontSize: 11,
    ),
  );

  static final lightThemeMaterial = ThemeData(
    colorScheme: _lightColorScheme,
    textTheme: _textThemeStyle,
  );

  static final darkThemeMaterial = ThemeData(
    colorScheme: _darkColorScheme,
    textTheme: _textThemeStyle,
  );
}
