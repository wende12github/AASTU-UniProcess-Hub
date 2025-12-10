import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final Color primary = Color(0xFF49E619);

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: primary,
    scaffoldBackgroundColor: Color(0xFFF6F8F6),
    canvasColor: Colors.white,
    textTheme: GoogleFonts.manropeTextTheme(),
    appBarTheme: AppBarTheme(backgroundColor: Colors.white.withValues(alpha: .9)),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primary,
    scaffoldBackgroundColor: Color(0xFF152111),
    canvasColor: Color(0xFF131811),
    textTheme: GoogleFonts.manropeTextTheme(ThemeData.dark().textTheme),
    appBarTheme: AppBarTheme(backgroundColor: Color(0xFF131811).withValues(alpha: .9)),
    cardColor: Color(0xFF1E261C),
  );
}