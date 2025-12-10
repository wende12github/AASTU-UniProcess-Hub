import 'package:flutter/material.dart';
import 'package:uni_process_hub/screens/booking_screen.dart';
import 'package:uni_process_hub/screens/forms_screen.dart';
import 'package:uni_process_hub/screens/home_screen.dart';
import 'package:uni_process_hub/screens/profile_screen.dart';
import 'package:uni_process_hub/widgets/bottom_nav_bar.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AASTU UniProcess Hub',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: MainScaffold(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    FormsScreen(),
    BookingScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}