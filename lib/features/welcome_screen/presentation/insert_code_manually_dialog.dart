import 'package:flutter/material.dart';
import 'package:tombola/utils/extensions.dart';

class InsertCodeManuallyDialog extends StatefulWidget {
  const InsertCodeManuallyDialog({
    super.key,
    required this.onCodeInserted,
  });

  final void Function(String code) onCodeInserted;

  @override
  State<InsertCodeManuallyDialog> createState() =>
      _InsertCodeManuallyDialogState();
}

class _InsertCodeManuallyDialogState extends State<InsertCodeManuallyDialog> {
  late final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Inserisci il codice'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: 'Codice',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Annulla',
            style: TextStyle(
              color: context.textTheme.titleLarge?.color,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);

            if (_controller.text.isNotEmpty) {
              widget.onCodeInserted(_controller.text);
            }
          },
          child: const Text('Conferma'),
        ),
      ],
    );
  }
}
