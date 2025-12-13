import 'package:flutter/material.dart';
import 'package:uni_process_hub/features/forms/widgets/form_card.dart';
import 'package:uni_process_hub/features/forms/widgets/form_item.dart';

class ActiveFormsList extends StatelessWidget {
  const ActiveFormsList({super.key});

  @override
  Widget build(BuildContext context) {
    final forms = [
      FormItem(
        title: 'Cost-Sharing Form',
        subtitle: 'Due: Oct 30, 2023',
        icon: Icons.school,
        status: FormStatus.inProgress,
        progress: 0.65,
      ),
      FormItem(
        title: 'Application Form',
        subtitle: 'Submitted: Oct 12, 2023',
        icon: Icons.article,
        status: FormStatus.reviewing,
      ),
      FormItem(
        title: 'Clearance Form',
        subtitle: 'Approved on Sep 15',
        icon: Icons.verified,
        status: FormStatus.approved,
      ),
      FormItem(
        title: 'Dormitory Request',
        subtitle: 'Deadline: Nov 01',
        icon: Icons.bedroom_parent,
        status: FormStatus.notStarted,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: forms.map((f) => FormCard(form: f)).toList(),
      ),
    );
  }
}
