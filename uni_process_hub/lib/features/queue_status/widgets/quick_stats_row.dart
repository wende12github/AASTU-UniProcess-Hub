import 'package:flutter/material.dart';

class QuickStatsRow extends StatelessWidget {
  final String avgWait;
  final int ahead;
  final String speed;
  const QuickStatsRow({
    Key? key,
    this.avgWait = '12m',
    this.ahead = 4,
    this.speed = 'Fast',
  }) : super(key: key);

  Widget statCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1e261c),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey, size: 20),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: statCard('Avg Wait', avgWait, Icons.history)),
        const SizedBox(width: 8),
        Expanded(child: statCard('Ahead', '$ahead ppl', Icons.group)),
        const SizedBox(width: 8),
        Expanded(child: statCard('Speed', speed, Icons.speed)),
      ],
    );
  }
}
