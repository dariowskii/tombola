import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tombola/models/game_session.dart';
import 'package:tombola/utils/constants.dart';

@riverpod
Future<RaffleCard> generateRaffleCard(
  Ref ref, {
  required String sessionId,
  required String username,
}) async {
  final firstRow = List<int>.filled(9, 0);
  final secondRow = List<int>.filled(9, 0);
  final thirdRow = List<int>.filled(9, 0);

  final random = Random();
  final numbers = List<int>.generate(
    kMaxExtractableNumbers,
    (index) => index + 1,
  );
  final numberColumns = List.generate(9, (index) {
    final max = (index + 1) * 10;
    final min = max - 10;
    if (max == 90) {
      return numbers.where((number) => number >= min).toList();
    }
    return numbers.where((number) => number >= min && number < max).toList();
  });

  while (firstRow.toSet().length < 6) {
    final column = random.nextInt(9);
    final number = numberColumns[column].removeAt(
      random.nextInt(numberColumns[column].length),
    );
    firstRow[column] = number;
  }

  while (secondRow.toSet().length < 6) {
    final column = random.nextInt(9);
    final number = numberColumns[column].removeAt(
      random.nextInt(numberColumns[column].length),
    );
    secondRow[column] = number;
  }

  while (thirdRow.toSet().length < 6) {
    final column = random.nextInt(9);
    final number = numberColumns[column].removeAt(
      random.nextInt(numberColumns[column].length),
    );
    thirdRow[column] = number;
  }

  return RaffleCard(
    id: sessionId,
    username: username,
    numbers: [...firstRow, ...secondRow, ...thirdRow],
  );
}
