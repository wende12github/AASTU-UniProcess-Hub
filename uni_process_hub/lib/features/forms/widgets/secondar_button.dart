import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  const SecondaryButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.visibility, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}