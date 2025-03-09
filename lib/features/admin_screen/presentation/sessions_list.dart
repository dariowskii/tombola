import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tombola/features/admin_screen/presentation/session_card_preview.dart';
import 'package:tombola/models/game_session.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';

class SessionsList extends StatelessWidget {
  const SessionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Object?>>(
      stream: FirebaseFirestore.instance.sessions
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasError) {
          return Center(
            child: Text(
              'Errore: ${asyncSnapshot.error}',
              style: context.textTheme.bodyLarge,
            ),
          );
        }

        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final sessions = (asyncSnapshot.data?.docs ?? []).map((e) {
          final data = e.data() as Map<String, dynamic>;
          data['id'] = e.id;
          return GameSession.fromJson(data);
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(
                Spacing.medium.value,
              ),
              child: Text(
                'Sessioni',
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: sessions.length,
                padding: EdgeInsets.all(
                  Spacing.medium.value,
                ),
                separatorBuilder: (_, __) => Spacing.small.h,
                itemBuilder: (context, index) {
                  final session = sessions[index];
                  return SessionCardPreview(
                    session: session,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
