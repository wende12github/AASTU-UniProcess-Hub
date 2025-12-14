import 'package:flutter/material.dart';
import 'package:uni_process_hub/features/forms/widgets/form_item.dart';
import 'package:uni_process_hub/features/forms/widgets/icon_buttons.dart';
import 'package:uni_process_hub/features/forms/widgets/outlined_buttons.dart';
import 'package:uni_process_hub/features/forms/widgets/primary_button.dart';
import 'package:uni_process_hub/features/forms/widgets/secondar_button.dart';

class FormCard extends StatelessWidget {
  final FormItem form;
  const FormCard({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color iconBg;
    Color iconColor;
    Widget trailing;

    switch (form.status) {
      case FormStatus.inProgress:
        iconBg = Colors.blue.withValues(alpha: .15);
        iconColor = Colors.blue;
        trailing = const PrimaryButton(label: 'Continue');
        break;
      case FormStatus.reviewing:
        iconBg = Colors.orange.withValues(alpha: .15);
        iconColor = Colors.orange;
        trailing = const SecondaryButton(label: 'View Details');
        break;
      case FormStatus.approved:
        iconBg = const Color(0xFF49E619).withValues(alpha: .2);
        iconColor = const Color(0xFF49E619);
        trailing = const IconButtons(icon: Icons.download);
        break;
      case FormStatus.notStarted:
        iconBg = Colors.grey.withValues(alpha: .2);
        iconColor = Colors.grey;
        trailing = const OutlinedButtons(label: 'Start');
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C2B18) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF2C3829) : Colors.grey.shade100,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(form.icon, color: iconColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      form.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      form.subtitle,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              trailing,
            ],
          ),
          if (form.status == FormStatus.inProgress) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: form.progress,
                minHeight: 6,
                backgroundColor: isDark
                    ? const Color(0xFF25361F)
                    : Colors.grey.shade200,
                color: const Color(0xFF49E619),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${(form.progress * 100).round()}% Completed',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }
}
