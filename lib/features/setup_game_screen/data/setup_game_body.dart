import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tombola/models/game_session.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';
import 'package:tombola/widgets/active_game_badge.dart';

class SetupGameBody extends ConsumerWidget {
  const SetupGameBody({
    super.key,
    required this.gameSession,
  });

  final GameSession gameSession;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(
          Spacing.medium.value,
        ),
        child: Column(
          children: [
            const Text('Evento'),
            Text(
              gameSession.eventName,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacing.medium.h,
            ActiveGameBadge(
              isActive: gameSession.isActive,
            ),
          ],
        ),
      ),
    );
  }
}
