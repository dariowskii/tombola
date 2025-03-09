import 'dart:async';
import 'dart:math';

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
  late Stream<DocumentSnapshot<Object?>>? _snapshot =
      FirebaseFirestore.instance.sessions.doc(widget.sessionId).snapshots();
  late StreamSubscription<DocumentSnapshot<Object?>>? _snapshotSubscription;

  GameSession? _gameSession;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _listenSnapshot();
    });
  }

  @override
  void dispose() {
    _historyScrollController.dispose();
    _snapshot = null;
    _snapshotSubscription?.cancel();
    _snapshotSubscription = null;
    super.dispose();
  }

  void _listenSnapshot() {
    _snapshotSubscription = _snapshot?.listen((event) {
      final sessionData = event.data() as Map<String, dynamic>;
      sessionData['id'] = event.id;

      final session = GameSession.fromJson(sessionData);
      setState(() {
        _gameSession = session;
        _animateHistoryScroll();
      });
    });
  }

  void _animateHistoryScroll() {
    Future.delayed(200.ms, () {
      if (!mounted) {
        return;
      }

      if (_historyScrollController.positions.isEmpty) {
        return;
      }

      _historyScrollController.animateTo(
        _historyScrollController.position.maxScrollExtent,
        duration: 500.ms,
        curve: Curves.easeOut,
      );
    });
  }

  void _extractNumber({
    required List<int> extractedNumbers,
  }) {
    if (extractedNumbers.length >= 90) {
      return;
    }

    if (extractedNumbers.isEmpty) {
      final random = Random();
      final number = random.nextInt(90) + 1;
      FirebaseFirestore.instance.sessions.doc(widget.sessionId).update({
        'extractedNumbers': FieldValue.arrayUnion([number]),
      });
      return;
    }

    final extractableNumbers = kExtractableNumbers
        .where(
          (element) => !extractedNumbers.contains(element),
        )
        .toList();

    extractableNumbers.shuffle();
    extractableNumbers.shuffle();

    final number = extractableNumbers.first;
    FirebaseFirestore.instance.sessions.doc(widget.sessionId).update({
      'extractedNumbers': FieldValue.arrayUnion([number]),
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameSession = _gameSession;
    if (gameSession == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tombola!'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseFirestore.instance.sessions.doc(widget.sessionId).update({
                'isActive': !gameSession.isActive,
              });
            },
            icon: Icon(gameSession.isActive ? Icons.stop : Icons.play_arrow),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(
          Spacing.medium.value,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                gameSession.eventName,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacing.medium.h,
              Text(
                'Codice: ${gameSession.id}',
                style: context.textTheme.bodySmall,
              ),
              Text(
                'Stato: ${gameSession.isActive ? 'Attiva' : 'Inattiva'}',
                style: context.textTheme.bodySmall,
              ),
              Spacing.medium.h,
              ExtractionHistory(
                extractedNumbers: gameSession.extractedNumbers,
                scrollController: _historyScrollController,
              ),
              Spacing.medium.h,
              MasterBingoTable(
                extractedNumbers: gameSession.extractedNumbers,
              ),
              Spacing.large.h,
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: !gameSession.isActive ||
                          gameSession.extractedNumbers.length >= 90
                      ? null
                      : () => _extractNumber(
                            extractedNumbers: gameSession.extractedNumbers,
                          ),
                  child: const Text('Estrai'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
