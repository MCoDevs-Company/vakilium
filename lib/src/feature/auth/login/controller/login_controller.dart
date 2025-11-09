import 'package:flutter/material.dart';
import 'package:vakilium/src/feature/auth/login/screens/login_screen.dart';

abstract class LoginController extends State<LoginScreen> {
  late final TextEditingController phoneNumberController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
