import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show ThemeMode, Locale, WidgetsBinding;
import 'package:shared_preferences/shared_preferences.dart';

import 'interface/localization_data_source.dart';
import 'interface/theme_data_source.dart';
import 'interface/user_data_source.dart';
import 'preference_dao/preference_entry.dart';
import 'utils/secure_store.dart';

final class LocalSource extends PreferenceDao implements UserDataSource, LocalizationDataSource, ThemeDataSource {
  LocalSource._({required super.sharedPreferences});

  static Future<LocalSource> get instance async {
    final shp = await SharedPreferences.getInstance();
    return LocalSource._(sharedPreferences: shp);
  }

  /// Entries
  PreferenceEntry<String> get _accessTokenKey => stringEntry(key: 'user.access_token');
  PreferenceEntry<String> get _refreshTokenKey => stringEntry(key: 'user.refresh_key');
  PreferenceEntry<String> get _localizationKey => stringEntry(key: 'settings.localization');
  PreferenceEntry<String> get _themeKey => stringEntry(key: 'settings.theme');

  /// *** GETTERS ***
  /// Encrypted values using [SecureStore]
  @override
  String get accessToken => SecureStore.readUsingDecryption(_accessTokenKey);

  @override
  String get refreshToken => SecureStore.readUsingDecryption(_refreshTokenKey);

  /// *** SETTERS ***
  /// Encrypted values using [SecureStore]
  @override
  Future<void> setAccessToken(String accessToken) async =>
      await SecureStore.setUsingEncryption(accessToken, entry: _accessTokenKey);

  @override
  Future<void> setRefreshToken(String refreshToken) async =>
      await SecureStore.setUsingEncryption(refreshToken, entry: _refreshTokenKey);

  /// [ThemeDataSource]
  @override
  ThemeMode get theme => switch (_themeKey.read()) {
    'system' => ThemeMode.system,
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.light,
  };

  /// [LocalizationDataSource]
  @override
  Locale get localization {
    final locale = _localizationKey.read();
    if (locale == null) return Locale.fromSubtags(languageCode: _defaultLocale);
    final languageSplits = locale.split('-');
    final languageCode = languageSplits.first;
    final scriptCode = languageSplits.length > 1 ? languageSplits.last : null;
    return Locale.fromSubtags(languageCode: languageCode, scriptCode: scriptCode);
  }

  @override
  Future<void> setLocalization(Locale locale) async {
    var localeString = locale.languageCode;
    if (locale.scriptCode != null) localeString += '-${locale.scriptCode}';
    await _localizationKey.set(localeString);
  }

  @override
  Future<void> setTheme(ThemeMode mode) async => await _themeKey.set(mode.name);

  /// *** CLEANERS ***
  Future<void> clearAllUserData() async => await clearAll();

  /// *** HELPERS ***
  @override
  bool get isUserAuthenticated => accessToken.isNotEmpty && refreshToken.isNotEmpty;
}

/// Default locale
String get _defaultLocale {
  if (kIsWeb) {
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    return locale.toLanguageTag();
  }
  return switch (Platform.localeName.split('-').first) {
    'ru' => 'ru',
    _ => 'ru',
  };
}
