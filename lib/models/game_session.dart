import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_session.freezed.dart';
part 'game_session.g.dart';

@freezed
abstract class GameSession with _$GameSession {
  const factory GameSession({
    required String id,
    required bool isActive,
    required String eventName,
  }) = _GameSession;

  factory GameSession.fromJson(Map<String, dynamic> json) =>
      _$GameSessionFromJson(json);
}
