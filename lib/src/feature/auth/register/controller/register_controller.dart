import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:vakilium/src/common/router/router.dart';

abstract class RegisterController<T extends StatefulWidget> extends State<T> {
  late final TextEditingController phoneNumberController;
  final mask = MaskTextInputFormatter(mask: '+998 ## ###-##-##');
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  void onRegister() {
    if (!formKey.currentState!.validate()) return;
    context.pushNamed(Routes.otp, extra: phoneNumberController.text);
  }

  void onConfirmPressed() => context.goNamed(Routes.recoverOtp, extra: phoneNumberController.text);

  void onLoginPressed() => context.goNamed(Routes.login);
}
