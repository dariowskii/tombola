import 'package:flutter/material.dart';

class ExtractionHistory extends StatelessWidget {
  const ExtractionHistory({
    super.key,
    required this.extractedNumbers,
    required this.scrollController,
  });

  final List<int> extractedNumbers;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Storico estrazioni',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 30,
              child: extractedNumbers.isEmpty
                  ? const Text('- - -')
                  : ListView.separated(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: extractedNumbers.length,
                      itemBuilder: (context, index) {
                        final number = extractedNumbers[index];
                        final isLast = index == extractedNumbers.length - 1;
                        return Chip(
                          backgroundColor: isLast ? Colors.green : null,
                          label: Text(
                            number.toString(),
                            style: TextStyle(
                              color: isLast ? Colors.white : Colors.black87,
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
        ),
      ),
    );
  }
}
