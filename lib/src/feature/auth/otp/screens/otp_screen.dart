import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:vakilium/src/common/constant/gen/assets.gen.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/router/router.dart';
import 'package:vakilium/src/common/util/dimension.dart';
import 'package:vakilium/src/common/widgets/app_button.dart';
import 'package:vakilium/src/feature/auth/register/screens/register_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({required this.phoneNumber, super.key});

  final String phoneNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  static const _otpLength = 6;

  late final List<TextEditingController> _controllers = List<TextEditingController>.generate(
    _otpLength,
    (_) => TextEditingController(),
  );
  late final List<FocusNode> _focusNodes = List<FocusNode>.generate(_otpLength, (_) => FocusNode());

  Timer? _resendTimer;
  int _remainingSeconds = _initialCountdown.inSeconds;

  static const Duration _initialCountdown = Duration(seconds: 60);

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.color.white,
    child: LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: constraints.maxHeight,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.l10n.registerTitle, style: context.textTheme.interW600s24),
                        Dimension.hBox8,
                        Text(
                          context.l10n.weSendOtpTo,
                          style: context.textTheme.interW400s14.copyWith(color: context.color.hintText),
                        ),
                        Dimension.hBox8,
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: context.color.textFieldBackground,
                              borderRadius: Dimension.rAll8,
                            ),
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
                        ),
                        Dimension.hBox24,
                        _buildOtpFields(context),
                        Dimension.hBox16,
                        _buildResendSection(context),
                      ],
                    ),
                  ),
                ),
                AppButton(onPressed: _isOtpComplete ? _submit : null, title: 'Продолжить'),
                Dimension.hBox8,
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget _buildOtpFields(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List<Widget>.generate(
      _otpLength,
      (index) => _OtpInputCell(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        autoFocus: index == 0,
        onChanged: (value) => _handleOtpChange(value, index),
      ),
    ),
  );

  Widget _buildResendSection(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Не получили код?', style: context.textTheme.interW400s14.copyWith(color: context.color.hintText)),
      Dimension.wBox8,
      GestureDetector(
        onTap: _isResendAvailable ? _onResendPressed : null,
        child: Text(
          _isResendAvailable ? 'Отправить снова' : _formattedCountdown,
          style: context.textTheme.interW500s14.copyWith(
            color: _isResendAvailable ? context.color.primary : context.color.hintText,
          ),
        ),
      ),
    ],
  );

  bool get _isOtpComplete => _controllers.every((controller) => controller.text.trim().isNotEmpty);

  bool get _isResendAvailable => _remainingSeconds == 0;

  String get _formattedCountdown {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void _handleOtpChange(String value, int index) {
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    } else if (value.isNotEmpty && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (index == _otpLength - 1 && value.isNotEmpty) {
      FocusScope.of(context).unfocus();
    }
    setState(() {});
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    setState(() => _remainingSeconds = _initialCountdown.inSeconds);
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  void _onResendPressed() {
    if (!_isResendAvailable) {
      return;
    }
    _startResendTimer();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Код повторно отправлен')));
  }

  void _submit() {
    final code = _controllers.map((controller) => controller.text).join();
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Введён код: $code')));
  }
}

class _OtpInputCell extends StatelessWidget {
  const _OtpInputCell({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.autoFocus = false,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 48,
    child: TextField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autoFocus,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      style: context.textTheme.interW600s20,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(1)],
      onChanged: onChanged,
      onSubmitted: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: context.color.textFieldBackground,
        contentPadding: Dimension.pAll12,
        border: OutlineInputBorder(
          borderRadius: Dimension.rAll12,
          borderSide: BorderSide(color: context.color.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: Dimension.rAll12,
          borderSide: BorderSide(color: context.color.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: Dimension.rAll12,
          borderSide: BorderSide(color: context.color.primary),
        ),
      ),
    ),
  );
}
