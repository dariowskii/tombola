import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tombola/features/setup_game_screen/data/generate_raffle_card.dart';
import 'package:tombola/providers/recover_raffle_card.dart';
import 'package:tombola/router/routes.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';

enum ActionType {
  create,
  recover;

  String get modalTitle => switch (this) {
        ActionType.create => 'Nuova cartella',
        ActionType.recover => 'Recupera cartella',
      };

  String get modalContent => switch (this) {
        ActionType.create =>
          'Inserisci lo username a cui associare la cartella',
        ActionType.recover =>
          'Inserisci lo username per recuperare la cartella',
      };
}

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

  void _recoverRaffleCardFromUsername([ActionType? actionType]) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final username = _usernameController.text;
    _usernameController.clear();

    if (actionType == ActionType.recover) {
      Navigator.pop(context);
      await Future.delayed(1.seconds);
    }

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

  void _showInsertUsernameModal(ActionType actionType) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(
                Spacing.medium.value,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: context.colorScheme.onSurface.withValues(
                        alpha: .5,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Spacing.medium.h,
                  Text(
                    actionType.modalTitle,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacing.medium.h,
                  Text(
                    actionType.modalContent,
                    style: context.textTheme.labelLarge,
                  ),
                  Spacing.medium.h,
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
                        if (value.contains(' ')) {
                          return 'Lo username non può contenere spazi';
                        }
                        return null;
                      },
                      onTapOutside: (_) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ),
                  ),
                  Spacing.large.h,
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        if (actionType == ActionType.create) {
                          _generateRaffleCardAndRedirect();
                        } else {
                          _recoverRaffleCardFromUsername(ActionType.recover);
                        }
                      },
                      child: const Text('Conferma'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _generateRaffleCardAndRedirect() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.pop(context);
    await Future.delayed(1.seconds);

    final username = _usernameController.text;
    _usernameController.clear();

    try {
      final raffleCard = await ref.read(
        generateRaffleCardProvider(
          sessionId: widget.sessionId,
          username: username,
        ).future,
      );

      if (!mounted) {
        return;
      }

      GameSessionRoute(
        id: widget.sessionId,
        raffleId: raffleCard.id,
      ).go(context);
    } catch (e) {
      if (mounted) {
        context.showSnackBar(e.toString());
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

    return Column(
      children: [
        FilledButton(
          onPressed: () => _showInsertUsernameModal(ActionType.create),
          child: const Text(
            'Genera una nuova cartella',
          ),
        ),
        Spacing.small.h,
        const Text('- oppure -'),
        Spacing.small.h,
        FilledButton(
          onPressed: () => _showInsertUsernameModal(ActionType.recover),
          child: const Text('Recupera la tua cartella esistente'),
        ),
      ],
    );
  }
}
