// lib/theme/app_colors.dart

import 'package:flutter/material.dart';

class AppColors {
  // Primary Green
  static const Color primary = Color(0xFF49E619);

  // Light Theme
  static const Color backgroundLight = Color(0xFFF6F8F6);
  static const Color surfaceLight = Colors.white;
  static const Color onBackgroundLight = Color(0xFF1E1E1E);
  static const Color onSurfaceLight = Color(0xFF1E1E1E);
  

  // utility
  static const Color slate500 = Color(0xFF6B7280);
  static const Color slate400 = Color(0xFF9CA3AF);

  // Dark Theme
  static const Color backgroundDark = Color(0xFF152111);
  static const Color surfaceDark = Color(0xFF1E261C);
  static const Color surfaceDarker = Color(0xFF131811);
  static const Color surfaceBorderDark = Color(0xFF41533C);

  // Text / Accents (Dark mode)
  static const Color textSecondaryDark = Color(0xFFA4B89D);
  static const Color textTertiaryDark = Color(0xFF6F8569);

  // Effects
  static const Color primaryGlow = Color.fromRGBO(73, 230, 25, 0.3);

  // Status Colors
  static const Color success = Colors.green;
  static const Color warning = Colors.orange;
  static const Color error = Colors.red;
}