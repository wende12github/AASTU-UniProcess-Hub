import 'package:flutter/material.dart';

final ThemeData darkThemeData = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF283593),
  scaffoldBackgroundColor: const Color(0xFF131811),
  fontFamily: 'Manrope',
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF131811).withOpacity(0.9),
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),
  colorScheme: ColorScheme.dark().copyWith(secondary: const Color(0xFF49e619)),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF49e619),
  ),
);
