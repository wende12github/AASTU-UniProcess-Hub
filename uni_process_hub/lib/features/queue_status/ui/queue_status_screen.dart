import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_process_hub/core/widgets/theme_toggle_icon.dart';
import 'package:uni_process_hub/features/notification_settings/widgets/approaching_turn_alert.dart';
import 'package:uni_process_hub/features/queue_status/controller/queue_status_controller.dart';
import 'package:uni_process_hub/features/queue_status/widgets/active_queue_card.dart';
import 'package:uni_process_hub/features/queue_status/widgets/quick_stats_row.dart';
import 'package:uni_process_hub/features/queue_status/widgets/recent_activity_item.dart';

class QueueStatusScreen extends StatefulWidget {
  const QueueStatusScreen({super.key});

  @override
  State<QueueStatusScreen> createState() => _QueueStatusScreenState();
}

class _QueueStatusScreenState extends State<QueueStatusScreen> {
  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<QueueStatusController>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuB-4tyDbTTehCvQeeEWhDME7Uh4kBRJI7dD8YW-yMl6zPizeWgsOqNykej9mrY3n-hl2K76cYs4ED7Owx_4gjQ1Vp42QPtDM3bA4LlxfDy7vWu2HRxFeNImeTmCzxyXrc90FhF4NEobjdSPkQ5oNj3V1TdJbfQPfPfervGIf20rvXCQTaU9nSFv4Mg2u6Zo2Fr3xXZ_5cGlmnP-SeNXae55QpKn7y4pDuv2JNUGUwTwIgrdwxSC_m7k_dH69jYYJe8aaIlb041fxMjH',
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Hello, Abebe',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          ThemeToggleIcon(),
          SizedBox(width: 6),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
            mouseCursor: SystemMouseCursors.contextMenu,
            padding: EdgeInsets.only(right: 12),
          ),
          // Padding(
          //   padding: EdgeInsets.only(right: 12.0),
          //   child: Icon(Icons.notifications),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Queue Status',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Live updates for your active tickets',
              style: TextStyle(color: isDark ? Colors.white : Colors.grey),
            ),
            const SizedBox(height: 14),
            const ActiveQueueCard(),
            const SizedBox(height: 14),
            const ApproachingTurnAlert(),
            const SizedBox(height: 14),
            const QuickStatsRow(),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: const [
                  SizedBox(height: 6),
                  RecentActivityItem(
                    title: 'Library Clearance',
                    subtitle: 'Oct 24 • Completed',
                    status: 'Done',
                  ),
                  SizedBox(height: 10),
                  RecentActivityItem(
                    title: 'Grade Report',
                    subtitle: 'Oct 20 • Missed',
                    status: 'Missed',
                  ),
                  SizedBox(height: 10),
                  RecentActivityItem(
                    title: 'Clinic Checkup',
                    subtitle: 'Sep 15 • Completed',
                    status: 'Done',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
