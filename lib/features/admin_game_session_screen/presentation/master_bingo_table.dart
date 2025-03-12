import 'package:flutter/material.dart';
import 'package:tombola/utils/angle_type_enum.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';

class MasterBingoTable extends StatelessWidget {
  const MasterBingoTable({
    super.key,
    required this.extractedNumbers,
    required this.onTapNumber,
  });

  final List<int> extractedNumbers;
  final void Function(int number) onTapNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
              final angleType = AngleType.fromNumber(number);
              return InkWell(
                onTap: () => onTapNumber(number),
                borderRadius: angleType.borderRadius,
                child: Container(
                  decoration: BoxDecoration(
                    color: isLastExtracted
                        ? kLastExtractedColor(context)
                        : isExtracted
                            ? context.colorScheme.primary
                            : context.colorScheme.surface,
                    borderRadius: angleType.borderRadius,
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
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
