import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/router/router.dart';
import 'package:vakilium/src/common/util/dimension.dart';
import 'package:vakilium/src/common/util/formatters/pasport_pormatter.dart';
import 'package:vakilium/src/common/util/logger.dart';
import 'package:vakilium/src/common/widgets/app_button.dart';
import 'package:vakilium/src/feature/auth/user_info/screens/user_info_screen.dart';

abstract class UserInfoController extends State<UserInfoScreen> {
  static const int minDocumentLength = 9;
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
    passportFormatter = PassportFormatter();
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
    // Accept either 9 characters (AA#######) or 14 characters (##############)
    final isDocumentValid = document.length == 9 || document.length == 14;
    final isValid = isDocumentValid && birthDate.length == 8;
    if (isSubmitEnabled.value != isValid) {
      isSubmitEnabled.value = isValid;
    }
  }

  /// iOS uslubidagi date picker (bottom sheet) — tanlangan sanani Future orqali qaytaradi.
  Future<DateTime?> showIOSDatePicker(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? minDate,
    DateTime? maxDate,
  }) async {
    final DateTime now = DateTime.now();
    DateTime tempDate = initialDate ?? now;

    return await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (ctx) => Container(
        color: CupertinoColors.systemBackground.resolveFrom(ctx),
        height: 400,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date, // date | time | dateAndTime
                  initialDateTime: tempDate,
                  minimumDate: minDate,
                  maximumDate: maxDate,
                  use24hFormat: true,
                  changeReportingBehavior: ChangeReportingBehavior.onScrollEnd,
                  onDateTimeChanged: (DateTime d) {
                    tempDate = d;
                  },
                ),
              ),
              Dimension.hBox8,
              Padding(
                padding: Dimension.pAll16,
                child: AppButton(onPressed: () => context.pop(tempDate), title: context.l10n.confirm),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onBirthDateTap() async {
    FocusScope.of(context).unfocus();

    final now = DateTime.now();
    final initialDate = _parseBirthDate() ?? DateTime(now.year - 18, now.month, now.day);

    final pickedDate = await showIOSDatePicker(
      context,
      initialDate: initialDate,
      minDate: _defaultFirstDate,
      maxDate: DateTime(now.year + 100),
    );

    if (pickedDate != null) {
      birthDateController.text = _birthDateFormat.format(pickedDate);
    }
  }

  void onSubmit() {
    if (!isSubmitEnabled.value) return;
    FocusScope.of(context).unfocus();
    final document = documentController.text.trim();
    final birthDate = birthDateController.text.trim();
    info('Submitting user info -> document: $document, birthDate: $birthDate');
    context.pushNamed(Routes.newPassword);
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
