import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/router/router.dart';
import 'package:vakilium/src/common/util/dimension.dart';
import 'package:vakilium/src/common/util/logger.dart';
import 'package:vakilium/src/common/widgets/app_circular_indicator.dart';
import 'package:vakilium/src/feature/auth/otp/controller/otp_controller.dart';

class RecoverOtpScreen extends StatefulWidget {
  const RecoverOtpScreen({required this.phoneNumber, super.key});
  final String phoneNumber;

  @override
  State<RecoverOtpScreen> createState() => _RecoverOtpScreenState();
}

class _RecoverOtpScreenState extends OtpController<RecoverOtpScreen> {
  @override
  Widget build(BuildContext context) => context.responsive(mobile: _buildMobile(), desktop: _buildDesktop());

  Widget _buildDesktop() => ColoredBox(
    color: context.color.white,
    child: Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: Dimension.pH40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.recoverPassword,
                  style: context.textTheme.interW600s24.copyWith(fontSize: 32),
                  textAlign: TextAlign.start,
                ),
                Dimension.hBox32,
                Text(
                  context.l10n.weSendOtpTo,
                  style: context.textTheme.interW400s14.copyWith(color: context.color.hintText),
                ),
                Dimension.hBox8,
                buildPhoneNumberChip(context, widget.phoneNumber),
                Dimension.hBox24,
                buildOtpInput(context),
                Dimension.hBox32,
                buildResendSection(context),
                Dimension.hBox22,
                ValueListenableBuilder(
                  valueListenable: otpController,
                  builder: (context, value, child) {
                    final isLoading = value.text.length == OtpController.otpLength;
                    return Visibility(visible: isLoading, child: const AppCircularIndicator());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget _buildMobile() => ColoredBox(
    color: context.color.white,
    child: LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: constraints.maxHeight,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.l10n.recoverPassword, style: context.textTheme.interW600s24),
                  Dimension.hBox8,
                  Text(
                    context.l10n.weSendOtpTo,
                    style: context.textTheme.interW400s14.copyWith(color: context.color.hintText),
                  ),
                  Dimension.hBox8,
                  buildPhoneNumberChip(context, widget.phoneNumber),
                  Dimension.hBox24,
                  buildOtpInput(context),
                  Dimension.hBox32,
                  buildResendSection(context),
                  Dimension.hBox22,
                  ValueListenableBuilder(
                    valueListenable: otpController,
                    builder: (context, value, child) {
                      final isLoading = value.text.length == OtpController.otpLength;
                      return Visibility(visible: isLoading, child: const AppCircularIndicator());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  @override
  Future<void> submit() async {
    if (!mounted) return;
    final code = otpController.text;
    info('code: $code');
    await Future.delayed(const Duration(seconds: 2), () {
      context.goNamed(Routes.newPassword);
    });
  }
}
