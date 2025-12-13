import 'package:flutter/material.dart';
import 'package:uni_process_hub/core/theme/app_color.dart';
import 'package:uni_process_hub/features/notification_settings/ui/notification_settings_screen.dart';

class ApproachingTurnAlert extends StatelessWidget {

  const ApproachingTurnAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationSettingsScreen(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF2A3626),
          borderRadius: BorderRadius.circular(16),
          border: Border(
            left: BorderSide(color: AppColors.primary, width: 4),
          ),
        ),
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary.withValues(alpha: .2),
              child: Icon(
                Icons.notifications_active,
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Stay Nearby!",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Your turn is approaching. Please head to the waiting area.",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
