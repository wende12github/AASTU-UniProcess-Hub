import 'package:flutter/material.dart';

class ClearanceFormScreen extends StatelessWidget {
  const ClearanceFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clearance Form')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'Approval Progress',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(value: 0.33),
        ],
      ),
    );
  }
}
