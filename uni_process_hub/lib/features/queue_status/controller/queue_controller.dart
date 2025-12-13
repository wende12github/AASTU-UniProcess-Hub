import 'package:flutter/material.dart';
import 'package:uni_process_hub/features/model/service_model.dart';

class QueueController extends ChangeNotifier {
  final List<ServiceModels> services = [
    ServiceModels(
      id: 'registrar',
      title: 'Registrar Office',
      subtitle: 'Window 1-4 • Admin Bldg',
      description:
          'Handles student registration, grade report issuance, academic record corrections, and readmission requests.',
      hours: '8:30 AM - 4:30 PM',
      avgService: '~15 mins / person',
      peopleInLine: 14,
      waitTime: '25 min',
      badge: 'Open',
      expanded: true,
    ),
    ServiceModels(
      id: 'clinic',
      title: 'Student Clinic',
      subtitle: 'OPD • Ground Floor',
      description: 'Primary health services for students.',
      hours: '8:30 AM - 4:30 PM',
      avgService: '10 min / person',
      peopleInLine: 3,
      waitTime: '10 min',
      badge: 'Open',
    ),
    ServiceModels(
      id: 'library',
      title: 'Library Services',
      subtitle: 'Book Return & Loan',
      description: 'Borrowing, returns and loan services.',
      hours: '8:30 AM - 6:00 PM',
      avgService: '< 5 mins / person',
      peopleInLine: 1,
      waitTime: '< 5 min',
      badge: 'Fast',
    ),
    ServiceModels(
      id: 'cafeteria',
      title: 'Student Cafeteria',
      subtitle: 'Lunch Service',
      description: 'Daily lunch service for students.',
      hours: '11:00 AM - 2:00 PM',
      avgService: 'Varies',
      peopleInLine: 82,
      waitTime: '45 min',
      badge: 'Busy',
    ),
    ServiceModels(
      id: 'discipline',
      title: 'Discipline Office',
      subtitle: 'Opens at 2:00 PM',
      description: 'Discipline related inquiries.',
      hours: 'Opens at 2:00 PM',
      avgService: '--',
      peopleInLine: 0,
      waitTime: '--',
      badge: 'Closed',
      disabled: true,
    ),
  ];

  String searchQuery = '';

  List<ServiceModels> get filtered => searchQuery.isEmpty
      ? services
      : services
          .where((s) =>
              s.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
              s.subtitle.toLowerCase().contains(searchQuery.toLowerCase()) ||
              s.description.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();

  void toggleExpand(String id) {
    final idx = services.indexWhere((s) => s.id == id);
    if (idx == -1) return;
    services[idx].expanded = !services[idx].expanded;
    notifyListeners();
  }

  void updateSearch(String v) {
    searchQuery = v;
    notifyListeners();
  }

  Future<void> joinQueue(ServiceModels s) async {
    if (s.disabled) return;
    // TODO: connect to Firestore queue creation
    debugPrint('Join queue requested for ${s.title}');
  }
}
