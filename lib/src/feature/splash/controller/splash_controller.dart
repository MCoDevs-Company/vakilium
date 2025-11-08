import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vakilium/src/common/router/router.dart';
import 'package:vakilium/src/feature/splash/screens/splash_screen.dart';

abstract class SplashController extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() {
    Future.delayed(const Duration(seconds: 2), () {
      context.goNamed(Routes.login);
    });
  }
}
