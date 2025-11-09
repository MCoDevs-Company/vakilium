import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/router/router.dart';
import 'package:vakilium/src/common/util/dimension.dart';
import 'package:vakilium/src/common/widgets/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(context.l10n.loginTitle, style: context.textTheme.interW600s24),
            Dimension.hBox24,
            const AppTextField(),
            Dimension.hBox16,
            const AppTextField(),
            Dimension.hBox8,
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text(context.l10n.forgotPassword, style: context.textTheme.interW400s14)],
              ),
            ),
            Dimension.hBox32,
            FilledButton(
              onPressed: () {},
              child: Text(context.l10n.loginTitle),
            ),
            Dimension.hBox12,
            OutlinedButton(
              onPressed: () => context.go(Routes.register),
              child: Text(context.l10n.registerTitle),
            ),
          ],
        ),
      );
}
