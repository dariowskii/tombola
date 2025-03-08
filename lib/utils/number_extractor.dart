import 'dart:math';

import 'package:tombola/utils/constants.dart';

class NumberExtractor {
  final _random = Random();
  late List<int> extractableNumbers;

  NumberExtractor({List<int>? extractedNumbers}) {
    extractableNumbers =
        List<int>.generate(kMaxExtractableNumbers, (index) => index + 1)
          ..shuffle()
          ..shuffle();
    extractedNumbers?.forEach((element) {
      extractableNumbers.remove(element);
    });
  }

  int? extractNumber() {
    if (extractableNumbers.isEmpty) {
      return null;
    }

    final index = _random.nextInt(extractableNumbers.length);
    final magicNumber = extractableNumbers[index];
    extractableNumbers.removeAt(index);
    return magicNumber;
  }

  void reset() {
    extractableNumbers =
        List<int>.generate(kMaxExtractableNumbers, (index) => index + 1)
          ..shuffle()
          ..shuffle();
  }
}
