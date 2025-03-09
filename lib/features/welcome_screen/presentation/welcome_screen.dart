import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:tombola/features/welcome_screen/presentation/welcome_background.dart';

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
    return const Scaffold(
      extendBody: true,
      body: Column(
        children: [
          WelcomeBackground(),
        ],
      ),
    );
  }
}
