import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tombola/providers/recover_raffle_card.dart';
import 'package:tombola/router/routes.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';

class SetupGameForm extends ConsumerStatefulWidget {
  const SetupGameForm({
    super.key,
    required this.sessionId,
    required this.isActive,
  });

  final String sessionId;
  final bool isActive;

  @override
  ConsumerState<SetupGameForm> createState() => _SetupGameFormState();
}

class _SetupGameFormState extends ConsumerState<SetupGameForm> {
  late final _usernameController = TextEditingController();
  late final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _recoverRaffleCardFromUsername() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final username = _usernameController.text;

    try {
      final raffleCard = await ref.read(
        recoverRaffleCardProvider(
          sessionId: widget.sessionId,
          username: username,
        ).future,
      );

      if (!mounted) {
        return;
      }

      if (raffleCard == null) {
        context.showSnackBar(
          'Nessuna cartella trovata per lo username "$username"',
        );
        return;
      }

      GameSessionRoute(
        id: widget.sessionId,
        raffleId: raffleCard.id,
      ).go(context);
    } catch (e) {
      if (mounted) {
        context.showSnackBar('Errore: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isActive) {
      return Column(
        children: [
          Text(
            'Riguarda la tua cartella\ninserendo lo username a cui l\'hai associata',
            style: context.textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
          Spacing.large.h,
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _usernameController,
              autofillHints: [AutofillHints.username],
              decoration: InputDecoration(
                label: const Text('Username'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Inserisci uno username';
                }
                return null;
              },
              onTapOutside: (_) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
          ),
          Spacing.large.h,
          FilledButton(
            onPressed: _recoverRaffleCardFromUsername,
            child: const Text('Conferma'),
          ),
        ],
      );
    }

    return const Placeholder();
  }
}
