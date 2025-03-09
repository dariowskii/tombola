import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:tombola/features/welcome_screen/presentation/welcome_background.dart';
import 'package:tombola/router/routes.dart';
import 'package:tombola/utils/constants.dart';

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
            onPressed: () {
              // TODO: open scanner
            },
            child: const Text('Entra in sessione'),
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
