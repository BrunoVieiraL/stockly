import 'package:flutter/material.dart';
import 'package:stockly/ui/core/themes/colors.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: AppColors.lightColorScheme,
    brightness: Brightness.light,
    textTheme: _textTheme,
    inputDecorationTheme: _inputDecorationTheme,
    scaffoldBackgroundColor: AppColors.white1,
    navigationBarTheme: NavigationBarThemeData(
      iconTheme: WidgetStatePropertyAll(
        IconThemeData(color: AppColors.black1),
      ),
      indicatorColor: AppColors.black1.withAlpha(99),
      backgroundColor: Colors.white,
    ),
    iconTheme: IconThemeData(color: AppColors.green1),
    cardColor: Colors.white,
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStatePropertyAll(
        Color(0xFF636363),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: AppColors.darkColorScheme,
    brightness: Brightness.dark,
    textTheme: _textTheme,
    inputDecorationTheme: _inputDecorationTheme,
  );

  static const _textTheme = TextTheme();

  static const _inputDecorationTheme = InputDecorationTheme(
    hintStyle: TextStyle(
      color: AppColors.grey3,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  );
}
