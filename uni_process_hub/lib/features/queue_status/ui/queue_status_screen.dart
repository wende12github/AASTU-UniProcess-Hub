import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<QueueStatusController>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final user = _auth.currentUser;
    if (user == null) {
      return const Center(child: Text('User not logged in'));
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: _firestore.collection('users').doc(user.uid).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Text('Loading...');
            }

            final data = snapshot.data!.data()!;
            final fullName = data['fullName'] ?? 'Student';
            final photoUrl = data['profileImageUrl'] ?? '';

            return Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: photoUrl.isNotEmpty
                      ? NetworkImage(photoUrl)
                      : const AssetImage('assets/images/pngwing.png')
                            as ImageProvider,
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
                    const SizedBox(height: 4),
                    Text(
                      'Hello, $fullName',
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
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
