import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tombola/models/game_session.dart';
import 'package:tombola/utils/extensions.dart';
import 'package:tombola/utils/logger.dart';

part 'check_session_code_provider.g.dart';

@riverpod
Future<GameSession?> checkCode(Ref ref, String code) async {
  try {
    final sessionsCollection = FirebaseFirestore.instance.sessions;
    final docSnapshot = await sessionsCollection.doc(code).get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      data['id'] = docSnapshot.id;

      return GameSession.fromJson(data);
    }

    return null;
  } catch (e) {
    Logger.general.error(e);
    return null;
  }
}
