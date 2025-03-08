import 'dart:math';

import 'package:tombola/utils/constants.dart';

class RaffleCardModel {
  final firstRow = List.filled(9, 0);
  final secondRow = List.filled(9, 0);
  final thirdRow = List.filled(9, 0);

  List<int> get rows => [...firstRow, ...secondRow, ...thirdRow];
  List<List<int>> get rowsList => [firstRow, secondRow, thirdRow];
  Set<int> get numbers => rows.toSet();

  RaffleCardModel() {
    _setup();
  }

  void _setup() {
    final random = Random();
    final numbers =
        List<int>.generate(kMaxExtractableNumbers, (index) => index + 1);
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
      final number = numberColumns[column]
          .removeAt(random.nextInt(numberColumns[column].length));
      firstRow[column] = number;
    }

    while (secondRow.toSet().length < 6) {
      final column = random.nextInt(9);
      final number = numberColumns[column]
          .removeAt(random.nextInt(numberColumns[column].length));
      secondRow[column] = number;
    }

    while (thirdRow.toSet().length < 6) {
      final column = random.nextInt(9);
      final number = numberColumns[column]
          .removeAt(random.nextInt(numberColumns[column].length));
      thirdRow[column] = number;
    }
  }

  factory RaffleCardModel.fromJson(Map<String, dynamic> json) {
    final raffleCard = RaffleCardModel();
    raffleCard.firstRow
        .setAll(0, (json['firstRow'] as List).map((e) => e as int).toList());
    raffleCard.secondRow
        .setAll(0, (json['secondRow'] as List).map((e) => e as int).toList());
    raffleCard.thirdRow
        .setAll(0, (json['thirdRow'] as List).map((e) => e as int).toList());
    return raffleCard;
  }

  Map<String, dynamic> toJson() {
    return {
      'firstRow': firstRow,
      'secondRow': secondRow,
      'thirdRow': thirdRow,
    };
  }
}
