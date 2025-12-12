import 'package:flutter/material.dart';

final Color primaryColor = const Color(0xFF3F51B5);
final Color primaryLight = const Color(0xFFE8EAF6);

final ThemeData lightThemeData = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Manrope',
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white.withOpacity(0.9),
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black87),
    titleTextStyle: const TextStyle(
      color: Colors.black87,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.indigo,
  ).copyWith(secondary: primaryColor),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
  ),
);
