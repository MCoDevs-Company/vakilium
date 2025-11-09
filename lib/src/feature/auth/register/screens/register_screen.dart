import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/router/router.dart';
import 'package:vakilium/src/common/util/dimension.dart';
import 'package:vakilium/src/common/widgets/app_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(context.l10n.registerTitle, style: context.textTheme.interW600s24),
        Dimension.hBox24,
        const AppTextField(),
        Dimension.hBox16,
        const AppTextField(),
        Dimension.hBox32,
        FilledButton(onPressed: () {}, child: Text(context.l10n.registerTitle)),
        Dimension.hBox12,
        OutlinedButton(onPressed: () => context.go(Routes.login), child: Text(context.l10n.loginTitle)),
        Dimension.hBox16,
        Text(
          context.l10n.registerAgreement,
          style: context.textTheme.interW400s14.copyWith(color: context.colorScheme.onSurfaceVariant),
        ),
      ],
    ),
  );
}
