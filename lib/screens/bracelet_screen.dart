import 'package:flutter/material.dart';

class BraceletScreen extends StatelessWidget {
  const BraceletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Bracelet Screen', style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
