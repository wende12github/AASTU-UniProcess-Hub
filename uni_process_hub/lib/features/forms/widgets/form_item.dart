import 'package:flutter/material.dart';

enum FormStatus { inProgress, reviewing, approved, notStarted }

class FormItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final FormStatus status;
  final double progress;

  FormItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.status,
    this.progress = 0,
  });
}
