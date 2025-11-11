import 'package:flutter/material.dart';

@immutable
final class ThemeColors extends ThemeExtension<ThemeColors> {
  const ThemeColors({
    required this.white,
    required this.black,
    required this.success,
    required this.error,
    required this.transparent,
    required this.primary,
    required this.secondary,
    required this.textFieldBackground,
    required this.hintText,
    required this.gray900,
    required this.gray400,
  });

  final Color white;
  final Color black;
  final Color success;
  final Color error;
  final Color transparent;
  final Color primary;
  final Color secondary;
  final Color textFieldBackground;
  final Color hintText;
  final Color gray900;
  final Color gray400;

  static const ThemeColors light = ThemeColors(
    white: Colors.white,
    black: Colors.black,
    success: Color(0xFF17B26A),
    error: Color(0xFFF76659),
    transparent: Colors.transparent,
    primary: Color(0xFF642FF4),
    secondary: Color(0x29D83A88),
    textFieldBackground: Color(0xFFF2F4F7),
    hintText: Color(0xFF98A2B3),
    gray900: Color(0xFF101828),
    gray400: Color(0xFF98A2B3),
  );

  static const ThemeColors dark = ThemeColors(
    white: Color(0xFF1C1C1E),
    black: Colors.black,
    success: Color(0xFF17B26A),
    error: Color(0xFFF76659),
    transparent: Colors.transparent,
    primary: Color(0xFF642FF4),
    secondary: Color(0x29D83A88),
    textFieldBackground: Color(0xFFF2F4F7),
    hintText: Color(0xFF98A2B3),
    gray900: Color(0xFF101828),
    gray400: Color(0xFF98A2B3),
  );

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? white,
    Color? black,
    Color? success,
    Color? error,
    Color? transparent,
    Color? primary,
    Color? secondary,
    Color? textFieldBackground,
    Color? hintText,
    Color? gray900,
    Color? gray400,
  }) => ThemeColors(
    white: white ?? this.white,
    black: black ?? this.black,
    success: success ?? this.success,
    error: error ?? this.error,
    transparent: transparent ?? this.transparent,
    primary: primary ?? this.primary,
    secondary: secondary ?? this.secondary,
    textFieldBackground: textFieldBackground ?? this.textFieldBackground,
    hintText: hintText ?? this.hintText,
    gray900: gray900 ?? this.gray900,
    gray400: gray400 ?? this.gray400,
  );

  @override
  ThemeExtension<ThemeColors> lerp(ThemeExtension<ThemeColors>? other, double t) => other is! ThemeColors
      ? this
      : ThemeColors(
          black: Color.lerp(black, other.black, t)!,
          white: Color.lerp(white, other.white, t)!,
          transparent: Color.lerp(transparent, other.transparent, t)!,
          primary: Color.lerp(primary, other.primary, t)!,
          secondary: Color.lerp(secondary, other.secondary, t)!,
          success: Color.lerp(success, other.success, t)!,
          error: Color.lerp(error, other.error, t)!,
          textFieldBackground: Color.lerp(textFieldBackground, other.textFieldBackground, t)!,
          hintText: Color.lerp(hintText, other.hintText, t)!,
          gray900: Color.lerp(gray900, other.gray900, t)!,
          gray400: Color.lerp(gray400, other.gray400, t)!,
        );
}
