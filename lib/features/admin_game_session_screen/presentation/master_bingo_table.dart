import 'package:flutter/material.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';

enum AngleType {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  none;

  static AngleType fromNumber(int number) => switch (number) {
        1 => AngleType.topLeft,
        10 => AngleType.topRight,
        81 => AngleType.bottomLeft,
        90 => AngleType.bottomRight,
        _ => AngleType.none,
      };
}

class MasterBingoTable extends StatelessWidget {
  const MasterBingoTable({
    super.key,
    required this.extractedNumbers,
  });

  final List<int> extractedNumbers;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tabellone',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
            ),
            itemCount: 90,
            itemBuilder: (context, index) {
              final number = index + 1;
              final isExtracted = extractedNumbers.contains(number);
              final isLastExtracted = extractedNumbers.isNotEmpty &&
                  extractedNumbers.last == number;
              return Container(
                decoration: BoxDecoration(
                  color: isLastExtracted
                      ? kLastExtractedColor(context)
                      : isExtracted
                          ? context.colorScheme.primary
                          : context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(0),
                  border: Border.all(
                    color: context.colorScheme.primary,
                    width: isLastExtracted ? 0 : 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    number.toString(),
                    style: TextStyle(
                      color: isLastExtracted
                          ? context.colorScheme.onTertiary
                          : isExtracted
                              ? context.colorScheme.onPrimary
                              : context.colorScheme.onSurface,
                      fontWeight:
                          isExtracted ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
