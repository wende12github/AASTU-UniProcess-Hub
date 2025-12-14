import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  
  const PrimaryButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF49E619),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      onPressed: () {},
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}




