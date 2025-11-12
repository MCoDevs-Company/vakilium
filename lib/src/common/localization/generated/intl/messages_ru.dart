// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(count) => "Минимум ${count} символов";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "birthDate": MessageLookupByLibrary.simpleMessage("Дата рождения"),
    "birthDateHint": MessageLookupByLibrary.simpleMessage("ДД.ММ.ГГГГ"),
    "confirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
    "enterPassword": MessageLookupByLibrary.simpleMessage("Введите пароль"),
    "enterPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Введите номер телефона",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Забыли пароль?"),
    "language": MessageLookupByLibrary.simpleMessage("Русский"),
    "languageCode": MessageLookupByLibrary.simpleMessage("ru"),
    "localeCode": MessageLookupByLibrary.simpleMessage("ru"),
    "localeName": MessageLookupByLibrary.simpleMessage("ru_RU"),
    "localeScriptCode": MessageLookupByLibrary.simpleMessage(""),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Войти"),
    "minimumCharacters": m0,
    "passportFieldHint": MessageLookupByLibrary.simpleMessage(
      "AA1234567 | ПИНФЛ",
    ),
    "passportSeriesOrPinfl": MessageLookupByLibrary.simpleMessage(
      "Серия и номер паспорта или ПИНФЛ",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Пароль"),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("Номер телефона"),
    "registerAgreement": MessageLookupByLibrary.simpleMessage(
      "Регистрируясь, вы соглашаетесь с правилами пользовательского соглашения",
    ),
    "registerTitle": MessageLookupByLibrary.simpleMessage("Регистрация"),
    "resendOtp": MessageLookupByLibrary.simpleMessage("Отправить занова"),
    "weSendOtpTo": MessageLookupByLibrary.simpleMessage(
      "Мы отпавили код подтверждения на номер",
    ),
  };
}
