import 'package:flutter/material.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/util/dimension.dart';
import 'package:vakilium/src/feature/auth/widgets/auth_top_widget.dart';

/// Hosts the shared purple header and rounded white content container.
class AuthShell extends StatelessWidget {
  const AuthShell({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              AuthTopWidget(maxHeight: constraints.maxHeight),
              Align(
                alignment: Alignment.bottomCenter,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: Dimension.rTop20,
                    color: context.color.white,
                  ),
                  child: SizedBox(
                    height: constraints.maxHeight * 0.8,
                    child: Padding(
                      padding: Dimension.pV16H20,
                      child: child,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
