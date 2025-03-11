import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';

class ExtractionHistory extends StatelessWidget {
  const ExtractionHistory({
    super.key,
    required this.extractedNumbers,
    required this.itemScrollController,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.titleFontSize,
  });

  final List<int> extractedNumbers;
  final ItemScrollController itemScrollController;
  final CrossAxisAlignment crossAxisAlignment;
  final double? titleFontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          'Storico estrazioni',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: titleFontSize,
          ),
        ),
        SizedBox(
          height: context.isLittleScreen ? 8 : 24,
        ),
        SizedBox(
          height: context.isLittleScreen ? 30 : 60,
          child: extractedNumbers.isEmpty
              ? const Text('- - -')
              : ScrollablePositionedList.separated(
                  itemScrollController: itemScrollController,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: extractedNumbers.length,
                  itemBuilder: (context, index) {
                    final number = extractedNumbers[index];
                    final isLast = number == extractedNumbers.last;
                    return Container(
                      width: context.isLittleScreen ? 30 : 60,
                      decoration: BoxDecoration(
                        color: isLast
                            ? kLastExtractedColor(context)
                            : context.colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isLast
                              ? kLastExtractedColor(context)
                              : context.colorScheme.primary,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          number.toString(),
                          style: TextStyle(
                            fontSize: context.isLittleScreen ? 16 : 24,
                            color: isLast
                                ? context.colorScheme.onTertiary
                                : context.colorScheme.onSurface,
                            fontWeight:
                                isLast ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 8);
                  },
                ),
        ),
      ],
    );
  }
}
