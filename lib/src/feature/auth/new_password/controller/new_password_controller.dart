import 'package:flutter/material.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/router/router.dart';
import 'package:vakilium/src/common/util/logger.dart';
import 'package:vakilium/src/common/util/notification_manager.dart';
import 'package:vakilium/src/feature/auth/new_password/screens/new_password_screen.dart';

abstract class NewPasswordController extends State<NewPasswordScreen> {
  static const int minPasswordLength = 8;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final ValueNotifier<bool> isSubmitEnabled;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    isSubmitEnabled = ValueNotifier<bool>(false);

    passwordController.addListener(_onFormChanged);
    confirmPasswordController.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    final password = passwordController.text.trim();
    final confirm = confirmPasswordController.text.trim();
    final isValid = password.length >= minPasswordLength && confirm.isNotEmpty;
    if (isSubmitEnabled.value != isValid) {
      isSubmitEnabled.value = isValid;
    }
  }

  String? validatePassword(String? value) {
    final text = value?.trim() ?? '';
    if (text.length < minPasswordLength) {
      return context.l10n.passwordTooShort(minPasswordLength);
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    final error = validatePassword(value);
    if (error != null) return error;
    if (passwordController.text.trim() != (value?.trim() ?? '')) {
      return context.l10n.passwordsDoNotMatch;
    }
    return null;
  }

  Future<void> onSubmit() async {
    FocusScope.of(context).unfocus();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    final globalContext = context.responsive(mobile: Routes.authShellKey.currentContext, desktop: context);

    // Check if passwords match
    if (password != confirmPassword && formKey.currentState?.validate() != true && globalContext != null) {
      NotificationManager.show(globalContext, context.l10n.passwordsDoNotMatch, NotificationVariant.error);
      return;
    }

    info('New password confirmed: $password');

    // context.goNamed(Routes.home);
  }

  @override
  void dispose() {
    passwordController.removeListener(_onFormChanged);
    confirmPasswordController.removeListener(_onFormChanged);
    passwordController.dispose();
    confirmPasswordController.dispose();
    isSubmitEnabled.dispose();
    super.dispose();
  }
}
