import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tombola/features/setup_game_screen/presentation/error_state.dart';
import 'package:tombola/features/setup_game_screen/presentation/setup_game_form.dart';
import 'package:tombola/models/game_session.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';
import 'package:tombola/widgets/active_game_badge.dart';

class SetupGameBody extends StatefulWidget {
  const SetupGameBody({
    super.key,
    required this.sessionId,
  });

  final String sessionId;

  @override
  State<SetupGameBody> createState() => _SetupGameBodyState();
}

class _SetupGameBodyState extends State<SetupGameBody> {
  late final Stream<DocumentSnapshot<Object?>> _stream =
      FirebaseFirestore.instance.sessions.doc(widget.sessionId).snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _stream,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasError) {
          return SetupErrorState(
            sessionId: widget.sessionId,
            error: asyncSnapshot.error ?? 'Errore sconosciuto',
          );
        }

        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!asyncSnapshot.hasData) {
          return SetupErrorState(
            sessionId: widget.sessionId,
            error: 'Nessun dato disponibile... 🤔',
          );
        }

        final sessionData = asyncSnapshot.data!.data() as Map<String, dynamic>;
        sessionData['id'] = asyncSnapshot.data!.id;

        final gameSession = GameSession.fromJson(sessionData);

        return Center(
          child: Padding(
            padding: EdgeInsets.all(
              Spacing.medium.value,
            ),
            child: Column(
              children: [
                const Text('Evento'),
                Text(
                  gameSession.eventName,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacing.medium.h,
                ActiveGameBadge(
                  isActive: gameSession.isActive,
                ),
                const Spacer(),
                SetupGameForm(
                  sessionId: widget.sessionId,
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
