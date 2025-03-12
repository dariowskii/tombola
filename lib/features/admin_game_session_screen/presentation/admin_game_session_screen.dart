import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tombola/features/admin_game_session_screen/data/extract_number_provider.dart';
import 'package:tombola/features/admin_game_session_screen/data/update_active_session.dart';
import 'package:tombola/features/admin_game_session_screen/presentation/game_info.dart';
import 'package:tombola/features/admin_game_session_screen/presentation/master_bingo_table.dart';
import 'package:tombola/features/admin_game_session_screen/presentation/qr_code_modal.dart';
import 'package:tombola/features/admin_game_session_screen/presentation/smorfiai_dialog.dart';
import 'package:tombola/models/game_session.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';
import 'package:tombola/widgets/extraction_history.dart';
import 'package:tombola/widgets/last_extracted_number.dart';

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

      final gameWasNull = _gameSession == null;
      final hasNewExtraction = gameWasNull ||
          _gameSession!.extractedNumbers.length !=
              session.extractedNumbers.length;

      setState(() {
        _gameSession = session;
        if (hasNewExtraction) {
          _animateHistoryScroll();
        }
      });

      if (hasNewExtraction && !gameWasNull) {
        _showLastNumberAssociatedImage();
      }
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

  void _showLastNumberAssociatedImage([int? forcedNumber]) async {
    if (context.isLittleScreen) {
      return;
    }
    var lastExtractedNumber = _gameSession?.extractedNumbers.lastOrNull;
    if (lastExtractedNumber == null && forcedNumber == null) {
      return;
    }

    if (forcedNumber != null) {
      lastExtractedNumber = forcedNumber;
    }

    final imageUrl = kNumberImages[lastExtractedNumber];

    if (imageUrl == null) {
      return;
    }

    if (forcedNumber == null) {
      await Future.delayed(1.seconds);
    }
    if (!mounted) {
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
        child: Builder(
          builder: (context) {
            if (context.isLittleScreen) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GameInfo(gameSession: gameSession),
                    Spacing.medium.h,
                    ExtractionHistory(
                      extractedNumbers: gameSession.extractedNumbers,
                      itemScrollController: _historyScrollController,
                    ),
                    Spacing.medium.h,
                    MasterBingoTable(
                      extractedNumbers: gameSession.extractedNumbers,
                      onTapNumber: (number) {
                        _showLastNumberAssociatedImage(number);
                      },
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
              );
            }

            return Row(
              spacing: Spacing.large.value,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        spacing: 40,
                        children: [
                          GameInfo(
                            gameSession: gameSession,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            titleFontSize: 40,
                          ),
                          LastExtractedNumber(
                            lastExtractedNumber:
                                gameSession.extractedNumbers.lastOrNull ?? 0,
                          ),
                        ],
                      ),
                      ExtractionHistory(
                        extractedNumbers: gameSession.extractedNumbers,
                        itemScrollController: _historyScrollController,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        titleFontSize: 30,
                      ),
                      SizedBox(
                        width: 200,
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
                Expanded(
                  child: MasterBingoTable(
                    extractedNumbers: gameSession.extractedNumbers,
                    onTapNumber: (number) {
                      _showLastNumberAssociatedImage(number);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
