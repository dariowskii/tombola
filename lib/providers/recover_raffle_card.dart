import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tombola/models/game_session.dart';
import 'package:tombola/utils/extensions.dart';

part 'recover_raffle_card.g.dart';

@riverpod
Future<RaffleCard> recoverRaffleCard(
  Ref ref, {
  required String sessionId,
  required String raffleId,
}) async {
  final rafflesCollection = FirebaseFirestore.instance.getRaffles(sessionId);
  final docSnapshot = await rafflesCollection.doc(raffleId).get();

  if (docSnapshot.exists) {
    final data = docSnapshot.data() as Map<String, dynamic>;
    data['id'] = docSnapshot.id;

    return RaffleCard.fromJson(data);
  }

  throw Exception('Cartella non trovata');
}
