// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// import 'package:tombola/main.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/number_extractor.dart';

void main() {
  test(
      'number extractor will be empty after $kMaxExtractableNumbers extractions',
      () {
    final numberExtractor = NumberExtractor();
    for (var i = 0; i < kMaxExtractableNumbers; i++) {
      numberExtractor.extractNumber();
    }
    expect(numberExtractor.extractableNumbers.length, 0);
  });

  test('number extractor contains values between 1 and $kMaxExtractableNumbers',
      () {
    final numberExtractor = NumberExtractor();
    for (var i = 0; i < kMaxExtractableNumbers; i++) {
      final extractedNumber = numberExtractor.extractNumber();
      expect(extractedNumber, greaterThanOrEqualTo(1));
      expect(extractedNumber, lessThanOrEqualTo(kMaxExtractableNumbers));
    }
  });
}
