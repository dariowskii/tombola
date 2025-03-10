import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';

class QrCodeModal extends StatelessWidget {
  const QrCodeModal({
    super.key,
    required this.sessionId,
  });

  final String sessionId;

  @override
  Widget build(BuildContext context) {
    final qrCodeColor = context.isDarkMode ? Colors.white : Colors.black;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(
          Spacing.medium.value,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.colorScheme.onSurface,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Spacing.medium.h,
            Text(
              'Codice sessione',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacing.medium.h,
            Center(
              child: QrImageView(
                data: sessionId,
                size: min(context.width * 0.8, 400),
                eyeStyle: QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: qrCodeColor,
                ),
                dataModuleStyle: QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.circle,
                  color: qrCodeColor,
                ),
              ),
            ),
            Spacing.medium.h,
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(999),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Text(
                  sessionId,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.onPrimary,
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
