import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

class AppTheme extends ChangeNotifier {
  static const _prefKey = 'isDarkMode';
  ThemeMode _themeMode = ThemeMode.system;

  AppTheme() {
    _loadFromPrefs();
  }

  ThemeMode get themeMode => _themeMode;
  ThemeData get lightTheme => lightThemeData;
  ThemeData get darkTheme => darkThemeData;

  bool get isDark => _themeMode == ThemeMode.dark;

  Future<void> toggleTheme() async {
    _themeMode = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_prefKey, isDark);
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool(_prefKey);
    if (saved != null) {
      _themeMode = saved ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }
}
