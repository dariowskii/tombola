import 'package:flutter/material.dart';

class GameSessionScreen extends StatefulWidget {
  const GameSessionScreen({
    super.key,
    required this.sessionId,
    required this.raffleId,
  });

  final String sessionId;
  final String raffleId;

  @override
  State<GameSessionScreen> createState() => _GameSessionScreenState();
}

class _GameSessionScreenState extends State<GameSessionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sessione di gioco'),
      ),
      body: const Center(
        child: Text('Game'),
      ),
    );
  }
}
