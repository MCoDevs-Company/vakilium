import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:vakilium/src/common/constant/gen/assets.gen.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/util/dimension.dart';
import 'package:vakilium/src/common/widgets/app_button.dart';
import 'package:vakilium/src/common/widgets/app_text_field.dart';
import 'package:vakilium/src/feature/auth/login/controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends LoginController {
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
                        Text(context.l10n.loginTitle, style: context.textTheme.interW600s24),
                        Dimension.hBox24,
                        AppTextField(
                          prefixIcon: Padding(
                            padding: Dimension.pH10,
                            child: Assets.icons.globus.svg(height: 24, width: 24),
                          ),
                          label: context.l10n.phoneNumber,
                          controller: phoneNumberController,
                          hintText: "+998 __ ___-__-__",
                          inputFormatter: MaskTextInputFormatter(mask: '+998 ## ###-##-##'),
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
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
                AppButton(onPressed: onRegisterPressed, title: context.l10n.registerTitle, isPrimary: false),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
