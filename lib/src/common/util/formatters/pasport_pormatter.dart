import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PassportFormatter extends TextInputFormatter {
  final MaskTextInputFormatter _maskAA = MaskTextInputFormatter(mask: 'AA#######');
  final MaskTextInputFormatter _maskDigits = MaskTextInputFormatter(mask: '##############');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Normalize text to uppercase and remove non-alphanumeric
    final text = newValue.text.toUpperCase().replaceAll(RegExp('[^A-Z0-9]'), '');

    if (text.isEmpty) return newValue;

    // Determine which mask to use based on first character
    final firstChar = text[0];
    final startsWithLetter = firstChar.contains(RegExp('[A-Z]'));
    final isAllDigits = text.contains(RegExp(r'^[0-9]+$'));

    // Pattern 1: AA####### (2 letters + 7 digits = 9 characters total)
    if (startsWithLetter) {
      // Extract letters (max 2) and digits (max 7)
      final letters = text.replaceAll(RegExp('[^A-Z]'), '');
      final digits = text.replaceAll(RegExp('[^0-9]'), '');

      // Build the text: exactly 2 letters followed by up to 7 digits
      final letterPart = letters.length > 2 ? letters.substring(0, 2) : letters;
      final digitPart = digits.length > 7 ? digits.substring(0, 7) : digits;

      // Combine: letters first, then digits (but don't exceed total of 9 chars)
      String processed = '';
      if (letterPart.length == 2) {
        // Have 2 letters, append digits
        processed = letterPart + digitPart;
        if (processed.length > 9) {
          processed = processed.substring(0, 9);
        }
      } else {
        // Still typing letters (allow up to 2 letters)
        processed = text.length > 2 ? text.substring(0, 2) : text;
      }

      // Use the unmasked old value if switching masks
      final oldUnmasked = oldValue.text.toUpperCase().replaceAll(RegExp('[^A-Z0-9]'), '');
      final oldStartsWithLetter = oldUnmasked.isNotEmpty && oldUnmasked[0].contains(RegExp('[A-Z]'));

      // If switching from digits mask, create new oldValue
      final oldValForFormatter = oldStartsWithLetter ? oldValue : TextEditingValue.empty;

      return _maskAA.formatEditUpdate(
        oldValForFormatter,
        TextEditingValue(text: processed, selection: newValue.selection),
      );
    }

    // Pattern 2: ############## (14 digits only)
    if (isAllDigits) {
      // Get old unmasked text to check if we're switching from AA pattern
      final oldUnmasked = oldValue.text.toUpperCase().replaceAll(RegExp('[^A-Z0-9]'), '');
      final oldStartsWithLetter = oldUnmasked.isNotEmpty && oldUnmasked[0].contains(RegExp('[A-Z]'));

      // Check if user deleted letters (new text is shorter and doesn't have letters)
      final textGotShorter = text.length < oldUnmasked.length;
      final hadLettersBefore = oldUnmasked.replaceAll(RegExp('[^A-Z]'), '').isNotEmpty;
      final hasNoLettersNow = text.replaceAll(RegExp('[^A-Z]'), '').isEmpty;

      // Allow switching to digits if:
      // 1. Old value was empty (starting fresh)
      // 2. User deleted letters (text got shorter and no letters remain)
      // 3. Old value already started with digits
      final canSwitchToDigits =
          oldUnmasked.isEmpty || (textGotShorter && hadLettersBefore && hasNoLettersNow) || !oldStartsWithLetter;

      if (!canSwitchToDigits && oldStartsWithLetter) {
        // User is trying to type digits after letters without deleting - reject
        return oldValue;
      }

      // Limit to 14 digits
      final limited = text.length > 14 ? text.substring(0, 14) : text;

      // If switching from AA mask, create new oldValue to reset formatter state
      final oldValForFormatter = (oldStartsWithLetter && canSwitchToDigits) ? TextEditingValue.empty : oldValue;

      return _maskDigits.formatEditUpdate(
        oldValForFormatter,
        TextEditingValue(text: limited, selection: newValue.selection),
      );
    }

    // Invalid input - reject changes
    return oldValue;
  }
}
