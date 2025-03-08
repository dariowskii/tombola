import 'package:tombola/models/raffle_card_model.dart';
import 'package:tombola/utils/prize_checker.dart';

class User {
  final String name;
  final List<RaffleCardModel> raffleCards;

  Prize? lastPrize;

  User({
    required this.name,
    required this.raffleCards,
    this.lastPrize,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      raffleCards: (json['raffleCards'] as List)
          .map((e) => RaffleCardModel.fromJson(e))
          .toList(),
      lastPrize:
          json['lastPrize'] != null ? Prize.fromIndex(json['lastPrize'], isTombolino: json['lastPrize'] == 100) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'raffleCards': raffleCards.map((e) => e.toJson()).toList(),
      'lastPrize': lastPrize?.value,
    };
  }
}
