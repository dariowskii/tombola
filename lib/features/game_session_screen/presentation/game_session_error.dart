import 'package:flutter/material.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';

class GameSessionError extends StatelessWidget {
  const GameSessionError({
    super.key,
    required this.error,
    required this.onRetry,
  });

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Errore :(',
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Spacing.medium.h,
          Text('$error'),
          Spacing.large.h,
          Spacing.large.h,
          FilledButton(
            onPressed: onRetry,
            child: const Text('Riprova'),
          ),
        ],
      ),
    );
  }
}
