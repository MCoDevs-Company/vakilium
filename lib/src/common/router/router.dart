import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vakilium/src/feature/auth/login/screens/login_screen.dart';
import 'package:vakilium/src/feature/auth/register/screens/register_screen.dart';
import 'package:vakilium/src/feature/auth/widgets/auth_shell.dart';
import 'package:vakilium/src/feature/splash/screens/splash_screen.dart';

sealed class Routes {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _loginNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'loginBranch');
  static final GlobalKey<NavigatorState> _registerNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'registerBranch',
  );

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, name: splash, builder: (context, state) => const SplashScreen()),
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state, navigationShell) => CustomTransitionPage(
          child: AuthShell(child: navigationShell),
          transitionDuration: Durations.extralong2,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
        branches: [
          StatefulShellBranch(
            navigatorKey: _loginNavigatorKey,
            routes: [GoRoute(path: login, name: login, builder: (context, state) => const LoginScreen())],
          ),
          StatefulShellBranch(
            navigatorKey: _registerNavigatorKey,
            routes: [GoRoute(path: register, name: register, builder: (context, state) => const RegisterScreen())],
          ),
        ],
      ),
    ],
  );

  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
}
