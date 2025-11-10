import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/router/router.dart';
import 'package:vakilium/src/common/util/dimension.dart';
import 'package:vakilium/src/common/widgets/app_text_field.dart';
import 'package:vakilium/src/feature/auth/login/controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends LoginController {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
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
                      Text(context.l10n.loginTitle, style: context.textTheme.interW600s24),
                      Dimension.hBox24,
                      AppTextField(
                        label: context.l10n.phoneNumber,
                        controller: phoneNumberController,
                        hintText: "+998 __ ___-__-__",
                        inputFormatter: MaskTextInputFormatter(mask: '+998 ## ###-##-##'),
                        keyboardType: TextInputType.phone,
                      ),
                      Dimension.hBox16,
                      AppTextField(
                        label: context.l10n.password,
                        controller: passwordController,
                        hintText: context.l10n.enterPassword,
                        isPasswordField: true,
                      ),
                      Dimension.hBox8,
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              context.l10n.forgotPassword,
                              style: context.textTheme.interW400s14.copyWith(color: context.color.gray900),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppButton(onPressed: () {}, title: context.l10n.loginTitle),
              Dimension.hBox8,
              AppButton(
                onPressed: () => context.goNamed(Routes.register),
                title: context.l10n.registerTitle,
                isPrimary: false,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class AppButton extends StatefulWidget {
  const AppButton({super.key, this.onPressed, this.title, this.backgroundColor, this.isPrimary = true});

  final VoidCallback? onPressed;
  final String? title;
  final Color? backgroundColor;
  final bool isPrimary;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) => FilledButton(
    onPressed: widget.onPressed,
    style: FilledButton.styleFrom(
      backgroundColor:
          widget.backgroundColor ??
          switch (widget.isPrimary) {
            true => context.color.black,
            false => context.color.textFieldBackground,
          },
      shape: const RoundedRectangleBorder(borderRadius: Dimension.rAll12),
      minimumSize: const Size.fromHeight(44),
      padding: Dimension.pV10H12,
    ),

    child: Text(
      widget.title ?? '',
      style: context.textTheme.interW600s14.copyWith(
        color: switch (widget.isPrimary) {
          true => context.color.white,
          false => null,
        },
      ),
    ),
  );
}
