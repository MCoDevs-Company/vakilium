import 'package:flutter/material.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/util/dimension.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(context.l10n.phoneNumber, style: context.textTheme.interW500s14.copyWith(color: const Color(0xFF080A15))),
      Dimension.hBox8,
      TextFormField(
        style: context.textTheme.interW400s14,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          filled: true,
          fillColor: const Color(0xFFF2F4F7),
          hintText: context.l10n.enterPhoneNumber,
          hintStyle: context.textTheme.interW400s14.copyWith(color: const Color(0xFF98A2B3)),
          border: const OutlineInputBorder(borderRadius: Dimension.rAll8, borderSide: BorderSide.none),
          enabledBorder: const OutlineInputBorder(borderRadius: Dimension.rAll8, borderSide: BorderSide.none),
          focusedBorder: const OutlineInputBorder(borderRadius: Dimension.rAll8, borderSide: BorderSide.none),
        ),
      ),
    ],
  );
}
