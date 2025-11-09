// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class GeneratedLocalization {
  GeneratedLocalization();

  static GeneratedLocalization? _current;

  static GeneratedLocalization get current {
    assert(
      _current != null,
      'No instance of GeneratedLocalization was loaded. Try to initialize the GeneratedLocalization delegate before accessing GeneratedLocalization.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<GeneratedLocalization> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = GeneratedLocalization();
      GeneratedLocalization._current = instance;

      return instance;
    });
  }

  static GeneratedLocalization of(BuildContext context) {
    final instance = GeneratedLocalization.maybeOf(context);
    assert(
      instance != null,
      'No instance of GeneratedLocalization present in the widget tree. Did you add GeneratedLocalization.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static GeneratedLocalization? maybeOf(BuildContext context) {
    return Localizations.of<GeneratedLocalization>(
      context,
      GeneratedLocalization,
    );
  }

  /// `ru_RU`
  String get localeName {
    return Intl.message('ru_RU', name: 'localeName', desc: '', args: []);
  }

  /// `ru`
  String get localeCode {
    return Intl.message('ru', name: 'localeCode', desc: '', args: []);
  }

  /// ``
  String get localeScriptCode {
    return Intl.message('', name: 'localeScriptCode', desc: '', args: []);
  }

  /// `ru`
  String get languageCode {
    return Intl.message('ru', name: 'languageCode', desc: '', args: []);
  }

  /// `Русский`
  String get language {
    return Intl.message('Русский', name: 'language', desc: '', args: []);
  }

  /// `Войти в систему`
  String get loginTitle {
    return Intl.message(
      'Войти в систему',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Забыли пароль?`
  String get forgotPassword {
    return Intl.message(
      'Забыли пароль?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Номер телефона`
  String get phoneNumber {
    return Intl.message(
      'Номер телефона',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Введите номер телефона`
  String get enterPhoneNumber {
    return Intl.message(
      'Введите номер телефона',
      name: 'enterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Регистрация`
  String get registerTitle {
    return Intl.message(
      'Регистрация',
      name: 'registerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Регистрируясь, вы соглашаетесь с правилами пользовательского соглашения`
  String get registerAgreement {
    return Intl.message(
      'Регистрируясь, вы соглашаетесь с правилами пользовательского соглашения',
      name: 'registerAgreement',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate
    extends LocalizationsDelegate<GeneratedLocalization> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'uz'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<GeneratedLocalization> load(Locale locale) =>
      GeneratedLocalization.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
