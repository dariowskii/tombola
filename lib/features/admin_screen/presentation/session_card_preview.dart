import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tombola/models/game_session.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';

class SessionCardPreview extends StatelessWidget {
  const SessionCardPreview({
    super.key,
    required this.session,
  });

  final GameSession session;

  @override
  Widget build(BuildContext context) {
    final bgColor = session.isActive
        ? context.colorScheme.primaryContainer
        : context.colorScheme.surfaceContainerLow;

    final textColor = session.isActive
        ? context.colorScheme.onPrimaryContainer
        : context.colorScheme.onSurface;
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withValues(
              alpha: 0.2,
            ),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(
          Spacing.medium.value,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              session.eventName,
              style: context.textTheme.titleLarge?.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacing.small.h,
            Text.rich(
              TextSpan(
                text: 'Codice:',
                children: [
                  TextSpan(
                    text: ' ${session.id}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: textColor,
                    ),
                    mouseCursor: SystemMouseCursors.click,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Clipboard.setData(
                          ClipboardData(
                            text: session.id,
                          ),
                        );
                        context.showSnackBar(
                          'Codice copiato negli appunti',
                        );
                      },
                  ),
                ],
              ),
              style: context.textTheme.bodyLarge?.copyWith(
                color: textColor,
              ),
            ),
            Spacing.small.h,
            Text(
              'Numeri estratti: ${session.extractedNumbers.length}',
              style: context.textTheme.bodyLarge?.copyWith(
                color: textColor,
              ),
            ),
            Spacing.small.h,
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: go to session details
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: bgColor,
                  backgroundColor: textColor,
                ),
                child: Text(
                  session.isActive ? 'Entra' : 'Dettagli',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
