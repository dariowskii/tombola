import 'package:flutter/material.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';

class CreateSessionModal extends StatefulWidget {
  const CreateSessionModal({super.key});

  @override
  State<CreateSessionModal> createState() => _CreateSessionModalState();
}

class _CreateSessionModalState extends State<CreateSessionModal> {
  late final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
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
                  onPressed: () {
                    Navigator.of(context).pop(_nameController.text);
                  },
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
