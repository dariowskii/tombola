import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_session.freezed.dart';
part 'game_session.g.dart';

@freezed
abstract class GameSession with _$GameSession {
  const factory GameSession({
    required String id,
    required bool isActive,
    required String eventName,
    @Default([]) List<int> extractedNumbers,
    @Default([]) List<RaffleCard> raffleCards,
  }) = _GameSession;

  factory GameSession.fromJson(Map<String, dynamic> json) =>
      _$GameSessionFromJson(json);
}

@freezed
abstract class RaffleCard with _$RaffleCard {
  const factory RaffleCard({
    required String id,
    required String recoverId,
    required List<int> numbers,
  }) = _RaffleCard;

  factory RaffleCard.fromJson(Map<String, dynamic> json) =>
      _$RaffleCardFromJson(json);
}
