import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tombola/utils/extensions.dart';

part 'update_active_session.g.dart';

@riverpod
void setActiveSession(
  Ref ref, {
  required String sessionId,
  required bool isActive,
}) {
  FirebaseFirestore.instance.sessions.doc(sessionId).update({
    'isActive': isActive,
  });
}
