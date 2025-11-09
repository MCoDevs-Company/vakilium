import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakilium/src/common/app/bloc/app_bloc.dart';
import 'package:vakilium/src/common/constant/gen/assets.gen.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/localization/localization.dart';
import 'package:vakilium/src/common/util/dimension.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  static Map<String, _LanguageMetadata> _languageMetadata = <String, _LanguageMetadata>{
    'ru': _LanguageMetadata(label: "Русский", flag: Assets.images.flagRu),
    'uz': _LanguageMetadata(label: "O'zbek", flag: Assets.images.flagUz),
  };

  static final List<_LanguageOption> _options = List.unmodifiable(
    Localization.supportedLocales.map(_buildOptionFromLocale),
  );

  static _LanguageOption _buildOptionFromLocale(Locale locale) {
    final metadata = _languageMetadata[locale.languageCode];
    return _LanguageOption(
      locale: locale,
      label: metadata?.label ?? locale.languageCode.toUpperCase(),
      flag: metadata?.flag,
    );
  }

  static _LanguageOption _resolveOption(Locale locale) {
    if (_options.isEmpty) return _buildOptionFromLocale(locale);
    return _options.firstWhere((option) => option.matches(locale), orElse: () => _options.first);
  }

  static bool _isSameLocale(Locale a, Locale b) =>
      a.languageCode == b.languageCode && (a.scriptCode ?? '') == (b.scriptCode ?? '');

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) => BlocSelector<AppBloc, AppState, Locale>(
    selector: (state) => state.locale,
    builder: (context, currentLocale) {
      final option = LanguageSelector._resolveOption(currentLocale);
      return CompositedTransformTarget(
        link: _layerLink,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: Dimension.rAll8,
            onTap: () => _toggleOverlay(currentLocale),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: Dimension.rAll8,
                color: context.color.white.withValues(alpha: .1),
                border: Border.all(color: context.color.white.withValues(alpha: .1)),
              ),
              child: Padding(
                padding: Dimension.pH8V6,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _LocaleBadge(option: option),
                    Dimension.wBox6,
                    Text(option.label, style: context.textTheme.interW500s14.copyWith(color: context.color.white)),
                    Dimension.wBox8,
                    Icon(Icons.keyboard_arrow_down, color: context.color.white, size: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );

  void _toggleOverlay(Locale currentLocale) {
    if (_overlayEntry != null) {
      _removeOverlay();
    } else {
      _showOverlay(currentLocale);
    }
  }

  void _showOverlay(Locale currentLocale) {
    final overlay = Overlay.of(context);
    final bloc = context.read<AppBloc>();

    _overlayEntry = OverlayEntry(
      builder: (context) => _LanguageDropdownOverlay(
        layerLink: _layerLink,
        options: LanguageSelector._options,
        selectedLocale: currentLocale,
        onDismiss: _removeOverlay,
        onChanged: (locale) {
          _removeOverlay();
          if (!LanguageSelector._isSameLocale(currentLocale, locale)) {
            bloc.add(ChangeLocale(locale: locale));
          }
        },
      ),
    );
    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }
}

class _LanguageDropdownOverlay extends StatelessWidget {
  const _LanguageDropdownOverlay({
    required this.layerLink,
    required this.options,
    required this.selectedLocale,
    required this.onChanged,
    required this.onDismiss,
  });

  final LayerLink layerLink;
  final List<_LanguageOption> options;
  final Locale selectedLocale;
  final ValueChanged<Locale> onChanged;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) => Material(
    color: context.color.transparent,
    child: Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(behavior: HitTestBehavior.translucent, onTap: onDismiss),
        ),
        CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          targetAnchor: Alignment.bottomCenter,
          followerAnchor: Alignment.topCenter,
          offset: const Offset(-40, 4),
          child: _LanguageDropdownCard(options: options, selectedLocale: selectedLocale, onChanged: onChanged),
        ),
      ],
    ),
  );
}

class _LanguageDropdownCard extends StatelessWidget {
  const _LanguageDropdownCard({required this.options, required this.selectedLocale, required this.onChanged});

  final List<_LanguageOption> options;
  final Locale selectedLocale;
  final ValueChanged<Locale> onChanged;

  @override
  Widget build(BuildContext context) => Material(
    elevation: 8,
    borderRadius: Dimension.rAll12,
    clipBehavior: Clip.antiAlias,
    color: context.color.white,
    child: ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 160, maxWidth: 220),
      child: Padding(
        padding: Dimension.pH12V8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < options.length; i++) ...[
              _LanguageTile(
                option: options[i],
                isSelected: options[i].matches(selectedLocale),
                onTap: () => onChanged(options[i].locale),
              ),
              if (i < options.length - 1) Dimension.hBox4,
            ],
          ],
        ),
      ),
    ),
  );
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({required this.option, required this.isSelected, required this.onTap});

  final _LanguageOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: Dimension.localeItemHeight.toDouble(),
    child: Material(
      color: context.color.transparent,
      child: InkWell(
        borderRadius: Dimension.rAll8,
        onTap: onTap,
        child: Padding(
          padding: Dimension.pH12V8,
          child: Row(
            children: [
              _LocaleBadge(option: option),
              Dimension.wBox12,
              Expanded(child: Text(option.label, style: context.textTheme.interW500s14)),
              if (isSelected) Icon(Icons.check, color: context.color.primary, size: 20),
            ],
          ),
        ),
      ),
    ),
  );
}

class _LocaleBadge extends StatelessWidget {
  const _LocaleBadge({required this.option});

  final _LanguageOption option;

  @override
  Widget build(BuildContext context) {
    final flag = option.flag;
    if (flag != null) {
      return ClipRRect(
        borderRadius: Dimension.rAll8,
        child: flag.image(width: 24, height: 24, fit: BoxFit.cover),
      );
    }

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: Dimension.rAll8,
        color: context.color.white.withValues(alpha: .12),
        border: Border.all(color: context.color.primary.withValues(alpha: .3)),
      ),
      alignment: Alignment.center,
      child: Text(option.locale.languageCode.toUpperCase(), style: context.textTheme.interW500s10),
    );
  }
}

class _LanguageOption {
  const _LanguageOption({required this.locale, required this.label, this.flag});

  final Locale locale;
  final String label;
  final AssetGenImage? flag;

  bool matches(Locale other) =>
      locale.languageCode == other.languageCode && (locale.scriptCode ?? '') == (other.scriptCode ?? '');
}

class _LanguageMetadata {
  const _LanguageMetadata({required this.label, this.flag});

  final String label;
  final AssetGenImage? flag;
}
