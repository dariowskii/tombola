import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tombola/features/setup_game_screen/data/setup_game_body.dart';
import 'package:tombola/features/setup_game_screen/presentation/error_state.dart';
import 'package:tombola/providers/check_session_code_provider.dart';

class SetupGameScreen extends ConsumerWidget {
  const SetupGameScreen({
    super.key,
    required this.sessionId,
  });

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSession =
        ref.watch(getSessionProvider(sessionId)).unwrapPrevious();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imposta gioco'),
      ),
      body: SafeArea(
        child: switch (asyncSession) {
          AsyncData(:final value) => SetupGameBody(
              gameSession: value,
            ),
          AsyncError(:final error) => SetupErrorState(
              sessionId: sessionId,
              error: error,
            ),
          _ => const Center(
              child: CircularProgressIndicator(),
            ),
        },
      ),
    );
  }
}
