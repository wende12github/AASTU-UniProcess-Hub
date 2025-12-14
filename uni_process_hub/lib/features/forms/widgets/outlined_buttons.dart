import 'package:flutter/material.dart';


class OutlinedButtons extends StatelessWidget {
  final String label;
  const OutlinedButtons({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
        side: const BorderSide(color: Color(0xFF49E619)),
      ),
      child: Text(label,
          style: const TextStyle(
              fontSize: 12, color: Color(0xFF49E619))),
    );
  }
}