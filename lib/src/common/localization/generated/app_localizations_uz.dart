// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get localeName => 'uz_UZ';

  @override
  String get localeCode => 'uz';

  @override
  String get localeScriptCode => '';

  @override
  String get languageCode => 'uz';

  @override
  String get language => 'O\'zbek';

  @override
  String get loginTitle => 'Kirish';

  @override
  String get forgotPassword => 'Parolni unutdingiz?';

  @override
  String get phoneNumber => 'Telefon raqam';

  @override
  String get enterPhoneNumber => 'Telefon raqamni kiriting';

  @override
  String get registerTitle => 'Ro\'yxatdan o\'tish';

  @override
  String get registerAgreement => 'Ro\'yxatdan o\'tish orqali siz foydalanuvchi kelishuvi qoidalariga rozilik bildirasiz';

  @override
  String get password => 'Parol';

  @override
  String get enterPassword => 'Parolni kiriting';

  @override
  String get confirmPassword => 'Parolni tasdiqlang';

  @override
  String get weSendOtpTo => 'Tasdiqlash kodi ushbu raqamga yuborildi';

  @override
  String get resendOtp => 'Qayta yuborish';

  @override
  String get passportSeriesOrPinfl => 'Passport seriyasi va raqami yoki PINFL';

  @override
  String get passportFieldHint => 'AA1234567 | PINFL';

  @override
  String minimumCharacters(int count) {
    return 'Kamida $count ta belgi';
  }

  @override
  String get birthDate => 'Tug\'ilgan sana';

  @override
  String get birthDateHint => 'KK.OO.YYYY';

  @override
  String get confirm => 'Tasdiqlash';

  @override
  String get setPasswordTitle => 'Parolni o\'rnatish';

  @override
  String get passwordsDoNotMatch => 'Parollar mos emas';

  @override
  String passwordTooShort(int count) {
    return 'Parol kamida $count ta belgidan iborat bo\'lishi kerak';
  }
}
