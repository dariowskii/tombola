import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tombola/features/admin_game_session_screen/presentation/master_bingo_table.dart';
import 'package:tombola/models/game_session.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';
import 'package:tombola/widgets/extraction_history.dart';

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
  late final _historyScrollController = ScrollController();

  void _animateHistoryScroll() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_historyScrollController.positions.isEmpty) {
        return;
      }

      _historyScrollController.animateTo(
        _historyScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tombola!'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.sessions
            .doc(widget.sessionId)
            .snapshots(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasError) {
            return Center(
              child: Text(
                'Errore: ${asyncSnapshot.error}',
                style: context.textTheme.bodyLarge,
              ),
            );
          }

          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!asyncSnapshot.hasData) {
            return const Center(
              child: Text('Sessione non trovata'),
            );
          }

          final sessionData =
              asyncSnapshot.data!.data() as Map<String, dynamic>;
          sessionData['id'] = asyncSnapshot.data!.id;

          final session = GameSession.fromJson(sessionData);

          _animateHistoryScroll();

          return Padding(
            padding: EdgeInsets.all(
              Spacing.medium.value,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.eventName,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacing.medium.h,
                Text('Codice: ${session.id}'),
                Text('Stato: ${session.isActive ? 'Attiva' : 'Inattiva'}'),
                Spacing.medium.h,
                ExtractionHistory(
                  extractedNumbers: session.extractedNumbers,
                  scrollController: _historyScrollController,
                ),
                Spacing.medium.h,
                MasterBingoTable(
                  extractedNumbers: session.extractedNumbers,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
