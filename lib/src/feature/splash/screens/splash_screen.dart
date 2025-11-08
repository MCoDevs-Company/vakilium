import 'package:flutter/material.dart';
import 'package:vakilium/src/feature/splash/controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends SplashController {
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Splash Screen')));
}
