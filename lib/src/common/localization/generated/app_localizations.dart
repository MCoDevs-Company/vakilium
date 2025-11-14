import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ru.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ru'), Locale('uz')];

  /// No description provided for @localeName.
  ///
  /// In ru, this message translates to:
  /// **'ru_RU'**
  String get localeName;

  /// No description provided for @localeCode.
  ///
  /// In ru, this message translates to:
  /// **'ru'**
  String get localeCode;

  /// No description provided for @localeScriptCode.
  ///
  /// In ru, this message translates to:
  /// **''**
  String get localeScriptCode;

  /// No description provided for @languageCode.
  ///
  /// In ru, this message translates to:
  /// **'ru'**
  String get languageCode;

  /// No description provided for @language.
  ///
  /// In ru, this message translates to:
  /// **'Русский'**
  String get language;

  /// No description provided for @loginTitle.
  ///
  /// In ru, this message translates to:
  /// **'Войти'**
  String get loginTitle;

  /// No description provided for @forgotPassword.
  ///
  /// In ru, this message translates to:
  /// **'Забыли пароль?'**
  String get forgotPassword;

  /// No description provided for @phoneNumber.
  ///
  /// In ru, this message translates to:
  /// **'Номер телефона'**
  String get phoneNumber;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In ru, this message translates to:
  /// **'Введите номер телефона'**
  String get enterPhoneNumber;

  /// No description provided for @registerTitle.
  ///
  /// In ru, this message translates to:
  /// **'Регистрация'**
  String get registerTitle;

  /// No description provided for @registerAgreement.
  ///
  /// In ru, this message translates to:
  /// **'Регистрируясь, вы соглашаетесь с правилами пользовательского соглашения'**
  String get registerAgreement;

  /// No description provided for @password.
  ///
  /// In ru, this message translates to:
  /// **'Пароль'**
  String get password;

  /// No description provided for @enterPassword.
  ///
  /// In ru, this message translates to:
  /// **'Введите пароль'**
  String get enterPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In ru, this message translates to:
  /// **'Подтвердите пароль'**
  String get confirmPassword;

  /// No description provided for @weSendOtpTo.
  ///
  /// In ru, this message translates to:
  /// **'Мы отпавили код подтверждения на номер'**
  String get weSendOtpTo;

  /// No description provided for @resendOtp.
  ///
  /// In ru, this message translates to:
  /// **'Отправить занова'**
  String get resendOtp;

  /// No description provided for @passportSeriesOrPinfl.
  ///
  /// In ru, this message translates to:
  /// **'Серия и номер паспорта или ПИНФЛ'**
  String get passportSeriesOrPinfl;

  /// No description provided for @passportFieldHint.
  ///
  /// In ru, this message translates to:
  /// **'AA1234567 | ПИНФЛ'**
  String get passportFieldHint;

  /// No description provided for @minimumCharacters.
  ///
  /// In ru, this message translates to:
  /// **'Минимум {count} символов'**
  String minimumCharacters(int count);

  /// No description provided for @birthDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата рождения'**
  String get birthDate;

  /// No description provided for @birthDateHint.
  ///
  /// In ru, this message translates to:
  /// **'ДД.ММ.ГГГГ'**
  String get birthDateHint;

  /// No description provided for @confirm.
  ///
  /// In ru, this message translates to:
  /// **'Подтвердить'**
  String get confirm;

  /// No description provided for @setPasswordTitle.
  ///
  /// In ru, this message translates to:
  /// **'Установка пароля'**
  String get setPasswordTitle;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In ru, this message translates to:
  /// **'Пароли не совпадают'**
  String get passwordsDoNotMatch;

  /// No description provided for @passwordTooShort.
  ///
  /// In ru, this message translates to:
  /// **'Пароль должен содержать минимум {count} символов'**
  String passwordTooShort(int count);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ru', 'uz'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ru':
      return AppLocalizationsRu();
    case 'uz':
      return AppLocalizationsUz();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
