import 'package:flutter/material.dart';

class FormsScreen extends StatelessWidget {
  const FormsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forms Screen'),
      ),
      body: Center(
        child: Text('Welcome to the Forms Screen!'),
      ),
    );
  }
}