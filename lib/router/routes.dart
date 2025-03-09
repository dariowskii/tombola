import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tombola/screens/admin_screen.dart';
import 'package:tombola/screens/login_screen.dart';
import 'package:tombola/screens/welcome_screen.dart';

part 'routes.g.dart';

@TypedGoRoute<WelcomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<LoginRoute>(path: 'login'),
    TypedGoRoute<AdminRoute>(path: 'admin'),
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
      return const AdminRoute().location; // Redirect to the admin screen
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
      return const WelcomeRoute().location; // Redirect to the welcome screen
    }

    return null;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminScreen();
  }
}
