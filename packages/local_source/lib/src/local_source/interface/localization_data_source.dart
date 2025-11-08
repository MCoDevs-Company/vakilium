import 'dart:ui' show Locale;

abstract interface class LocalizationDataSource {
  /// Setter for [Locale]
  Future<void> setLocalization(Locale locale);

  /// Getter for [Locale] from cache
  Locale get localization;
}
