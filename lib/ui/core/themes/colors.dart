import 'package:flutter/material.dart';

abstract final class AppColors {
  static const white1 = Color(0xFFF3F4F6);
  static const grey1 = Color(0xFFEDEFF1);
  static const grey2 = Color(0xFFF4F7FA);
  static const grey3 = Color(0xFF7C899D);
  static const black1 = Color(0xFF272E3F);
  static const green1 = Color(0xFF10B981);
  static const green2 = Color(0xFFE7F8F2);
  static const red1 = Color(0xFFE74C3C);
  static const pink1 = Color(0xFFF26969);

  static const lightColorScheme = ColorScheme.light(
    primary: black1,
    surface: grey1,
    secondary: grey2,
  );

  static const darkColorScheme = ColorScheme.dark();

}
