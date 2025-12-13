import 'package:flutter/material.dart';
import 'package:uni_process_hub/core/widgets/app_bottom_nav.dart';
import 'package:uni_process_hub/features/forms/screens/digital_forms_screen.dart';
import 'package:uni_process_hub/features/profile/screens/profile_page_screen.dart';
import 'package:uni_process_hub/features/queue_status/ui/join_queue_screen.dart';
import 'package:uni_process_hub/features/queue_status/ui/queue_status_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _index = 0;

  final List<Widget> _screens = const [
    QueueStatusScreen(),
    DigitalFormsScreen(),
    JoinQueueScreen(),
    ProfilePageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: AppBottomNav(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
