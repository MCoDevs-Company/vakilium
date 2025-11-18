import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/feature/main/cubit/main_cubit.dart';
import 'package:vakilium/src/feature/main/models/menu_item.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({required this.menuItem, super.key});

  final MenuItem menuItem;

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  void initState() {
    super.initState();
    GoRouter.of(context).routerDelegate.addListener(_listener);
  }

  void _listener() => setState(() {});

  @override
  void dispose() {
    GoRouter.of(context).routerDelegate.removeListener(_listener);
    super.dispose();
  }

  String _getTitle(MenuItem menuItem) => switch (menuItem.slug) {
    'home' => context.l10n.main,
    'services' => context.l10n.services,
    'requests' => context.l10n.requests,
    'chat' => context.l10n.chat,
    _ => menuItem.slug,
  };

  @override
  Widget build(BuildContext context) => BlocSelector<MainCubit, MainState, MenuItem?>(
    selector: (state) => state.selectedMenuItem,
    builder: (context, selected) {
      final isSelected = selected == widget.menuItem;
      return InkWell(
        onTap: () => context.read<MainCubit>().selectMenuItem(widget.menuItem),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            _getTitle(widget.menuItem),
            style: context.textTheme.interW500s18.copyWith(
              color: isSelected ? context.color.primary : context.color.gray700,
            ),
          ),
        ),
      );
    },
  );
}
