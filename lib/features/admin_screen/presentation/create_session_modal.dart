import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tombola/features/admin_screen/data/create_session.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';

class CreateSessionModal extends ConsumerStatefulWidget {
  const CreateSessionModal({super.key});

  @override
  ConsumerState<CreateSessionModal> createState() => _CreateSessionModalState();
}

class _CreateSessionModalState extends ConsumerState<CreateSessionModal> {
  late final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _createSession() async {
    if (_nameController.text.isEmpty) {
      return;
    }

    final eventName = _nameController.text;

    try {
      final result = await ref.read(
        createSessionProvider(eventName: eventName).future,
      );
      if (!mounted) return;

      if (result) {
        context.showSnackBar('Sessione creata con successo');
        return;
      }

      context.showSnackBar(
        'Errore durante la creazione della sessione',
      );
    } catch (e) {
      if (mounted) {
        context.showSnackBar(
          'Errore: ${e.toString()}',
        );
      }
    } finally {
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                'Crea una nuova sessione',
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacing.large.h,
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  label: const Text('Nome'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Spacing.large.h,
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _createSession,
                  child: const Text('Crea'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
