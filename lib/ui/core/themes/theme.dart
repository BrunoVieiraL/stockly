import 'package:flutter/material.dart';
import 'package:stockly/ui/core/themes/colors.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: AppColors.lightColorScheme,
    brightness: Brightness.light,
    textTheme: _textThemeLight,
    inputDecorationTheme: _inputDecorationThemeLight,
    scaffoldBackgroundColor: AppColors.white1,
    navigationBarTheme: NavigationBarThemeData(
      iconTheme: WidgetStatePropertyAll(
        IconThemeData(color: AppColors.blue1),
      ),
      indicatorColor: AppColors.blue1.withAlpha(99),
      backgroundColor: Colors.white,
    ),
    iconTheme: IconThemeData(color: AppColors.green1),
    canvasColor: AppColors.green2,
    cardColor: Colors.white,
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStatePropertyAll(
        Color(0xFF636363),
      ),
    ),
    primaryColor: AppColors.black1,
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: AppColors.darkColorScheme,
    brightness: Brightness.dark,
    textTheme: _textThemeDark,
    inputDecorationTheme: _inputDecorationThemeDark,
    scaffoldBackgroundColor: AppColors.black1,
    iconTheme: IconThemeData(color: AppColors.green3),
    cardColor: AppColors.grey1,
    canvasColor: AppColors.green4,
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStatePropertyAll(AppColors.white),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.green4,
      selectedItemColor: AppColors.white,
    ),
    primaryColor: AppColors.white1,
    useMaterial3: true,
  );

  static const _textThemeLight = TextTheme(
    titleLarge: TextStyle(
      color: AppColors.black1,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      color: AppColors.black1,
    ),
    labelLarge: TextStyle(
      color: AppColors.black1,
      fontSize: 16,
    ),
    labelMedium: TextStyle(
      color: AppColors.black1,
    ),
  );

  static const _textThemeDark = TextTheme(
    titleLarge: TextStyle(
      color: AppColors.black1,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      color: AppColors.white1,
    ),
    labelLarge: TextStyle(
      color: AppColors.black1,
      fontSize: 16,
    ),
    labelMedium: TextStyle(
      color: AppColors.black1,
    ),
  );

  static const _inputDecorationThemeLight = InputDecorationTheme(
    hintStyle: TextStyle(
      color: AppColors.black,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  );

  static const _inputDecorationThemeDark = InputDecorationTheme(
    hintStyle: TextStyle(
      color: AppColors.white,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  );
}
