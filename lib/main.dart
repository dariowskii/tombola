import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tombola/firebase_options.dart';
import 'package:tombola/models/game_state.dart';
import 'package:tombola/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: TombolaApp(),
    ),
  );
}

class TombolaApp extends ConsumerWidget {
  const TombolaApp({super.key, this.gameState});

  final GameState? gameState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Tombola!',
      routerConfig: ref.watch(routerProvider),
      darkTheme: ThemeData.from(
        colorScheme: const ColorScheme.dark(
          primary: Colors.blueAccent,
        ),
      ),
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(
          primary: Colors.blue,
        ),
      ),
    );
  }
}
