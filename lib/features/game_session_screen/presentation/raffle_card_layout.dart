import 'package:flutter/material.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';

class RaffleCardLayout extends StatelessWidget {
  const RaffleCardLayout({
    super.key,
    required this.numbers,
    required this.extractedNumbers,
  });

  final List<int> numbers;
  final List<int> extractedNumbers;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        Spacing.large.value,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 9,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemCount: numbers.length,
        itemBuilder: (context, index) {
          final number = numbers[index];
          final isExtracted = extractedNumbers.contains(number);
          final isLastExtracted =
              extractedNumbers.isNotEmpty && extractedNumbers.last == number;

          return Container(
            decoration: BoxDecoration(
              color: isLastExtracted
                  ? kLastExtractedColor(context)
                  : isExtracted
                      ? context.colorScheme.secondary
                      : context.colorScheme.surface,
              border: Border.all(
                color: context.colorScheme.primary,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                number == 0 ? '' : number.toString(),
                style: TextStyle(
                  color: isExtracted ? context.colorScheme.onSecondary : null,
                  fontSize: 24,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
