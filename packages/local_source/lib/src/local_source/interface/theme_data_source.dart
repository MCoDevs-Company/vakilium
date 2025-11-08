import 'package:flutter/material.dart' show ThemeMode;

abstract interface class ThemeDataSource {
  /// Setter for [ThemeMode]
  Future<void> setTheme(ThemeMode mode);

  /// Getter for [ThemeMode] from cache
  ThemeMode get theme;
}
