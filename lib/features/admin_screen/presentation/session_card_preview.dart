import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tombola/models/game_session.dart';
import 'package:tombola/router/routes.dart';
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
            Row(
              children: [
                Flexible(
                  child: Text(
                    session.eventName,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacing.medium.w,
                if (session.isActive)
                  const Icon(
                    Icons.circle,
                    color: Colors.green,
                    size: 16,
                  ),
              ],
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
                  AdminGameSessionRoute(id: session.id).go(context);
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
