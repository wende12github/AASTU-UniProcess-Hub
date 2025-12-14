import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationSettingsModel {
  bool allowAll;
  bool sound;
  bool vibration;
  bool dndEnabled;
  bool dndScheduled;
  String dndStart; // "22:00"
  String dndEnd;   // "07:00"
  bool queueTurnApproaching;
  bool queueComeNow;
  bool formsStatus;
  bool formsComments;
  bool appointmentReminders;
  bool appointmentSlots;
  Timestamp? updatedAt;

  NotificationSettingsModel({
    required this.allowAll,
    required this.sound,
    required this.vibration,
    required this.dndEnabled,
    required this.dndScheduled,
    required this.dndStart,
    required this.dndEnd,
    required this.queueTurnApproaching,
    required this.queueComeNow,
    required this.formsStatus,
    required this.formsComments,
    required this.appointmentReminders,
    required this.appointmentSlots,
    this.updatedAt,
  });

  factory NotificationSettingsModel.fromMap(Map<String, dynamic> map) {
    return NotificationSettingsModel(
      allowAll: map['allowAll'] ?? true,
      sound: map['sound'] ?? true,
      vibration: map['vibration'] ?? true,
      dndEnabled: map['dndEnabled'] ?? false,
      dndScheduled: map['dndScheduled'] ?? true,
      dndStart: map['dndStart'] ?? '22:00',
      dndEnd: map['dndEnd'] ?? '07:00',
      queueTurnApproaching: map['queue_turn_approaching'] ?? true,
      queueComeNow: map['queue_come_now'] ?? true,
      formsStatus: map['forms_status'] ?? true,
      formsComments: map['forms_comments'] ?? true,
      appointmentReminders: map['appointment_reminders'] ?? true,
      appointmentSlots: map['appointment_slots'] ?? false,
      updatedAt: map['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'allowAll': allowAll,
      'sound': sound,
      'vibration': vibration,
      'dndEnabled': dndEnabled,
      'dndScheduled': dndScheduled,
      'dndStart': dndStart,
      'dndEnd': dndEnd,
      'queue_turn_approaching': queueTurnApproaching,
      'queue_come_now': queueComeNow,
      'forms_status': formsStatus,
      'forms_comments': formsComments,
      'appointment_reminders': appointmentReminders,
      'appointment_slots': appointmentSlots,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
