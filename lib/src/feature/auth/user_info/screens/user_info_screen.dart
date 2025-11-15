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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.l10n.registerTitle,
                  style: context.textTheme.interW600s24.copyWith(fontSize: 32),
                  textAlign: TextAlign.start,
                ),
                Dimension.hBox32,
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                        autofocus: true,
                        label: context.l10n.passportSeriesOrPinfl,
                        hintText: context.l10n.passportFieldHint,
                        controller: documentController,
                        textInputAction: TextInputAction.next,
                        inputFormatter: passportFormatter,
                        textCapitalization: TextCapitalization.characters,
                      ),
                      Dimension.hBox8,
                      Text(
                        context.l10n.minimumCharacters(UserInfoController.minDocumentLength),
                        style: context.textTheme.interW400s14.copyWith(color: context.color.hintText),
                      ),
                      Dimension.hBox16,
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

  Widget _buildMobile() => ColoredBox(
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
                                autofocus: true,
                                label: context.l10n.passportSeriesOrPinfl,
                                hintText: context.l10n.passportFieldHint,
                                controller: documentController,
                                textInputAction: TextInputAction.next,
                                inputFormatter: passportFormatter,
                                textCapitalization: TextCapitalization.characters,
                              ),
                              Dimension.hBox8,
                              Text(
                                context.l10n.minimumCharacters(UserInfoController.minDocumentLength),
                                style: context.textTheme.interW400s14.copyWith(color: context.color.hintText),
                              ),
                              Dimension.hBox16,
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
