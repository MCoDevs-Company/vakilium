// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get localeName => 'ru_RU';

  @override
  String get localeCode => 'ru';

  @override
  String get localeScriptCode => '';

  @override
  String get languageCode => 'ru';

  @override
  String get language => 'Русский';

  @override
  String get loginTitle => 'Войти в систему';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get phoneNumber => 'Номер телефона';

  @override
  String get enterPhoneNumber => 'Введите номер телефона';

  @override
  String get registerTitle => 'Регистрация';

  @override
  String get registerAgreement => 'Регистрируясь, вы соглашаетесь с правилами пользовательского соглашения';
}
