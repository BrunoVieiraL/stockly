import 'package:flutter/material.dart';
import 'package:stockly/ui/core/themes/theme.dart';

class SettingsViewmodel extends ChangeNotifier {
  bool isDark = false;
  ThemeData _themeData = AppTheme.lightTheme;
  ThemeData get themeData => _themeData;

  void toggleTheme() {
    isDark = !isDark;
    if (isDark) {
      _themeData = AppTheme.darkTheme;
    } else {
      _themeData = AppTheme.lightTheme;
    }
    notifyListeners();
  }
}
