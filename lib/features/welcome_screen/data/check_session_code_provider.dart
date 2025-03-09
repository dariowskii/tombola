import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tombola/utils/extensions.dart';

part 'check_session_code_provider.g.dart';

@riverpod
Future<String?> checkCode(Ref ref, String code) async {
  try {
    final sessionsCollection = FirebaseFirestore.instance.sessions;
    final docSnapshot = await sessionsCollection.doc(code).get();

    if (docSnapshot.exists) {
      return code;
    }
  } catch (e) {
    return null;
  }

  return null;
}
