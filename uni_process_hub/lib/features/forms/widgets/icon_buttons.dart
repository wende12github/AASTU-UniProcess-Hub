import 'package:flutter/material.dart';

class IconButtons extends StatelessWidget {
  final IconData icon;
  const IconButtons({required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(icon),
    );
  }
}
