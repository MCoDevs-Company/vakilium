import 'package:flutter/material.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/util/dimension.dart';

class AppButton extends StatefulWidget {
  const AppButton({super.key, this.onPressed, this.title, this.backgroundColor, this.isPrimary = true});

  final VoidCallback? onPressed;
  final String? title;
  final Color? backgroundColor;
  final bool isPrimary;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) => FilledButton(
    onPressed: widget.onPressed,
    style: FilledButton.styleFrom(
      backgroundColor:
          widget.backgroundColor ??
          switch (widget.isPrimary) {
            true => context.color.black,
            false => context.color.textFieldBackground,
          },
      disabledBackgroundColor: context.color.textFieldBackground,
      shape: const RoundedRectangleBorder(borderRadius: Dimension.rAll12),
      minimumSize: const Size.fromHeight(44),
      padding: Dimension.pV10H12,
    ),

    child: Text(
      widget.title ?? '',
      style: context.textTheme.interW600s14.copyWith(
        color: switch (widget.isPrimary) {
          _ when widget.onPressed == null => context.color.gray400,
          true => context.color.white,
          false => null,
        },
      ),
    ),
  );
}
