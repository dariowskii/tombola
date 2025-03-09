import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tombola/router/routes.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  var initialLocation = const WelcomeRoute().location;

  if (FirebaseAuth.instance.currentUser != null) {
    initialLocation = const AdminRoute().location;
  }

  return GoRouter(
    routes: $appRoutes,
    initialLocation: initialLocation,
  );
}
