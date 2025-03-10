import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tombola/providers/check_session_code_provider.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';

class SetupErrorState extends ConsumerWidget {
  const SetupErrorState({
    super.key,
    required this.sessionId,
    required this.error,
  });

  final String sessionId;
  final Object error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          Spacing.medium.h,
          FilledButton(
            onPressed: () {
              ref.invalidate(getSessionProvider(sessionId));
            },
            child: const Text('Riprova'),
          ),
        ],
      ),
    );
  }
}
