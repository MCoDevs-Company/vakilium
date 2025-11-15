import 'package:flutter/material.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';

class AppCircularIndicator extends StatelessWidget {
  const AppCircularIndicator({super.key, this.value});
  final double? value;

  @override
  Widget build(BuildContext context) => Center(
    child: CircularProgressIndicator.adaptive(
      strokeCap: StrokeCap.round,
      strokeWidth: 6,
      valueColor: AlwaysStoppedAnimation(context.color.primary),
      backgroundColor: context.color.primary,
      value: value,
    ),
  );
}
