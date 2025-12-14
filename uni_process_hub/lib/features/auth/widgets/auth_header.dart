import 'package:flutter/material.dart';
import 'package:uni_process_hub/core/theme/app_color.dart';

enum AuthMode { login, register }

class AuthHeader extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;
  final AuthMode activeMode;
  final String title;
  final String subtitle;
  final String logoUrl;

  const AuthHeader({
    super.key,
    required this.onLoginPressed,
    required this.onRegisterPressed,
    required this.title,
    required this.subtitle,
    this.logoUrl =
        "https://lh3.googleusercontent.com/aida-public/AB6AXuCgNm_oYkXlRxLueiFt-bavcJkDYzBbKaNwZRjOiDlHxycNa1GFc3dcbaYSv3EXP4c8QUlF5TnnepulwiyyaCQnpkNs3xIPdGS8i0Yl_DB9qhgBhAFZXPG2tsjGtRNGaUvsmZRrtd_RhSUYWiALZiXiOgdzdnAFD27TLujKEfwTb_l1fwBVIgKQI7nKV-cnhbHkW7-vA5IYeKY1IPk6lqNnPdartP8ddv9u-5fWzvFgUwsIf5sTyKAi9eUb_XbAjO2NymumCjtM0TlO",
    required this.activeMode,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Logo
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isDark ? Colors.white10 : Colors.grey.shade300,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(
              logoUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.school, size: 48),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Title & Subtitle
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 24),
        // Toggle Buttons
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onLoginPressed,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: activeMode == AuthMode.login
                        ? AppColors.primary
                        : (isDark
                              ? Colors.grey.shade800
                              : Colors.grey.shade200),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: activeMode == AuthMode.login
                          ? Colors.black
                          : (isDark ? Colors.white70 : Colors.black87),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: onRegisterPressed,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: activeMode == AuthMode.register
                        ? AppColors.primary
                        : (isDark
                              ? Colors.grey.shade800
                              : Colors.grey.shade200),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: activeMode == AuthMode.register
                          ? Colors.black
                          : (isDark ? Colors.white70 : Colors.black87),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
