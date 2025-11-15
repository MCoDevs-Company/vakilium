import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vakilium/src/feature/auth/forgot_password/screens/forgot_password_screen.dart';
import 'package:vakilium/src/feature/auth/otp/screens/recover_otp_screen.dart';
import 'package:vakilium/src/feature/auth/login/screens/login_screen.dart';
import 'package:vakilium/src/feature/auth/new_password/screens/new_password_screen.dart';
import 'package:vakilium/src/feature/auth/otp/screens/otp_screen.dart';
import 'package:vakilium/src/feature/auth/register/screens/register_screen.dart';
import 'package:vakilium/src/feature/auth/user_info/screens/user_info_screen.dart';
import 'package:vakilium/src/feature/auth/widgets/auth_shell.dart';
import 'package:vakilium/src/feature/splash/screens/splash_screen.dart';

sealed class Routes {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

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
            routes: [GoRoute(path: login, name: login, builder: (context, state) => const LoginScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: register, name: register, builder: (context, state) => const RegisterScreen())],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: otp,
                name: otp,
                builder: (context, state) => OtpScreen(phoneNumber: state.extra as String),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: userInfo, name: userInfo, builder: (context, state) => const UserInfoScreen())],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: newPassword, name: newPassword, builder: (context, state) => const NewPasswordScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: forgotPassword,
                name: forgotPassword,
                builder: (context, state) => const ForgotPasswordScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: recoverOtp,
                name: recoverOtp,
                builder: (context, state) => RecoverOtpScreen(phoneNumber: state.extra as String),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String userInfo = '/user-info';
  static const String newPassword = '/new-password';
  static const String forgotPassword = '/forgot-password';
  static const String recoverOtp = '/recover-otp';
}
