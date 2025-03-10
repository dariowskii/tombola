import 'package:flutter/material.dart';

class GameSessionScreen extends StatelessWidget {
  const GameSessionScreen({
    super.key,
    required this.sessionId,
    required this.raffleId,
  });

  final String sessionId;
  final String raffleId;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Game'),
      ),
    );
  }
}
