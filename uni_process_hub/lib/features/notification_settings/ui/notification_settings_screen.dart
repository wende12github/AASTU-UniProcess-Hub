import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/notification_settings_controller.dart';
import '../widgets/section_controller.dart';
import '../widgets/toggle_row.dart';
import '../widgets/dnd_row.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationSettingsController>(
      create: (_) => NotificationSettingsController(),
      child: Consumer<NotificationSettingsController>(
        builder: (context, ctrl, _) {
          if (ctrl.loading) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (ctrl.error != null) {
            return Scaffold(body: Center(child: Text('Error: ${ctrl.error}')));
          }
          final s = ctrl.settings!;
          final isDark = Theme.of(context).brightness == Brightness.dark;
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: isDark ? Colors.white : Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: const Text('Notification Settings', style: TextStyle(fontWeight: FontWeight.bold)),
              actions: [
                TextButton(
                  onPressed: () async {
                    // Save is automatic via repository; but we can force a save
                    ctrl._save(); // note: make _save public if you prefer; here I call via method name for clarity
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Settings saved')));
                  },
                  child: const Text('Save', style: TextStyle(color: Color(0xFF49E619), fontWeight: FontWeight.bold)),
                )
              ],
              backgroundColor: isDark ? const Color(0xFF152111) : Colors.white.withValues(alpha: .9),
              elevation: 0,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Allow all toggle
                    SectionContainer(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(color: isDark ? const Color(0xFF2C3829) : Colors.grey[100], borderRadius: BorderRadius.circular(12)),
                              child: Icon(Icons.notifications_active, color: isDark ? Colors.white : const Color(0xFF49E619)),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                const Text('Allow All Notifications', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                                const SizedBox(height: 4),
                                Text('Pause all push notifications', style: TextStyle(fontSize: 12, color: isDark ? const Color(0xFFA4B89D) : Colors.grey)),
                              ]),
                            ),
                            Switch.adaptive(
                              value: s.allowAll,
                              onChanged: (v) => ctrl.updateAllowAll(v),
                              activeThumbColor: const Color(0xFF49E619),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Alert Preferences
                    const Align(alignment: Alignment.centerLeft, child: Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Alert Preferences', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)))),
                    SectionContainer(
                      child: Column(
                        children: [
                          ToggleRow(
                            icon: Icons.music_note,
                            title: 'Sound',
                            subtitle: 'Default (Note)',
                            value: s.sound,
                            onChanged: (v) => ctrl.updateSound(v),
                          ),
                          Divider(height: 1, color: isDark ? Colors.white10 : Colors.grey.shade100),
                          ToggleRow(
                            icon: Icons.vibration,
                            title: 'Vibration',
                            subtitle: 'Vibrate on alert',
                            value: s.vibration,
                            onChanged: (v) => ctrl.updateVibration(v),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Do Not Disturb
                    const Align(alignment: Alignment.centerLeft, child: Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Do Not Disturb', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)))),
                    SectionContainer(
                      child: Column(
                        children: [
                          DndRow(
                            label: 'Do Not Disturb',
                            timeframe: 'Silence all notifications',
                            value: s.dndEnabled,
                            onToggle: (v) => ctrl.updateDndEnabled(v),
                            onPickTime: () async {
                              final times = await _pickDndRange(context, s.dndStart, s.dndEnd);
                              if (times != null) await ctrl.updateDndTimes(times.item1, times.item2);
                            },
                          ),
                          Divider(height: 1, color: isDark ? Colors.white10 : Colors.grey.shade100),
                          DndRow(
                            label: 'Scheduled',
                            timeframe: '${s.dndStart} - ${s.dndEnd}',
                            value: s.dndScheduled,
                            onToggle: (v) => ctrl.updateDndScheduled(v),
                            onPickTime: () async {
                              final times = await _pickDndRange(context, s.dndStart, s.dndEnd);
                              if (times != null) await ctrl.updateDndTimes(times.item1, times.item2);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Queue Notifications
                    const Align(alignment: Alignment.centerLeft, child: Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Queue Notifications', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)))),
                    SectionContainer(
                      child: Column(
                        children: [
                          ToggleRow(
                            icon: Icons.hourglass_top,
                            title: 'Turn Approaching',
                            subtitle: 'Alert when 3rd in line',
                            value: s.queueTurnApproaching,
                            onChanged: (v) => ctrl.updateQueueTurnApproaching(v),
                          ),
                          Divider(height: 1, color: isDark ? Colors.white10 : Colors.grey.shade100),
                          ToggleRow(
                            icon: Icons.campaign,
                            title: 'Come Now',
                            subtitle: 'Urgent turn notification',
                            value: s.queueComeNow,
                            onChanged: (v) => ctrl.updateQueueComeNow(v),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Form Notifications
                    const Align(alignment: Alignment.centerLeft, child: Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Form Notifications', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)))),
                    SectionContainer(
                      child: Column(
                        children: [
                          ToggleRow(
                            icon: Icons.fact_check,
                            title: 'Status Updates',
                            subtitle: 'Approved/Rejected alerts',
                            value: s.formsStatus,
                            onChanged: (v) => ctrl.updateFormsStatus(v),
                          ),
                          Divider(height: 1, color: isDark ? Colors.white10 : Colors.grey.shade100),
                          ToggleRow(
                            icon: Icons.chat,
                            title: 'Admin Comments',
                            subtitle: 'Feedback on submissions',
                            value: s.formsComments,
                            onChanged: (v) => ctrl.updateFormsComments(v),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Appointment Notifications
                    const Align(alignment: Alignment.centerLeft, child: Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Appointment Notifications', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)))),
                    SectionContainer(
                      child: Column(
                        children: [
                          ToggleRow(
                            icon: Icons.event_available,
                            title: 'Reminders',
                            subtitle: '15 mins before time',
                            value: s.appointmentReminders,
                            onChanged: (v) => ctrl.updateAppointmentReminders(v),
                          ),
                          Divider(height: 1, color: isDark ? Colors.white10 : Colors.grey.shade100),
                          ToggleRow(
                            icon: Icons.add_circle,
                            title: 'New Slots Available',
                            subtitle: 'Notify when slots open',
                            value: s.appointmentSlots,
                            onChanged: (v) => ctrl.updateAppointmentSlots(v),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.info, size: 18, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'System alerts regarding security or AASTU account status cannot be disabled. To change email preferences, please visit the web portal.',
                              style: TextStyle(fontSize: 12, color: isDark ? const Color(0xFFA4B89D) : Colors.grey[600]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // helper to pick DnD range - returns Tuple2<String start, String end> or null
  static Future<Tuple2<String, String>?> _pickDndRange(BuildContext context, String start, String end) async {
    // Convert existing times to TimeOfDay
    TimeOfDay tStart = _fromString(start);
    TimeOfDay tEnd = _fromString(end);

    final pickedStart = await showTimePicker(context: context, initialTime: tStart);
    if (pickedStart == null) return null;
    final pickedEnd = await showTimePicker(context: context, initialTime: tEnd);
    if (pickedEnd == null) return null;

    String s = _format(pickedStart);
    String e = _format(pickedEnd);
    return Tuple2(s, e);
  }

  static TimeOfDay _fromString(String s) {
    final parts = s.split(':');
    final h = int.tryParse(parts[0]) ?? 22;
    final m = int.tryParse(parts[1]) ?? 0;
    return TimeOfDay(hour: h, minute: m);
  }

  static String _format(TimeOfDay t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

extension on NotificationSettingsController {
  Future<void> _save() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || settings == null) return;
    await repo.saveSettings(user.uid, settings!.toMap());
  }
}

// Simple Tuple2 used here to return start/end times
class Tuple2<T1, T2> {
  final T1 item1;
  final T2 item2;
  Tuple2(this.item1, this.item2);
}
