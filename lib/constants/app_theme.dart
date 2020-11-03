import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    buttonTheme: kButtonThemeLight,
    inputDecorationTheme: kInputThemeLight,
    accentColor: kPrimaryBlue,
    appBarTheme: kAppBarThemeLight,
    textTheme: GoogleFonts.tajawalTextTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    buttonColor: kPrimaryBlue,
    accentColor: kPrimaryBlue,
    inputDecorationTheme: kInputThemeDark,
    textTheme: GoogleFonts.tajawalTextTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

const kPrimaryBlue = Color(0xFF397AC1);
const kErrorRed = Color(0xFFEA1B2A);
const kGreen = Colors.green;

const kButtonThemeLight = ButtonThemeData(
  buttonColor: Color(0xFF397AC1),
  textTheme: ButtonTextTheme.primary,
);

const kInputThemeLight = InputDecorationTheme(
  filled: true,
  fillColor: Color(0xFFEEEEEE),
);

const kInputThemeDark = InputDecorationTheme(
  filled: true,
  fillColor: Color(0xFF212121),
);

const kAppBarThemeLight = AppBarTheme(
  brightness: Brightness.light,
  color: Colors.white,
  iconTheme: IconThemeData(
    color: Color(0xFF757575),
  ),
);
