import 'package:flutter/material.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNavBar({required this.currentIndex, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: isDark ? Color(0xFF41533C).withValues(alpha: .3) : Colors.grey.shade200)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: isDark ? Color(0xFF131811).withValues(alpha: .9) : Colors.white.withValues(alpha: .9),
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey.shade500,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Forms'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Booking'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}