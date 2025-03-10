import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tombola/utils/extensions.dart';

part 'create_session.g.dart';

@riverpod
Future<bool> createSession(
  Ref ref, {
  required String eventName,
}) async {
  final docRef = await FirebaseFirestore.instance.sessions.add({
    'eventName': eventName,
    'isActive': true,
    'createdAt': FieldValue.serverTimestamp(),
    'extractedNumbers': [],
  });

  return docRef.id.isNotEmpty;
}
