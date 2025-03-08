import 'package:tombola/models/user.dart';

class GameState {
  final List<int> extractedNumbers;
  final List<User> users;

  GameState({
    required this.extractedNumbers,
    required this.users,
  });

  factory GameState.fromJson(Map<String, dynamic> json) {
    return GameState(
      extractedNumbers: List<int>.from(json['extractedNumbers']),
      users: (json['users'] as List).map((e) => User.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'extractedNumbers': extractedNumbers,
      'users': users.map((e) => e.toJson()).toList(),
    };
  }
}