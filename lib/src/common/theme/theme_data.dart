// ignore_for_file: always_use_package_imports

import 'package:flutter/material.dart';

import 'theme_colors.dart';
import 'theme_text_style.dart';

/// {@template theme}
/// App theme data.
/// {@endtemplate}
extension type AppThemeData._(ThemeData data) implements ThemeData {
  /// {@macro theme}
  factory AppThemeData.light(String fontFamily) => AppThemeData._(_appLightTheme(fontFamily));

  /// {@macro theme}
  factory AppThemeData.dark(String fontFamily) => AppThemeData._(_appDarkTheme(fontFamily));
}

/// Extension on [ThemeData] to provide App theme data.
extension AutoThemeExtension on ThemeData {
  /// Returns the App theme colors.
  ThemeColors get appColors =>
      extension<ThemeColors>() ??
      switch (brightness) {
        Brightness.light => ThemeColors.light,
        Brightness.dark => ThemeColors.dark,
      };

  ThemeTextStyles get appTextStyles =>
      extension<ThemeTextStyles>() ??
      switch (brightness) {
        Brightness.light => ThemeTextStyles.light,
        Brightness.dark => ThemeTextStyles.dark,
      };
}

// --- Light Theme --- //

/// Light theme data for the App.
ThemeData _appLightTheme(String fontFamily) => ThemeData(
  fontFamily: fontFamily,
  brightness: Brightness.light,
  useMaterial3: true,
).copyWith(extensions: const <ThemeExtension<Object?>>{ThemeColors.light, ThemeTextStyles.light});

// --- Dark Theme --- //

/// Dark theme data for the App.
ThemeData _appDarkTheme(String fontFamily) => ThemeData(
  fontFamily: fontFamily,
  brightness: Brightness.dark,
  useMaterial3: true,
).copyWith(extensions: const <ThemeExtension<Object?>>{ThemeColors.dark, ThemeTextStyles.dark});
