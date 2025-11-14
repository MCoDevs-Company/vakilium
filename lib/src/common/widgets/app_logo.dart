import 'package:flutter/material.dart';
import 'package:vakilium/src/common/constant/gen/assets.gen.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/util/dimension.dart';

class AppLogo extends StatelessWidget {
  const AppLogo._({required this.isVertical, required this.isBig, Key? key}) : super(key: key);

  const AppLogo.vertical({Key? key, bool isBig = false}) : this._(key: key, isVertical: true, isBig: isBig);
  const AppLogo.horizontal({Key? key, bool isBig = false}) : this._(key: key, isVertical: false, isBig: isBig);

  final bool isVertical;
  final bool isBig;

  @override
  Widget build(BuildContext context) {
    double size = isBig ? 100 : 32;
    double fontSize = isBig ? 48 : 20;
    final children = [
      Assets.icons.logo.svg(height: size, width: size),
      Dimension.wBox8,
      Text(
        "VAKILIUM",
        style: context.textTheme.interW600s20.copyWith(color: Colors.white, fontSize: fontSize),
      ),
    ];

    return switch (isVertical) {
      true => Column(mainAxisSize: MainAxisSize.min, children: children),
      false => Row(mainAxisSize: MainAxisSize.min, children: children),
    };
  }
}
