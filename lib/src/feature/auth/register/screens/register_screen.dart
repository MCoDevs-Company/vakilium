import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vakilium/src/common/constant/gen/assets.gen.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/util/dimension.dart';
import 'package:vakilium/src/common/widgets/app_button.dart';
import 'package:vakilium/src/common/widgets/app_text_field.dart';
import 'package:vakilium/src/feature/auth/register/controller/register_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends RegisterController {
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(context.l10n.registerTitle, style: context.textTheme.interW600s24),
                        Dimension.hBox24,
                        Form(
                          key: formKey,
                          child: AppTextField(
                            prefixIcon: Padding(
                              padding: Dimension.pH10,
                              child: Assets.icons.globus.svg(height: 24, width: 24),
                            ),
                            label: context.l10n.phoneNumber,
                            hintText: "+998 __ ___-__-__",
                            inputFormatter: mask,
                            keyboardType: TextInputType.phone,
                            controller: phoneNumberController,
                          ),
                        ),
                        Dimension.hBox16,
                      ],
                    ),
                  ),
                ),
                Dimension.hBox8,
                RichText(
                  // TODO: Add user agreement with localization
                  text: TextSpan(
                    text: "Регистрируясь, вы соглашаетесь с правилами ",
                    style: context.textTheme.interW400s14.copyWith(color: context.color.hintText),
                    children: [
                      TextSpan(
                        text: "пользовательское соглашение",
                        style: context.textTheme.interW400s14.copyWith(color: context.color.primary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // TODO: Open user agreement
                          },
                      ),
                    ],
                  ),
                ),
                Dimension.hBox20,
                ValueListenableBuilder(
                  valueListenable: phoneNumberController,
                  builder: (context, phone, child) {
                    final isEnabled = mask.unmaskText(phone.text).length == 9;
                    return AppButton(onPressed: isEnabled ? onRegister : null, title: context.l10n.registerTitle);
                  },
                ),
                Dimension.hBox8,
                AppButton(onPressed: onLoginPressed, title: context.l10n.loginTitle, isPrimary: false),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
