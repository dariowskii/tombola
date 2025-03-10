import 'package:flutter/material.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';

class LastExtractedNumber extends StatelessWidget {
  const LastExtractedNumber({
    super.key,
    required this.lastExtractedNumber,
  });

  final int lastExtractedNumber;

  @override
  Widget build(BuildContext context) {
    final text =
        lastExtractedNumber == 0 ? '??' : lastExtractedNumber.toString();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.colorScheme.primary,
          width: 2,
        ),
      ),
      padding: EdgeInsets.all(
        Spacing.medium.value,
      ),
      child: Column(
        children: [
          const Text(
            'Ultimo numero estratto',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 24,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 48,
            ),
          ),
        ],
      ),
    );
  }
}
