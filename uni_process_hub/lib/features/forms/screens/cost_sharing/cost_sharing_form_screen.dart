import 'package:flutter/material.dart';

class CostSharingFormScreen extends StatelessWidget {
  const CostSharingFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cost‑Sharing Form')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'Student Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              labelText: 'Full Name',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          SizedBox(height: 12),
          TextField(decoration: InputDecoration(labelText: 'Student ID')),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(labelText: 'Year'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('Save Draft'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Submit Form'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
