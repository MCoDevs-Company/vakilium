import 'package:flutter/material.dart';
import 'package:vakilium/src/common/constant/gen/assets.gen.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/util/dimension.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Assets.icons.logo.svg(height: 32, width: 32),
      Dimension.wBox8,
      Text("VAKILIUM", style: context.textTheme.interW600s20.copyWith(color: Colors.white)),
    ],
  );
}
