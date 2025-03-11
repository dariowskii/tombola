import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tombola/features/admin_game_session_screen/data/extract_number_provider.dart';
import 'package:tombola/features/admin_game_session_screen/data/update_active_session.dart';
import 'package:tombola/features/admin_game_session_screen/presentation/master_bingo_table.dart';
import 'package:tombola/features/admin_game_session_screen/presentation/qr_code_modal.dart';
import 'package:tombola/features/admin_game_session_screen/presentation/smorfiai_dialog.dart';
import 'package:tombola/models/game_session.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';
import 'package:tombola/widgets/extraction_history.dart';

class AdminGameSessionScreen extends ConsumerStatefulWidget {
  const AdminGameSessionScreen({
    super.key,
    required this.sessionId,
  });

  final String sessionId;

  @override
  ConsumerState<AdminGameSessionScreen> createState() =>
      _AdminGameSessionScreenState();
}

class _AdminGameSessionScreenState
    extends ConsumerState<AdminGameSessionScreen> {
  late final _historyScrollController = ItemScrollController();
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

      final hasNewExtraction = _gameSession == null ||
          _gameSession!.extractedNumbers.length !=
              session.extractedNumbers.length;

      setState(() {
        if (hasNewExtraction) {
          _animateHistoryScroll();
          _showLastNumberAssociatedImage();
        }
        _gameSession = session;
      });
    });
  }

  void _animateHistoryScroll() {
    Future.delayed(200.ms, () {
      if (!mounted) {
        return;
      }

      if (_gameSession!.extractedNumbers.isEmpty) {
        return;
      }

      _historyScrollController.scrollTo(
        index: _gameSession!.extractedNumbers.length - 1,
        alignment: 0.85,
        duration: 500.ms,
        curve: Curves.easeOut,
      );
    });
  }

  void _showLastNumberAssociatedImage() {
    final gameSession = _gameSession;
    if (gameSession == null) {
      return;
    }

    final lastNumber = gameSession.extractedNumbers.last;
    final imageUrl = kNumberImages[lastNumber];

    if (imageUrl == null) {
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return SmorfiaiDialog(
          imageUrl: imageUrl,
        );
      },
    );
  }

  void _extractNumber() {
    final gameSession = _gameSession;
    if (gameSession == null) {
      return;
    }

    ref.read(
      extractNumberProvider(
        extractedNumbers: gameSession.extractedNumbers,
        sessionId: gameSession.id,
      ),
    );
  }

  void _showQRCodeFullModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return QrCodeModal(sessionId: widget.sessionId);
      },
    );
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
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _showQRCodeFullModal,
            icon: const Icon(Icons.qr_code),
          ),
          IconButton(
            onPressed: () {
              ref.read(
                setActiveSessionProvider(
                  sessionId: gameSession.id,
                  isActive: !gameSession.isActive,
                ),
              );
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
              if (gameSession.createdAt != null) ...[
                Text(
                  'Data: ${gameSession.createdAt!.formatted}',
                  style: context.textTheme.bodySmall,
                ),
              ],
              Text(
                'Stato: ${gameSession.isActive ? 'Attiva' : 'Inattiva'}',
                style: context.textTheme.bodySmall,
              ),
              Spacing.medium.h,
              ExtractionHistory(
                extractedNumbers: gameSession.extractedNumbers,
                itemScrollController: _historyScrollController,
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
                      : _extractNumber,
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
