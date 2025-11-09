import 'package:flutter/material.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/util/dimension.dart';
import 'package:vakilium/src/common/widgets/app_text_field.dart';
import 'package:vakilium/src/feature/auth/widgets/auth_top_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          AuthTopWidget(maxHeight: constraints.maxHeight),
          Align(
            alignment: Alignment.bottomCenter,
            child: DecoratedBox(
              decoration: BoxDecoration(borderRadius: Dimension.rTop20, color: context.color.white),
              child: SizedBox.fromSize(
                size: Size.fromHeight(constraints.maxHeight * 0.8),
                child: Padding(
                  padding: Dimension.pV16H20,
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
