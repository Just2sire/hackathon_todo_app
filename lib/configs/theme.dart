import 'package:flutter/material.dart';

class ThemeClass {
  // Color lightPrimaryColor = const Color(0xFFF6F6F6);
  static const Color primaryColor = Color(0xFF9581FF);
  static const Color accentColor = Color(0xFFFFC804);
  static const Color darkColor = Color(0xFF000000);
  static const Color secondaryColor = Color(0xFF0F071A);
  static const Color lightColor = Color(0xFFF6F6F6);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    primaryColor: const Color(0xFF9581FF),
    scaffoldBackgroundColor: lightColor,
    colorScheme: ColorScheme.fromSeed(
      primary: const Color(0xFF9581FF),
      secondary: const Color(0xFF0F071A),
      background: const Color(0xFF9581FF),
      surface: const Color(0xFFF6F6F6),
      tertiary: const Color(0xFFFFC804),
      seedColor: const Color(0xFFF6F6F6),
      // primary: const Color.from
    ),
  );
}
