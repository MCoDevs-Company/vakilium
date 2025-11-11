import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
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
                        label: context.l10n.phoneNumber,
                        hintText: "+998 __ ___-__-__",
                        inputFormatter: MaskTextInputFormatter(mask: '+998 ## ###-##-##'),
                        keyboardType: TextInputType.phone,
                      ),
                      Dimension.hBox16,
                    ],
                  ),
                ),
              ),
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
