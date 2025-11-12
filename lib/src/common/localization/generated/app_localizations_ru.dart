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
  String get loginTitle => 'Войти';

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

  @override
  String get password => 'Пароль';

  @override
  String get enterPassword => 'Введите пароль';

  @override
  String get confirmPassword => 'Подтвердите пароль';

  @override
  String get weSendOtpTo => 'Мы отпавили код подтверждения на номер';

  @override
  String get resendOtp => 'Отправить занова';

  @override
  String get passportSeriesOrPinfl => 'Серия и номер паспорта или ПИНФЛ';

  @override
  String get passportFieldHint => 'AA1234567 | ПИНФЛ';

  @override
  String minimumCharacters(int count) {
    return 'Минимум $count символов';
  }

  @override
  String get birthDate => 'Дата рождения';

  @override
  String get birthDateHint => 'ДД.ММ.ГГГГ';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get setPasswordTitle => 'Установка пароля';

  @override
  String get passwordsDoNotMatch => 'Пароли не совпадают';

  @override
  String passwordTooShort(int count) {
    return 'Пароль должен содержать минимум $count символов';
  }
}
