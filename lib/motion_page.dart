import 'package:flutter/material.dart';

class MotionPage extends StatelessWidget {
  const MotionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Motion'),
        backgroundColor: const Color(0xFFFEE715),
      ),
      body: const Center(
        child: Text('Motion Page'),
      ),
      backgroundColor: const Color(0xFF101820),
    );
  }
}
