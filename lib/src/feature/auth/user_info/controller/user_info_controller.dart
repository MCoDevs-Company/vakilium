import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:vakilium/src/common/util/logger.dart';
import 'package:vakilium/src/feature/auth/user_info/screens/user_info_screen.dart';

abstract class UserInfoController extends State<UserInfoScreen> {
  static const int minDocumentLength = 8;
  static final DateFormat _birthDateFormat = DateFormat('dd.MM.yyyy');
  static final DateTime _defaultFirstDate = DateTime(1900);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final TextEditingController documentController;
  late final TextEditingController birthDateController;
  late final MaskTextInputFormatter birthDateMask;
  late final TextInputFormatter passportFormatter;
  late final ValueNotifier<bool> isSubmitEnabled;

  @override
  void initState() {
    super.initState();
    documentController = TextEditingController();
    birthDateController = TextEditingController();
    birthDateMask = MaskTextInputFormatter(mask: '##.##.####');
    passportFormatter = FilteringTextInputFormatter.allow(RegExp('[0-9A-Za-z]'));
    isSubmitEnabled = ValueNotifier<bool>(false);

    documentController.addListener(_onDocumentChanged);
    birthDateController.addListener(_onFormChanged);
  }

  void _onDocumentChanged() {
    final current = documentController.text;
    final uppercased = current.toUpperCase();
    if (current != uppercased) {
      final selection = documentController.selection;
      documentController.value = documentController.value.copyWith(
        text: uppercased,
        selection: selection,
        composing: TextRange.empty,
      );
    }
    _onFormChanged();
  }

  void _onFormChanged() {
    final document = documentController.text.trim();
    final birthDate = birthDateMask.unmaskText(birthDateController.text);
    final isValid = document.length >= minDocumentLength && birthDate.length == 8;
    if (isSubmitEnabled.value != isValid) {
      isSubmitEnabled.value = isValid;
    }
  }

  Future<void> onBirthDateTap() async {
    FocusScope.of(context).unfocus();

    final now = DateTime.now();
    final initialDate = _parseBirthDate() ?? DateTime(now.year - 18, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: _defaultFirstDate,
      lastDate: now,
      locale: Localizations.localeOf(context),
    );

    if (pickedDate != null) {
      birthDateController.text = _birthDateFormat.format(pickedDate);
    }
  }

  void onScanPressed() {
    FocusScope.of(context).unfocus();
    info('Scan passport/PINFL tapped');
  }

  void onSubmit() {
    if (!isSubmitEnabled.value) return;
    FocusScope.of(context).unfocus();
    final document = documentController.text.trim();
    final birthDate = birthDateController.text.trim();
    info('Submitting user info -> document: $document, birthDate: $birthDate');
  }

  DateTime? _parseBirthDate() {
    try {
      final raw = birthDateController.text;
      if (raw.isEmpty) return null;
      return _birthDateFormat.parseStrict(raw);
    } catch (_) {
      return null;
    }
  }

  @override
  void dispose() {
    documentController.removeListener(_onDocumentChanged);
    birthDateController.removeListener(_onFormChanged);
    documentController.dispose();
    birthDateController.dispose();
    isSubmitEnabled.dispose();
    super.dispose();
  }
}
