import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tombola/features/admin_game_session_screen/presentation/admin_game_session_screen.dart';
import 'package:tombola/features/game_session_screen/presentation/game_session_screen.dart';
import 'package:tombola/features/admin_screen/presentation/admin_screen.dart';
import 'package:tombola/features/setup_game_screen/presentation/setup_game_screen.dart';
import 'package:tombola/screens/login_screen.dart';
import 'package:tombola/features/welcome_screen/presentation/welcome_screen.dart';

part 'routes.g.dart';

@TypedGoRoute<WelcomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<LoginRoute>(path: 'login'),
    TypedGoRoute<SetupGameRoute>(path: 'setup-session/:id'),
    TypedGoRoute<GameSessionRoute>(path: 'game/:id/raffle/:raffleId'),
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

class SetupGameRoute extends GoRouteData {
  const SetupGameRoute({
    required this.id,
  });

  final String id;

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (id.isEmpty) {
      return const WelcomeRoute().location;
    }

    return null;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SetupGameScreen(sessionId: id);
  }
}

class GameSessionRoute extends GoRouteData {
  const GameSessionRoute({
    required this.id,
    required this.raffleId,
  });

  final String id;
  final String raffleId;

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (id.isEmpty || raffleId.isEmpty) {
      return const WelcomeRoute().location;
    }

    return null;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return GameSessionScreen(
      sessionId: id,
      raffleId: raffleId,
    );
  }
}

/*
* ------------------
*    ADMIN ROUTE
* ------------------
*/

@TypedGoRoute<AdminRoute>(
  path: '/admin',
  routes: [
    TypedGoRoute<AdminGameSessionRoute>(path: 'session/:id'),
  ],
)
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

class AdminGameSessionRoute extends GoRouteData {
  const AdminGameSessionRoute({
    required this.id,
  });

  final String id;

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const WelcomeRoute().location;
    }
    if (id.isEmpty) {
      return const AdminRoute().location;
    }

    return null;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AdminGameSessionScreen(sessionId: id);
  }
}
