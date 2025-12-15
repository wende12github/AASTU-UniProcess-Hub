import 'package:flutter/material.dart';
import 'package:uni_process_hub/core/theme/app_color.dart';

class ActivitySection extends StatelessWidget {
  const ActivitySection({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Activity',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _activityCard(
                  context,
                  'Queues',
                  '12 Past',
                  Icons.history,
                  Colors.blue,
                ),
                const SizedBox(width: 12),
                _activityCard(
                  context,
                  'Forms',
                  '3 Submitted',
                  Icons.assignment,
                  Colors.orange,
                ),
                const SizedBox(width: 12),
                _activityCard(
                  context,
                  'Appointments',
                  '1 Upcoming',
                  Icons.calendar_month,
                  Colors.purple,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _activityCard(
    BuildContext context,
    String title,
    String sub,
    IconData icon,
    Color color,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.surfaceDark : Colors.white;

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.white10 : Colors.grey.shade100,
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(
              sub,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? const Color(0xFFA4B89D) : Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
