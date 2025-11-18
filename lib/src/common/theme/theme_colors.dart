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
    required this.gray800,
    required this.gray700,
    required this.gray400,
    required this.gray300,
    required this.gray200,
    required this.gray100,
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
  final Color gray800;
  final Color gray700;
  final Color gray400;
  final Color gray300;
  final Color gray200;
  final Color gray100;

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
    gray800: Color(0xFF1D2939),
    gray700: Color(0xFF344054),
    gray400: Color(0xFF98A2B3),
    gray300: Color(0xFFD0D5DD),
    gray200: Color(0xFFEAECF0),
    gray100: Color(0xFFF2F4F7),
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
    gray800: Color(0xFF1D2939),
    gray700: Color(0xFF344054),
    gray400: Color(0xFF98A2B3),
    gray300: Color(0xFFD0D5DD),
    gray200: Color(0xFFEAECF0),
    gray100: Color(0xFFF2F4F7),
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
    Color? gray800,
    Color? gray700,
    Color? gray400,
    Color? gray300,
    Color? gray200,
    Color? gray100,
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
    gray800: gray800 ?? this.gray800,
    gray700: gray700 ?? this.gray700,
    gray400: gray400 ?? this.gray400,
    gray300: gray300 ?? this.gray300,
    gray200: gray200 ?? this.gray200,
    gray100: gray100 ?? this.gray100,
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
          gray800: Color.lerp(gray800, other.gray800, t)!,
          gray700: Color.lerp(gray700, other.gray700, t)!,
          gray400: Color.lerp(gray400, other.gray400, t)!,
          gray300: Color.lerp(gray300, other.gray300, t)!,
          gray200: Color.lerp(gray200, other.gray200, t)!,
          gray100: Color.lerp(gray100, other.gray100, t)!,
        );
}
