import 'package:flutter/material.dart';
import 'package:vakilium/src/common/constant/gen/assets.gen.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/util/dimension.dart';
import 'package:vakilium/src/common/widgets/app_logo.dart';
import 'package:vakilium/src/feature/auth/widgets/auth_top_widget.dart';

/// Hosts the shared purple header and rounded white content container.
class AuthShell extends StatefulWidget {
  const AuthShell({required this.child, super.key});

  final Widget child;

  @override
  State<AuthShell> createState() => _AuthShellState();
}

class _AuthShellState extends State<AuthShell> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: context.responsive(mobile: _buildMobile(), desktop: _buildDesktop()),
  );

  Widget _buildDesktop() => Row(
    children: [
      Expanded(child: widget.child),
      Expanded(
        child: Stack(
          fit: StackFit.expand,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [context.color.primary.withValues(alpha: 0.5), context.color.primary.withValues(alpha: 0)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ).createShader(bounds),
              blendMode: BlendMode.srcATop,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(Assets.images.authBackground.path), fit: BoxFit.cover),
                ),
              ),
            ),
            const Center(child: AppLogo.vertical(isBig: true)),
          ],
        ),
      ),
    ],
  );

  Widget _buildMobile() => LayoutBuilder(
    builder: (context, constraints) {
      final screenHeight = MediaQuery.sizeOf(context).height;
      final layoutHeight = constraints.maxHeight;
      final isKeyboardOpen = layoutHeight < screenHeight * 0.8;
      final contentHeight = isKeyboardOpen ? constraints.maxHeight : constraints.maxHeight * 0.8;
      return Stack(
        children: [
          AuthTopWidget(maxHeight: constraints.maxHeight),
          SafeArea(
            bottom: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: DecoratedBox(
                decoration: BoxDecoration(borderRadius: Dimension.rTop20, color: context.color.white),
                child: SizedBox(
                  height: contentHeight,
                  child: Padding(padding: Dimension.pV16H20, child: widget.child),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
