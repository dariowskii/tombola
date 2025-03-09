import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to the app!'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the home screen
          },
          child: const Text('Get started!'),
        ),
      ),
    );
  }
}
