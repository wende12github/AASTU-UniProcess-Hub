import 'package:flutter/material.dart';

class JoinQueueScreen extends StatelessWidget {
  const JoinQueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join Queue Screen'),
      ),
      body: Center(
        child: Text('Welcome to the Join Queue Screen!'),
      ),
    );
  }
}