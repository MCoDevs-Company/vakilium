import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vakilium/src/common/constant/gen/assets.gen.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/util/dimension.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.isPasswordField = false,
    this.controller,
    this.label,
    this.hintText,
    this.inputFormatter,
    this.keyboardType,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.autofocus = false,
    this.focusNode,
    this.onTap,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.none,
  });

  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputFormatter? inputFormatter;
  final TextInputType? keyboardType;
  final bool isPasswordField;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final bool autofocus;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextCapitalization textCapitalization;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final ValueNotifier<bool> _obscureText;

  @override
  void initState() {
    _obscureText = ValueNotifier<bool>(widget.isPasswordField);
    super.initState();
  }

  @override
  void dispose() {
    _obscureText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (widget.label != null) ...[
        Text(widget.label!, style: context.textTheme.interW500s14.copyWith(color: const Color(0xFF080A15))),
        Dimension.hBox8,
      ],
      ValueListenableBuilder(
        valueListenable: _obscureText,
        builder: (context, isObscure, child) => TextFormField(
          autofocus: widget.autofocus,
          focusNode: widget.focusNode,
          validator: widget.validator,
          obscureText: isObscure,
          controller: widget.controller,
          style: context.textTheme.interW400s14,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          textCapitalization: widget.textCapitalization,
          inputFormatters: switch (widget.inputFormatter) {
            TextInputFormatter inputFormatter => [inputFormatter],
            _ => null,
          },
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            // Padding
            isDense: true,
            contentPadding: Dimension.pH12V11,

            // Fill
            filled: true,
            fillColor: context.color.textFieldBackground,

            // Hint
            hintText: widget.hintText,
            hintStyle: context.textTheme.interW400s14.copyWith(color: context.color.hintText),

            suffixIcon: switch (widget.isPasswordField) {
              true => IconButton(
                icon: ValueListenableBuilder(
                  valueListenable: _obscureText,
                  builder: (context, isObscure, child) => switch (isObscure) {
                    true => Assets.icons.visibilityOn,
                    false => Assets.icons.visibilityOff,
                  }.svg(),
                ),
                onPressed: () => _obscureText.value = !_obscureText.value,
              ),
              false => widget.suffixIcon,
            },

            prefixIcon: widget.prefixIcon,

            // Borders
            border: _getBorder(),
            enabledBorder: _getBorder(),
            focusedBorder: _getBorder(),
            errorBorder: _getBorder(borderSide: BorderSide(color: context.color.error)),
          ),
        ),
      ),
    ],
  );

  OutlineInputBorder _getBorder({BorderSide borderSide = BorderSide.none}) =>
      OutlineInputBorder(borderRadius: Dimension.rAll8, borderSide: borderSide);
}
