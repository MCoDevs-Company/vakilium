import 'package:flutter/material.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/util/dimension.dart';

class ButtonWrapper extends StatelessWidget {
  const ButtonWrapper({required this.child, super.key, this.onPressed});

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onPressed,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.color.gray300),
        borderRadius: Dimension.rAll10,
      ),
      padding: Dimension.pAll10,
      child: child,
    ),
  );
}
