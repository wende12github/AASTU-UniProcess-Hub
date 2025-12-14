import 'package:flutter/material.dart';
import 'package:uni_process_hub/core/theme/app_color.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.surfaceDark : Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? Colors.white10 : Colors.grey.shade100,
              ),
            ),
            child: Column(
              children: [
                _row(
                  Icons.lock_reset,
                  'Change Password',
                  'Update your security credentials',
                  true,
                ),
                _divider(isDark),
                _row(
                  Icons.notifications_active,
                  'Notifications',
                  'Manage alerts and messages',
                  true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(IconData icon, String title, String subtitle, bool trailing) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[100],
        ),
        child: Icon(icon, color: Colors.grey[600]),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }

  Widget _divider(bool isDark) =>
      Divider(height: 1, color: isDark ? Colors.white10 : Colors.grey.shade100);
}
