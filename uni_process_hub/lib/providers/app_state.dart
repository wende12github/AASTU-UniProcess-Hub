// lib/providers/app_state.dart

import 'package:flutter/material.dart';

class QueueItem {
  final String serviceName;
  final String ticketId;
  final int position;
  final DateTime joinedAt;
  final int estimatedWaitMinutes;

  QueueItem({
    required this.serviceName,
    required this.ticketId,
    required this.position,
    required this.joinedAt,
    required this.estimatedWaitMinutes,
  });
}

class Appointment {
  final String office;
  final DateTime dateTime;
  final String? reason;

  Appointment({
    required this.office,
    required this.dateTime,
    this.reason,
  });
}

class AppState extends ChangeNotifier {
  // Bottom Navigation
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  void setSelectedIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }

  // Theme
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
    }
  }

  // User Profile
  String _userName = "Abebe";
  String get userName => _userName;
  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  final String userId = "ETS/1234/12";
  final String department = "Software Engineering";
  final String year = "3rd Year";
  final double cgpa = 3.82;

  // Active Queue
  QueueItem? _activeQueue;
  QueueItem? get activeQueue => _activeQueue;
  bool get hasActiveQueue => _activeQueue != null;

  void joinQueue(QueueItem queue) {
    _activeQueue = queue;
    notifyListeners();
  }

  void leaveQueue() {
    _activeQueue = null;
    notifyListeners();
  }

  void updateQueuePosition(int newPosition) {
    if (_activeQueue != null) {
      _activeQueue = QueueItem(
        serviceName: _activeQueue!.serviceName,
        ticketId: _activeQueue!.ticketId,
        position: newPosition,
        joinedAt: _activeQueue!.joinedAt,
        estimatedWaitMinutes: _activeQueue!.estimatedWaitMinutes,
      );
      notifyListeners();
    }
  }

  // Recent Activity / History
  final List<QueueItem> queueHistory = [
    QueueItem(
      serviceName: "Library Clearance",
      ticketId: "L-045",
      position: 0,
      joinedAt: DateTime(2025, 10, 24),
      estimatedWaitMinutes: 8,
    ),
    QueueItem(
      serviceName: "Grade Report",
      ticketId: "R-089",
      position: 0,
      joinedAt: DateTime(2025, 10, 20),
      estimatedWaitMinutes: 20,
    ),
    // Add more as needed
  ];

  // Appointments
  final List<Appointment> _appointments = [
    Appointment(
      office: "Registrar",
      dateTime: DateTime(2025, 12, 15, 10, 30),
      reason: "Grade correction request",
    ),
  ];

  List<Appointment> get appointments => List.unmodifiable(_appointments);
  List<Appointment> get upcomingAppointments =>
      _appointments.where((a) => a.dateTime.isAfter(DateTime.now())).toList();

  void addAppointment(Appointment appointment) {
    _appointments.add(appointment);
    notifyListeners();
  }

  void removeAppointment(Appointment appointment) {
    _appointments.remove(appointment);
    notifyListeners();
  }

  // Notifications (badge count)
  int _notificationCount = 3;
  int get notificationCount => _notificationCount;

  void addNotification() {
    _notificationCount++;
    notifyListeners();
  }

  void clearNotifications() {
    _notificationCount = 0;
    notifyListeners();
  }

  // Forms submitted count (for Profile activity cards)
  int _submittedForms = 3;
  int get submittedForms => _submittedForms;
  void incrementSubmittedForms() {
    _submittedForms++;
    notifyListeners();
  }
}