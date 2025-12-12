import 'package:flutter/material.dart';

class CircularQueueIndicator extends StatelessWidget {
  final int position;
  final int total;
  final double size;

  const CircularQueueIndicator({
    super.key,
    required this.position,
    this.total = 20,
    this.size = 160,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (position / (total == 0 ? 1 : total)).clamp(0.0, 1.0);
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: percent,
              strokeWidth: 8,
              backgroundColor: Colors.grey.shade800,
              valueColor: AlwaysStoppedAnimation(
                Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$position',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'In Line',
                style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
