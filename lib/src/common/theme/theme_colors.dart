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
  });

  final Color white;
  final Color black;
  final Color success;
  final Color error;
  final Color transparent;
  final Color primary;
  final Color secondary;

  static const ThemeColors light = ThemeColors(
    white: Colors.white,
    black: Colors.black,
    success: Color(0xFF17B26A),
    error: Color(0xFFF04438),
    transparent: Colors.transparent,
    primary: Color(0xFFD83A88),
    secondary: Color(0x29D83A88),
  );

  static const ThemeColors dark = ThemeColors(
    white: Color(0xFF1C1C1E),
    black: Colors.black,
    success: Color(0xFF17B26A),
    error: Color(0xFFF04438),
    transparent: Colors.transparent,
    primary: Color(0xFFD83A88),
    secondary: Color(0x29D83A88),
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
  }) => ThemeColors(
    white: white ?? this.white,
    black: black ?? this.black,
    success: success ?? this.success,
    error: error ?? this.error,
    transparent: transparent ?? this.transparent,
    primary: primary ?? this.primary,
    secondary: secondary ?? this.secondary,
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
        );
}
