import 'package:flutter/material.dart';

abstract final class AppColors {
  static const white1 = Color(0xFFF3F4F6);
  static const white2 = Color(0xFFF1F5F9);
  static const white = Color(0xFFFFFFFF);
  static const blue1 = Color(0xFF0F172A);
  static const blue2 = Color(0xFF060A0E);
  static const red1 = Color(0xFFEF4444);
  static const green1 = Color(0xFF10B981);
  static const green2 = Color(0xFFE7F8F2);
  static const green3 = Color(0xFF47EBB4);
  static const green4 = Color(0xFF113227);
  static const black = Color(0xFF000000);
  static const black1 = Color(0xFF090A0C);
  static const grey1 = Color.fromARGB(255, 192, 191, 190);

  static const lightColorScheme = ColorScheme.light(
    surface: white1,
    primary: black1,
    secondary: black1,
  );

  static const darkColorScheme = ColorScheme.dark(
    surface: black1,
    primary: white1,
    secondary: white1,
  );
}
