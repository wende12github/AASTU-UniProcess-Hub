import 'package:flutter/material.dart';
import 'package:uni_process_hub/core/theme/app_color.dart';
import 'package:uni_process_hub/features/forms/widgets/active_form_list.dart';
import 'package:uni_process_hub/features/forms/widgets/filter_chips.dart';
import 'package:uni_process_hub/features/forms/widgets/stats_card.dart';

class DigitalFormsScreen extends StatelessWidget {
  const DigitalFormsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF131811)
          : const Color(0xFFF6F8F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDark ? const Color(0xFF131811) : Colors.white,
        title: const Text(
          'Digital Forms',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF49E619),
        foregroundColor: Colors.black,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 16, bottom: 24),
          children: [
            SizedBox(
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  StatsCard(
                    title: 'Pending',
                    count: '2',
                    icon: Icons.hourglass_top,
                    color: Colors.amber,
                  ),
                  StatsCard(
                    title: 'Approved',
                    count: '5',
                    icon: Icons.check_circle,
                    color: AppColors.primary,
                  ),
                  StatsCard(
                    title: 'Rejected',
                    count: '1',
                    icon: Icons.hourglass_top,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FilterChips(),
            const SizedBox(height: 20),
            ActiveFormsList(),
          ],
        ),
      ),
    );
  }
}
