import 'package:flutter/material.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/util/dimension.dart';
import 'package:vakilium/src/common/widgets/app_button.dart';
import 'package:vakilium/src/common/widgets/app_text_field.dart';
import 'package:vakilium/src/feature/auth/new_password/controller/new_password_controller.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends NewPasswordController {
  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.color.white,
    child: LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: constraints.maxHeight,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: Dimension.pZero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.l10n.setPasswordTitle, style: context.textTheme.interW600s24),
                        Dimension.hBox24,
                        Form(
                          key: formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextField(
                                autofocus: true,
                                label: context.l10n.password,
                                hintText: context.l10n.enterPassword,
                                controller: passwordController,
                                textInputAction: TextInputAction.next,
                                isPasswordField: true,
                                validator: validatePassword,
                              ),
                              Dimension.hBox8,
                              Text(
                                context.l10n.minimumCharacters(NewPasswordController.minPasswordLength),
                                style: context.textTheme.interW400s14.copyWith(color: context.color.hintText),
                              ),
                              Dimension.hBox16,
                              AppTextField(
                                label: context.l10n.confirmPassword,
                                hintText: context.l10n.enterPassword,
                                controller: confirmPasswordController,
                                textInputAction: TextInputAction.done,
                                isPasswordField: true,
                                validator: validateConfirmPassword,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Dimension.hBox32,
                ValueListenableBuilder<bool>(
                  valueListenable: isSubmitEnabled,
                  builder: (context, isEnabled, child) =>
                      AppButton(onPressed: isEnabled ? onSubmit : null, title: context.l10n.confirm),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
