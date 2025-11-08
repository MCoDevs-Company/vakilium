import 'package:flutter/material.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/util/dimension.dart';
import 'package:vakilium/src/common/widgets/app_logo.dart';
import 'package:vakilium/src/feature/auth/widgets/language_selector.dart';

class AuthTopWidget extends StatelessWidget {
  const AuthTopWidget({required this.maxHeight, super.key});

  final double maxHeight;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [context.color.black, context.color.primary],
        stops: const [0, .5],
        end: Alignment.bottomCenter,
        begin: Alignment.topCenter,
      ),
    ),
    child: SizedBox.fromSize(
      size: Size.fromHeight(maxHeight * 0.6),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: maxHeight * 0.2,
              child: const SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: Dimension.pH16Top16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [AppLogo(), LanguageSelector()],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
