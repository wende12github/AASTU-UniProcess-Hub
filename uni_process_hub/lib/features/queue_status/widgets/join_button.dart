import 'package:flutter/material.dart';

class JoinButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool disabled;
  final bool highlighted;

  const JoinButton({
    super.key,
    required this.onPressed,
    this.disabled = false,
    this.highlighted = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color primary = const Color(0xFF49E619);

    if (disabled) {
      return ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF131811) : Colors.grey[200],
          foregroundColor: Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Text('Queue Unavailable', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: highlighted ? primary : (Theme.of(context).brightness == Brightness.dark ? const Color(0xFF2A3626) : Colors.grey[50]),
        foregroundColor: highlighted ? const Color(0xFF131811) : primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        shadowColor: primary.withOpacity(0.25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Join Queue', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward, size: 18, color: highlighted ? const Color(0xFF131811) : primary),
          ],
        ),
      ),
    );
  }
}
