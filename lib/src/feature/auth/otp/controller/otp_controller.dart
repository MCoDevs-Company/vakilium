import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:vakilium/src/common/constant/gen/assets.gen.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/router/router.dart';
import 'package:vakilium/src/common/util/dimension.dart';
import 'package:vakilium/src/common/util/logger.dart';
import 'package:vakilium/src/feature/auth/otp/screens/otp_screen.dart';

abstract class OtpController extends State<OtpScreen> {
  static const otpLength = 6;
  static const Duration _initialCountdown = Duration(seconds: 60);

  late final TextEditingController otpController;
  late final ValueNotifier<int> _remainingSeconds;

  Timer? _resendTimer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = ValueNotifier<int>(_initialCountdown.inSeconds);
    otpController = TextEditingController();
    startResendTimer();
  }

  Widget buildPhoneNumberChip(BuildContext context) => GestureDetector(
    onTap: () => context.pop(),
    child: Container(
      decoration: BoxDecoration(color: context.color.textFieldBackground, borderRadius: Dimension.rAll8),
      padding: const EdgeInsets.only(left: 8, right: 4, top: 4, bottom: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.phoneNumber, style: context.textTheme.interW400s16),
          Dimension.wBox8,
          Assets.icons.edit.svg(height: 20, width: 20),
        ],
      ),
    ),
  );

  Widget buildOtpInput(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 48,
      height: 54,
      textStyle: context.textTheme.interW600s20,
      decoration: BoxDecoration(
        color: context.color.textFieldBackground,
        borderRadius: Dimension.rAll12,
        border: Border.all(color: context.color.transparent),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(border: Border.all(color: context.color.primary)),
    );

    return Form(
      child: Pinput(
        length: otpLength,
        controller: otpController,
        autofocus: true,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        submittedPinTheme: defaultPinTheme,
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration?.copyWith(border: Border.all(color: Colors.red)),
        ),
        showCursor: true,
        keyboardType: TextInputType.number,
        onCompleted: (_) => submit(),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        // TODO: Fetch otp status from server
        forceErrorState: false,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  Widget buildResendSection(BuildContext context) => ValueListenableBuilder(
    valueListenable: _remainingSeconds,
    builder: (context, seconds, child) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _isResendAvailable ? onResendPressed : null,
          child: Text(
            context.l10n.resendOtp,
            style: context.textTheme.interW400s16.copyWith(
              color: _isResendAvailable ? context.color.primary : context.color.hintText,
            ),
          ),
        ),
        Dimension.wBox14,
        Text(
          _formattedCountdown(seconds),
          style: context.textTheme.interW400s14.copyWith(
            color: _isResendAvailable ? context.color.hintText : context.color.gray900,
          ),
        ),
      ],
    ),
  );

  bool get _isResendAvailable => _remainingSeconds.value == 0;

  String _formattedCountdown(int value) {
    final minutes = value ~/ 60;
    final seconds = value % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void startResendTimer() {
    _resendTimer?.cancel();
    _remainingSeconds.value = _initialCountdown.inSeconds;
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final seconds = _remainingSeconds.value;
      info('remainingSeconds: ${seconds}');
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (seconds == 0) {
        timer.cancel();
      } else {
        _remainingSeconds.value = seconds - 1;
      }
    });
  }

  void onResendPressed() {
    if (!_isResendAvailable) return;
    startResendTimer();
    if (!mounted) return;
    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Код повторно отправлен')));
  }

  Future<void> submit() async {
    if (!mounted) return;
    final code = otpController.text;
    info('code: $code');
    await Future.delayed(const Duration(seconds: 2), () {
      context.goNamed(Routes.userInfo);
    });
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Введён код: $code')));
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    _remainingSeconds.dispose();
    otpController.dispose();
    super.dispose();
  }
}
