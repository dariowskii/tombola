import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';

part 'extract_number_provider.g.dart';

@riverpod
void extractNumber(
  Ref ref, {
  required List<int> extractedNumbers,
  required String sessionId,
}) {
  if (extractedNumbers.length >= 90) {
    return;
  }

  if (extractedNumbers.isEmpty) {
    final random = Random();
    final number = random.nextInt(90) + 1;
    FirebaseFirestore.instance.sessions.doc(sessionId).update({
      'extractedNumbers': FieldValue.arrayUnion([number]),
    });
    return;
  }

  final extractableNumbers = kExtractableNumbers
      .where(
        (element) => !extractedNumbers.contains(element),
      )
      .toList();

  extractableNumbers.shuffle();
  extractableNumbers.shuffle();

  final number = extractableNumbers.first;
  FirebaseFirestore.instance.sessions.doc(sessionId).update({
    'extractedNumbers': FieldValue.arrayUnion([number]),
  });
}
