import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:tombola/features/welcome_screen/presentation/welcome_background.dart';
import 'package:tombola/router/routes.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light,
    );
  }

  void _chooseCameraOrTextBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(Spacing.small.value),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  title: Text(
                    'Scansiona QR-Code',
                    style: context.textTheme.labelLarge,
                  ),
                  trailing: const Icon(Icons.qr_code),
                  onTap: _openQRCodeScanner,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Spacing.small.value),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  title: Text(
                    'Inserisci codice',
                    style: context.textTheme.labelLarge,
                  ),
                  trailing: const Icon(Icons.keyboard),
                  onTap: _openCodeInput,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openQRCodeScanner() {
    Navigator.pop(context);
    // TODO: implement
  }

  void _openCodeInput() {
    Navigator.pop(context);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Inserisci il codice'),
          content: TextField(
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

                // TODO: check code and redirect to the game
              },
              child: const Text('Conferma'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const WelcomeBackground(),
          const Spacer(),
          const Text(
            'ML TOMBOLA!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Spacing.medium.value),
            child: const Text(
              'Il gioco della tombola di\nMachine Learning Modena 🥳',
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          FilledButton(
            onPressed: _chooseCameraOrTextBottomSheet,
            child: const Text('Entra nella sessione'),
          ),
          const Spacer(),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    const LoginRoute().go(context);
                  },
                  label: const Text('Admin'),
                  icon: const Icon(Icons.forward),
                  iconAlignment: IconAlignment.end,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
