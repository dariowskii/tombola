import 'package:flutter/material.dart';

class SetupGameScreen extends StatelessWidget {
  const SetupGameScreen({
    super.key,
    required this.sessionId,
  });

  final String sessionId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup Game'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Start Game'),
        ),
      ),
    );
  }
}
