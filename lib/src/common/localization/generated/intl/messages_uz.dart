// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a uz locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'uz';

  static String m0(count) => "Kamida ${count} ta belgi";

  static String m1(count) => "Parol kamida ${count} ta belgidan iborat bo\'lishi kerak";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "birthDate": MessageLookupByLibrary.simpleMessage("Tug\'ilgan sana"),
    "birthDateHint": MessageLookupByLibrary.simpleMessage("KK.OO.YYYY"),
    "confirm": MessageLookupByLibrary.simpleMessage("Tasdiqlash"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Parolni tasdiqlang"),
    "enterPassword": MessageLookupByLibrary.simpleMessage("Parolni kiriting"),
    "enterPhoneNumber": MessageLookupByLibrary.simpleMessage("Telefon raqamni kiriting"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Parolni unutdingiz?"),
    "language": MessageLookupByLibrary.simpleMessage("O\'zbek"),
    "languageCode": MessageLookupByLibrary.simpleMessage("uz"),
    "localeCode": MessageLookupByLibrary.simpleMessage("uz"),
    "localeName": MessageLookupByLibrary.simpleMessage("uz_UZ"),
    "localeScriptCode": MessageLookupByLibrary.simpleMessage(""),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Kirish"),
    "minimumCharacters": m0,
    "passportFieldHint": MessageLookupByLibrary.simpleMessage("AA1234567 | PINFL"),
    "passportSeriesOrPinfl": MessageLookupByLibrary.simpleMessage("Passport seriyasi va raqami yoki PINFL"),
    "password": MessageLookupByLibrary.simpleMessage("Parol"),
    "passwordTooShort": m1,
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage("Parollar mos emas"),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("Telefon raqam"),
    "registerAgreement": MessageLookupByLibrary.simpleMessage(
      "Ro\'yxatdan o\'tish orqali siz foydalanuvchi kelishuvi qoidalariga rozilik bildirasiz",
    ),
    "registerTitle": MessageLookupByLibrary.simpleMessage("Ro\'yxatdan o\'tish"),
    "resendOtp": MessageLookupByLibrary.simpleMessage("Qayta yuborish"),
    "setPasswordTitle": MessageLookupByLibrary.simpleMessage("Parolni o\'rnatish"),
    "weSendOtpTo": MessageLookupByLibrary.simpleMessage("Tasdiqlash kodi ushbu raqamga yuborildi"),
  };
}
