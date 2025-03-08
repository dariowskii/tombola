import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tombola/firebase_options.dart';
import 'package:tombola/models/game_state.dart';
import 'package:tombola/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();
  final gameState = prefs.getString('gameState');
  if (gameState != null) {
    runApp(
      TombolaApp(
        gameState: GameState.fromJson(jsonDecode(gameState)),
      ),
    );
  } else {
    runApp(const TombolaApp());
  }
}

class TombolaApp extends StatelessWidget {
  const TombolaApp({super.key, this.gameState});

  final GameState? gameState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tombola!',
      home: HomeScreen(gameState: gameState),
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(primary: Colors.redAccent),
      ),
    );
  }
}
