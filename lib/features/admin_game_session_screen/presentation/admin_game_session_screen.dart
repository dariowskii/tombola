import 'package:flutter/material.dart';

class AdminGameSessionScreen extends StatefulWidget {
  const AdminGameSessionScreen({
    super.key,
    required this.sessionId,
  });

  final String sessionId;

  @override
  State<AdminGameSessionScreen> createState() => _AdminGameSessionScreenState();
}

class _AdminGameSessionScreenState extends State<AdminGameSessionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sessione amministratore'),
      ),
      body: const Center(
        child: Text('Sessione amministratore'),
      ),
    );
  }
}
