import 'package:flutter/material.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/util/dimension.dart';
import 'package:vakilium/src/feature/auth/otp/controller/otp_controller.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({required this.phoneNumber, super.key});

  final String phoneNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends OtpController {
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
                  context.l10n.registerTitle,
                  style: context.textTheme.interW600s24.copyWith(fontSize: 32),
                  textAlign: TextAlign.start,
                ),
                Dimension.hBox8,
                Text(
                  context.l10n.weSendOtpTo,
                  style: context.textTheme.interW400s14.copyWith(color: context.color.hintText),
                ),
                Dimension.hBox8,
                buildPhoneNumberChip(context),
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
                  Text(context.l10n.registerTitle, style: context.textTheme.interW600s24),
                  Dimension.hBox8,
                  Text(
                    context.l10n.weSendOtpTo,
                    style: context.textTheme.interW400s14.copyWith(color: context.color.hintText),
                  ),
                  Dimension.hBox8,
                  buildPhoneNumberChip(context),
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
}

class AppCircularIndicator extends StatelessWidget {
  const AppCircularIndicator({super.key, this.value});
  final double? value;

  @override
  Widget build(BuildContext context) => Center(
    child: CircularProgressIndicator.adaptive(
      strokeCap: StrokeCap.round,
      strokeWidth: 6,
      valueColor: AlwaysStoppedAnimation(context.color.primary),
      backgroundColor: context.color.primary,
      value: value,
    ),
  );
}
