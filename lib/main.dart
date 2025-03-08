import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tombola/models/game_state.dart';
import 'package:tombola/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final gameState = prefs.getString('gameState');
  if (gameState != null) {
    runApp(TombolaApp(
      gameState: GameState.fromJson(jsonDecode(gameState)),
    ));
  } else {
    runApp(const TombolaApp());
  }
}

class TombolaApp extends StatelessWidget {
  const TombolaApp({
    Key? key,
    this.gameState,
  }) : super(key: key);

  final GameState? gameState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tombola!',
      home: HomeScreen(
        gameState: gameState,
      ),
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(
          primary: Colors.redAccent,
        ),
      ),
    );
  }
}
