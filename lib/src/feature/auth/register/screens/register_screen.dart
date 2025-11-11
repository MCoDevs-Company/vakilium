import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:vakilium/src/common/constant/gen/assets.gen.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/router/router.dart';
import 'package:vakilium/src/common/util/dimension.dart';
import 'package:vakilium/src/common/widgets/app_button.dart';
import 'package:vakilium/src/common/widgets/app_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                      Text(context.l10n.registerTitle, style: context.textTheme.interW600s24),
                      Dimension.hBox24,
                      AppTextField(
                        prefixIcon: Padding(
                          padding: Dimension.pH10,
                          child: Assets.icons.globus.svg(height: 24, width: 24),
                        ),
                        label: context.l10n.phoneNumber,
                        hintText: "+998 __ ___-__-__",
                        inputFormatter: MaskTextInputFormatter(mask: '+998 ## ###-##-##'),
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                      ),
                      Dimension.hBox16,
                    ],
                  ),
                ),
              ),
              Dimension.hBox8,
              RichText(
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
              AppButton(onPressed: () {}, title: context.l10n.registerTitle),
              Dimension.hBox8,
              AppButton(
                onPressed: () => context.goNamed(Routes.login),
                title: context.l10n.loginTitle,
                isPrimary: false,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
