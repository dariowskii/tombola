import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:tombola/features/welcome_screen/presentation/welcome_background.dart';
import 'package:tombola/router/routes.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const WelcomeBackground(),
          const Spacer(),
          Text(
            'Welcome to Tombola!',
            style: context.textTheme.titleLarge,
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
