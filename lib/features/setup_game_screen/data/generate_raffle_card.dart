import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tombola/models/game_session.dart';
import 'package:tombola/providers/check_session_code_provider.dart';
import 'package:tombola/providers/recover_raffle_card.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';

part 'generate_raffle_card.g.dart';

@riverpod
Future<RaffleCard> generateRaffleCard(
  Ref ref, {
  required String sessionId,
  required String username,
}) async {
  // Check if the session is active
  final session = await ref.refresh(getSessionProvider(sessionId).future);
  if (!session.isActive) {
    throw 'Sessione non attiva';
  }

  // Check if raffle card with the same username already exists
  final raffleCard = await ref.read(
    recoverRaffleCardProvider(
      sessionId: sessionId,
      username: username,
    ).future,
  );

  if (raffleCard != null) {
    throw 'Cartella già esistente';
  }

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

  var newRaffleCard = RaffleCard(
    id: '',
    username: username,
    numbers: [...firstRow, ...secondRow, ...thirdRow],
  );

  final sessionsCollection = FirebaseFirestore.instance.sessions;
  final docReference =
      await sessionsCollection.doc(sessionId).collection('raffles').add(
            newRaffleCard.toJson(),
          );

  newRaffleCard = newRaffleCard.copyWith(
    id: docReference.id,
  );

  return newRaffleCard;
}
