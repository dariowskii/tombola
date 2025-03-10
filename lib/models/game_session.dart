import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tombola/models/timestamp_converter.dart';

part 'game_session.freezed.dart';
part 'game_session.g.dart';

@freezed
abstract class GameSession with _$GameSession {
  const factory GameSession({
    required String id,
    required bool isActive,
    required String eventName,
    @TimestampConverter() required DateTime createdAt,
    @Default([]) List<int> extractedNumbers,
  }) = _GameSession;

  factory GameSession.fromJson(Map<String, dynamic> json) =>
      _$GameSessionFromJson(json);
}

@freezed
abstract class RaffleCard with _$RaffleCard {
  const factory RaffleCard({
    required String id,
    required String email,
    required List<int> numbers,
  }) = _RaffleCard;

  factory RaffleCard.fromJson(Map<String, dynamic> json) =>
      _$RaffleCardFromJson(json);
}
