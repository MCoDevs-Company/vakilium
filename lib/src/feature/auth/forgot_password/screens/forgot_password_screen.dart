import 'package:flutter/material.dart';
import 'package:vakilium/src/common/constant/gen/assets.gen.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/util/dimension.dart';
import 'package:vakilium/src/common/widgets/app_button.dart';
import 'package:vakilium/src/common/widgets/app_text_field.dart';
import 'package:vakilium/src/feature/auth/register/controller/register_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends RegisterController<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) => context.responsive(mobile: _buildMobile(), desktop: _buildDesktop());

  Widget _buildDesktop() => ColoredBox(
    color: context.color.white,
    child: Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: Dimension.pH40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.l10n.recoverPassword,
                  style: context.textTheme.interW600s24.copyWith(fontSize: 32),
                  textAlign: TextAlign.start,
                ),
                Dimension.hBox24,
                Form(
                  key: formKey,
                  child: AppTextField(
                    prefixIcon: Padding(padding: Dimension.pH10, child: Assets.icons.globus.svg(height: 24, width: 24)),
                    label: context.l10n.phoneNumber,
                    hintText: "+998 __ ___-__-__",
                    inputFormatter: mask,
                    keyboardType: TextInputType.phone,
                    controller: phoneNumberController,
                  ),
                ),
                Dimension.hBox24,
                ValueListenableBuilder(
                  valueListenable: phoneNumberController,
                  builder: (context, phone, child) {
                    final isEnabled = mask.unmaskText(phone.text).length == 9;
                    return AppButton(onPressed: isEnabled ? onConfirmPressed : null, title: context.l10n.confirm);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget _buildMobile() => ColoredBox(
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
                        Text(context.l10n.recoverPassword, style: context.textTheme.interW600s24),
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
                Dimension.hBox24,
                ValueListenableBuilder(
                  valueListenable: phoneNumberController,
                  builder: (context, phone, child) {
                    final isEnabled = mask.unmaskText(phone.text).length == 9;
                    return AppButton(onPressed: isEnabled ? onConfirmPressed : null, title: context.l10n.confirm);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
