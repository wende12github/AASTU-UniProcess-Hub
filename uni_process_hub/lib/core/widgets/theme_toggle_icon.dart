import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_process_hub/core/theme/app_theme.dart';

class ThemeToggleIcon extends StatelessWidget {
  const ThemeToggleIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);
    return IconButton(
      icon: Icon(theme.isDark ? Icons.dark_mode : Icons.light_mode),
      onPressed: () => theme.toggleTheme(),
    );
  }
}
