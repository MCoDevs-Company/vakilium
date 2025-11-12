import 'package:flutter/material.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/util/dimension.dart';
import 'package:vakilium/src/common/widgets/app_button.dart';
import 'package:vakilium/src/common/widgets/app_text_field.dart';
import 'package:vakilium/src/feature/auth/user_info/controller/user_info_controller.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends UserInfoController {
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
                    padding: Dimension.pZero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.l10n.registerTitle, style: context.textTheme.interW600s24),
                        Dimension.hBox24,
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextField(
                                label: context.l10n.passportSeriesOrPinfl,
                                hintText: context.l10n.passportFieldHint,
                                controller: documentController,
                                textInputAction: TextInputAction.next,
                                inputFormatter: passportFormatter,
                                textCapitalization: TextCapitalization.characters,
                                suffixIcon: _ScanSuffix(onPressed: onScanPressed),
                              ),
                              Dimension.hBox8,
                              Text(
                                context.l10n.minimumCharacters(UserInfoController.minDocumentLength),
                                style: context.textTheme.interW400s14.copyWith(color: context.color.hintText),
                              ),
                              Dimension.hBox24,
                              AppTextField(
                                label: context.l10n.birthDate,
                                hintText: context.l10n.birthDateHint,
                                controller: birthDateController,
                                keyboardType: TextInputType.datetime,
                                textInputAction: TextInputAction.done,
                                inputFormatter: birthDateMask,
                                readOnly: true,
                                onTap: onBirthDateTap,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Dimension.hBox32,
                ValueListenableBuilder<bool>(
                  valueListenable: isSubmitEnabled,
                  builder: (context, isEnabled, child) =>
                      AppButton(onPressed: isEnabled ? onSubmit : null, title: context.l10n.confirm),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _ScanSuffix extends StatelessWidget {
  const _ScanSuffix({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Padding(
    padding: Dimension.pRight4,
    child: InkWell(
      onTap: onPressed,
      borderRadius: Dimension.rAll8,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: Dimension.pAll8,
        decoration: BoxDecoration(
          color: context.color.white,
          borderRadius: Dimension.rAll8,
          border: Border.all(color: context.color.textFieldBackground),
        ),
        child: Icon(Icons.qr_code_scanner_outlined, color: context.color.gray900, size: 20),
      ),
    ),
  );
}
