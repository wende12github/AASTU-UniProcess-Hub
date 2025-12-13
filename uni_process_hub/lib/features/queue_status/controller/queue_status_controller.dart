import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QueueStatusController extends ChangeNotifier {
  // Placeholder fields
  int position = 5;
  int total = 20;
  String ticketId = 'A-102';
  String estWait = '15 mins';

  // Firestore reference (assumes firebase initialized)
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Listen to a user's queue document
  Stream<DocumentSnapshot<Map<String, dynamic>>> listenToUserQueue(
    String userId,
  ) {
    return _db.collection('students').doc(userId).snapshots();
  }

  Future<void> refreshStatus() async {
    // TODO: fetch from Firestore the current queue status for the logged user
    // Simulate delay
    await Future.delayed(const Duration(milliseconds: 500));
    // Update dummy values
    position = (position - 1).clamp(1, total);
    notifyListeners();
  }

  Future<void> leaveQueue(String userId) async {
    // TODO: remove student from queue in Firestore
    // Example: await _db.collection('queues').doc('registrar').collection('items').doc(userId).delete();
    position = 999; // mark as left
    notifyListeners();
  }
}
