import 'package:flutter/material.dart';
import 'package:tombola/models/game_session.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';

class GameInfo extends StatelessWidget {
  const GameInfo({
    super.key,
    required this.gameSession,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.titleFontSize,
  });

  final GameSession gameSession;
  final CrossAxisAlignment crossAxisAlignment;
  final double? titleFontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          gameSession.eventName,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: titleFontSize,
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
      ],
    );
  }
}
