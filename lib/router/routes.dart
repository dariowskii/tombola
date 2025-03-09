import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tombola/features/game_session_screen/presentation/game_session_screen.dart';
import 'package:tombola/features/admin_screen/presentation/admin_screen.dart';
import 'package:tombola/screens/login_screen.dart';
import 'package:tombola/features/welcome_screen/presentation/welcome_screen.dart';

part 'routes.g.dart';

@TypedGoRoute<WelcomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<LoginRoute>(path: 'login'),
    TypedGoRoute<AdminRoute>(path: 'admin'),
    TypedGoRoute<GameSessionRoute>(path: 'game'),
  ],
)
class WelcomeRoute extends GoRouteData {
  const WelcomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const WelcomeScreen();
  }
}

class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (FirebaseAuth.instance.currentUser != null) {
      return const AdminRoute().location;
    }

    return null;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

class AdminRoute extends GoRouteData {
  const AdminRoute();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const WelcomeRoute().location;
    }

    return null;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminScreen();
  }
}

class GameSessionRoute extends GoRouteData {
  const GameSessionRoute({
    this.session,
  });

  final String? session;

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    final sessionId = session;
    if (sessionId == null || sessionId.isEmpty) {
      return const WelcomeRoute().location;
    }

    return null;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return GameSessionScreen(sessionId: session!);
  }
}
