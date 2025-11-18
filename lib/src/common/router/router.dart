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
import 'package:vakilium/src/feature/main/screens/main_shell.dart';
import 'package:vakilium/src/feature/splash/screens/splash_screen.dart';

sealed class Routes {
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> authShellKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, name: splash, builder: (context, state) => const SplashScreen()),
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state, navigationShell) => CustomTransitionPage(
          child: AuthShell(authKey: authShellKey, child: navigationShell),
          transitionDuration: Durations.extralong2,
          transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
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
      GoRoute(path: main, name: main, builder: (context, state) => const MainShell()),
      // StatefulShellRoute.indexedStack(
      //   parentNavigatorKey: rootNavigatorKey,
      //   pageBuilder: (context, state, navigationShell) => CustomTransitionPage(
      //     child: MainShell(child: navigationShell),
      //     transitionDuration: Durations.extralong2,
      //     transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
      //   ),
      //   branches: [
      //     StatefulShellBranch(
      //       routes: [GoRoute(path: home, name: home, builder: (context, state) => const HomeScreen())],
      //     ),
      //     StatefulShellBranch(
      //       routes: [GoRoute(path: services, name: services, builder: (context, state) => const Scaffold())],
      //     ),
      //     StatefulShellBranch(
      //       routes: [GoRoute(path: requests, name: requests, builder: (context, state) => const Scaffold())],
      //     ),
      //     StatefulShellBranch(
      //       routes: [GoRoute(path: chat, name: chat, builder: (context, state) => const Scaffold())],
      //     ),
      //   ],
      // ),
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
  static const String main = '/main';
  // static const String services = '/services';
  // static const String requests = '/requests';
  // static const String chat = '/chat';
}
