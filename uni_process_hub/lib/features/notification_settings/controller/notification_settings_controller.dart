import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../model/notification_settings_model.dart';
import '../repo/notification_settings_repo.dart';

class NotificationSettingsController extends ChangeNotifier {
  final NotificationSettingsRepo repo;
  NotificationSettingsModel? settings;
  StreamSubscription? _snapSub;
  bool loading = true;
  String? error;

  NotificationSettingsController({NotificationSettingsRepo? repo})
      : repo = repo ?? NotificationSettingsRepo() {
    _init();
  }

  Future<void> _init() async {
    loading = true;
    notifyListeners();

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        error = 'User not signed in';
        loading = false;
        notifyListeners();
        return;
      }

      // Listen to Firestore settings
      _snapSub = repo.watchSettings(user.uid).listen((snap) {
        if (snap.exists && snap.data() != null) {
          settings = NotificationSettingsModel.fromMap(snap.data()!);
        } else {
          // default model if not present
          settings = NotificationSettingsModel(
            allowAll: true,
            sound: true,
            vibration: true,
            dndEnabled: false,
            dndScheduled: true,
            dndStart: '22:00',
            dndEnd: '07:00',
            queueTurnApproaching: true,
            queueComeNow: true,
            formsStatus: true,
            formsComments: true,
            appointmentReminders: true,
            appointmentSlots: false,
          );
        }
        loading = false;
        notifyListeners();
      });

      // Initialize FCM (permissions and token)
      await _initFcm(user.uid);
    } catch (e, st) {
      error = e.toString();
      loading = false;
      notifyListeners();
    }
  }

  Future<void> _initFcm(String uid) async {
    try {
      final fcm = FirebaseMessaging.instance;

      // request permissions
      NotificationSettings perm = await fcm.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      // get token
      final token = await fcm.getToken();
      if (token != null) {
        await repo.saveFcmToken(uid, token);
      }

      // foreground handling is typically handled in app widget tree via onMessage
      FirebaseMessaging.onMessage.listen((message) {
        // optionally process/publish internal local notifications
        debugPrint('FCM foreground message: ${message.notification?.title}');
      });

      // background handler is registered in main()
    } catch (e) {
      debugPrint('FCM init error: $e');
    }
  }

  // Toggle helpers - each mutates local model and writes to Firestore
  Future<void> updateAllowAll(bool v) async {
    if (settings == null) return;
    settings!.allowAll = v;
    await _save();
  }

  Future<void> updateSound(bool v) async {
    if (settings == null) return;
    settings!.sound = v;
    await _save();
  }

  Future<void> updateVibration(bool v) async {
    if (settings == null) return;
    settings!.vibration = v;
    await _save();
  }

  Future<void> updateDndEnabled(bool v) async {
    if (settings == null) return;
    settings!.dndEnabled = v;
    await _save();
  }

  Future<void> updateDndScheduled(bool v) async {
    if (settings == null) return;
    settings!.dndScheduled = v;
    await _save();
  }

  Future<void> updateDndTimes(String start, String end) async {
    if (settings == null) return;
    settings!.dndStart = start;
    settings!.dndEnd = end;
    await _save();
  }

  Future<void> updateQueueTurnApproaching(bool v) async {
    if (settings == null) return;
    settings!.queueTurnApproaching = v;
    await _save();
  }

  Future<void> updateQueueComeNow(bool v) async {
    if (settings == null) return;
    settings!.queueComeNow = v;
    await _save();
  }

  Future<void> updateFormsStatus(bool v) async {
    if (settings == null) return;
    settings!.formsStatus = v;
    await _save();
  }

  Future<void> updateFormsComments(bool v) async {
    if (settings == null) return;
    settings!.formsComments = v;
    await _save();
  }

  Future<void> updateAppointmentReminders(bool v) async {
    if (settings == null) return;
    settings!.appointmentReminders = v;
    await _save();
  }

  Future<void> updateAppointmentSlots(bool v) async {
    if (settings == null) return;
    settings!.appointmentSlots = v;
    await _save();
  }

  Future<void> _save() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || settings == null) return;
    await repo.saveSettings(user.uid, settings!.toMap());
  }

  @override
  void dispose() {
    _snapSub?.cancel();
    super.dispose();
  }
}
