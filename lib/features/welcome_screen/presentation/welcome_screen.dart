import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tombola/features/welcome_screen/presentation/qr_code_scanner.dart';
import 'package:tombola/providers/check_session_code_provider.dart';
import 'package:tombola/features/welcome_screen/presentation/insert_code_manually_dialog.dart';
import 'package:tombola/features/welcome_screen/presentation/welcome_background.dart';
import 'package:tombola/router/routes.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';
import 'package:tombola/utils/logger.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
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

  void _openQRCodeScanner() async {
    Navigator.pop(context);
    try {
      if (!mounted) return;
      final res = await showModalBottomSheet<String>(
        context: context,
        builder: (context) {
          return QrCodeScanner(
            onDetectCode: (detectedCode) {
              Navigator.pop(context, detectedCode);
            },
          );
        },
      );

      if (res != null && res.isNotEmpty) {
        _checkCodeAndRedirect(res);
      }
    } catch (e) {
      Logger.general.error(e);
    }
  }

  void _openCodeInput() async {
    Navigator.pop(context);
    await Future.delayed(300.ms);
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) {
        return InsertCodeManuallyDialog(
          onCodeInserted: _checkCodeAndRedirect,
        );
      },
    );
  }

  void _checkCodeAndRedirect(String code) async {
    final gameSession = await ref.read(checkCodeProvider(code).future);
    if (!mounted) return;

    if (gameSession == null) {
      context.showSnackBar('Codice non valido');
      return;
    }

    SetupGameRoute(id: gameSession.id).go(context);
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
