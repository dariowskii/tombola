import 'package:flutter/material.dart';
import 'package:tombola/models/user.dart';

class PrizeChecker {
  static Prize? maxPrize;

  static void checkPrize(
    BuildContext context, {
    required List<User> users,
    required List<int> extractedNumbers,
  }) {
    String? winTitle;
    var winMessage = '';

    for (final user in users) {
      final userRaffleCards = user.raffleCards;
      var tombolinoCounter = 0;

      for (int i = 0; i < userRaffleCards.length; i++) {
        final raffleCard = userRaffleCards[i];
        final rows = raffleCard.rowsList;
        var tombolaCounter = 0;

        for (final row in rows) {
          var counter = 0;
          for (final number in row.toSet()) {
            if (extractedNumbers.contains(number)) {
              counter++;
              tombolaCounter++;
              tombolinoCounter++;
            }
          }
          if (counter > 1) {
            final prize = Prize.fromIndex(counter);
            final maxPrizeWasNull = maxPrize == null;
            final isValid = maxPrizeWasNull ? true : counter > maxPrize!.value;
            maxPrize = maxPrize == null
                ? prize
                : maxPrize!.value > prize.value
                    ? maxPrize
                    : prize;

            if (isValid &&
                (user.lastPrize == null || counter > user.lastPrize!.value)) {
              user.lastPrize = prize;
              winTitle ??= 'Hai vinto!';
              winMessage +=
                  '${user.name} ha fatto ${prize.message} nella scheda ${i + 1}!\n';
            }
          }
        }

        if (tombolaCounter == 15) {
          final prize = Prize.fromIndex(tombolaCounter);
          final maxPrizeWasNull = maxPrize == null;
          final isValid =
              maxPrizeWasNull ? true : tombolaCounter > maxPrize!.value;
          maxPrize = maxPrize == null
              ? prize
              : maxPrize!.value > prize.value
                  ? maxPrize
                  : prize;

          if (isValid &&
              (user.lastPrize == null ||
                  tombolaCounter > user.lastPrize!.value)) {
            user.lastPrize = prize;
            winTitle ??= 'Hai vinto!';
            winMessage +=
                '${user.name} ha fatto ${prize.message} nella scheda ${i + 1}!\n';
          }
        }
      }

      if (userRaffleCards.length > 1 &&
          tombolinoCounter == (userRaffleCards.length * 15)) {
        final prize = Prize.fromIndex(tombolinoCounter, isTombolino: true);
        final maxPrizeWasNull = maxPrize == null;
        final isValid =
            maxPrizeWasNull ? true : tombolinoCounter > maxPrize!.value;
        maxPrize = maxPrize == null
            ? prize
            : maxPrize!.value > prize.value
                ? maxPrize
                : prize;

        if (isValid &&
            (user.lastPrize == null ||
                tombolinoCounter > user.lastPrize!.value)) {
          user.lastPrize = prize;
          winTitle ??= 'Hai vinto!';
          winMessage += '${user.name} ha fatto ${prize.message}!\n';
        }
      }
    }

    if (winTitle != null) {
      _showAlertDialog(context, title: winTitle, content: winMessage);
    }
  }

  static void _showAlertDialog(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Ok',
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

enum Prize {
  ambo,
  terno,
  quaterna,
  cinquina,
  tombola,
  tombolino;

  static Prize fromIndex(int index, {bool isTombolino = false}) {
    if (isTombolino) {
      return Prize.tombolino;
    }
    switch (index) {
      case 2:
        return Prize.ambo;
      case 3:
        return Prize.terno;
      case 4:
        return Prize.quaterna;
      case 5:
        return Prize.cinquina;
      case 15:
        return Prize.tombola;
      default:
        throw Exception('Invalid index');
    }
  }

  String get message {
    switch (this) {
      case Prize.ambo:
        return 'ambo';
      case Prize.terno:
        return 'terno';
      case Prize.quaterna:
        return 'quaterna';
      case Prize.cinquina:
        return 'cinquina';
      case Prize.tombola:
        return 'tombola!';
      case Prize.tombolino:
        return 'tombolino!';
    }
  }

  int get value {
    switch (this) {
      case Prize.ambo:
        return 2;
      case Prize.terno:
        return 3;
      case Prize.quaterna:
        return 4;
      case Prize.cinquina:
        return 5;
      case Prize.tombola:
        return 15;
      case Prize.tombolino:
        return 100;
    }
  }
}
