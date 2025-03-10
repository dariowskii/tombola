import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tombola/features/game_session_screen/presentation/game_session_error.dart';
import 'package:tombola/features/game_session_screen/presentation/raffle_card_layout.dart';
import 'package:tombola/models/game_session.dart';
import 'package:tombola/providers/recover_raffle_card.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';
import 'package:tombola/widgets/last_extracted_number.dart';

class GameSessionScreen extends ConsumerStatefulWidget {
  const GameSessionScreen({
    super.key,
    required this.sessionId,
    required this.raffleId,
  });

  final String sessionId;
  final String raffleId;

  @override
  ConsumerState<GameSessionScreen> createState() => _GameSessionScreenState();
}

class _GameSessionScreenState extends ConsumerState<GameSessionScreen> {
  RaffleCard? _raffleCard;

  bool _isLoading = true;

  late final Stream<DocumentSnapshot<Object?>> _stream =
      FirebaseFirestore.instance.sessions.doc(widget.sessionId).snapshots();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadRaffleCard();
    });
  }

  void _loadRaffleCard() async {
    try {
      final raffleCard = await ref.read(
        getRaffleCardProvider(
          sessionId: widget.sessionId,
          raffleId: widget.raffleId,
        ).future,
      );

      if (raffleCard != null) {
        setState(() {
          _raffleCard = raffleCard;
        });
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar('Errore durante il recupero della cartella');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final raffleCard = _raffleCard;
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Tombola!'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (raffleCard == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Tombola!'),
        ),
        body: const Center(
          child: Text('Nessuna cartella trovata'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tombola!'),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: _stream,
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.hasError) {
              return GameSessionError(
                error: asyncSnapshot.error ?? 'Errore sconosciuto',
                onRetry: () {},
              );
            }

            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!asyncSnapshot.hasData) {
              return GameSessionError(
                error: 'Nessun dato disponibile... 🤔',
                onRetry: () {},
              );
            }

            final sessionData =
                asyncSnapshot.data!.data() as Map<String, dynamic>;
            sessionData['id'] = asyncSnapshot.data!.id;

            final gameSession = GameSession.fromJson(sessionData);

            return Center(
              child: Column(
                children: [
                  const Spacer(),
                  Text(
                    gameSession.eventName,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacing.large.h,
                  LastExtractedNumber(
                    lastExtractedNumber:
                        gameSession.extractedNumbers.lastOrNull ?? 0,
                  ),
                  const Spacer(),
                  Text(
                    'Cartella di',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacing.small.h,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      raffleCard.username,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RaffleCardLayout(
                    numbers: raffleCard.numbers,
                    extractedNumbers: gameSession.extractedNumbers,
                  ),
                  const Spacer(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
