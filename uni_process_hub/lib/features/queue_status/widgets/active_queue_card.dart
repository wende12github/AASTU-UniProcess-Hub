import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_process_hub/core/theme/app_color.dart';
import 'package:uni_process_hub/core/widgets/circular_queue_indecator.dart';
import 'package:uni_process_hub/features/queue_status/controller/queue_status_controller.dart';

class ActiveQueueCard extends StatelessWidget {
  const ActiveQueueCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<QueueStatusController>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
        ),
      ),
      padding: EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.circle, color: AppColors.primary, size: 12),
                      SizedBox(width: 8),
                      Text(
                        'Active Now',
                        style: TextStyle(
                          // fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Registrar Office',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Window 3 • Student Affairs Building',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreen,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.grey.shade800
                      : Color(0xFF131811).withValues(alpha: .6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.confirmation_number,
                  size: 28,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Center(
            child: CircularQueueIndicator(position: ctrl.position, size: 160),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Est. wait',
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.grey,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      ctrl.estWait,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ticket ID',
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.grey,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      ctrl.ticketId,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => ctrl.refreshStatus(),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Refresh Status'),
                ),
              ),
              SizedBox(width: 12),
              OutlinedButton(
                onPressed: () => ctrl.leaveQueue('userId'),
                child: Icon(Icons.logout, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
