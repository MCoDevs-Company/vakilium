import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:vakilium/src/common/constant/gen/assets.gen.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/router/router.dart';
import 'package:vakilium/src/common/util/dimension.dart';
import 'package:vakilium/src/common/util/logger.dart';
import 'package:vakilium/src/common/widgets/app_logo.dart';

class MainShell extends StatefulWidget {
  const MainShell({required this.child, super.key});
  final Widget child;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      children: [
        widget.child,
        const Positioned(left: 16, right: 16, top: 16, child: TopBar()),
      ],
    ),
  );
}

class MenuItem {
  const MenuItem({required this.title, required this.route});
  final String title;
  final String route;
}

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  List<MenuItem> getMenuItems(BuildContext context) => [
    MenuItem(title: context.l10n.main, route: Routes.home),
    MenuItem(title: context.l10n.services, route: Routes.services),
    MenuItem(title: context.l10n.requests, route: Routes.requests),
    MenuItem(title: context.l10n.chat, route: Routes.chat),
  ];

  @override
  Widget build(BuildContext context) => PointerInterceptor(
    child: DecoratedBox(
      decoration: BoxDecoration(color: context.color.white, borderRadius: Dimension.rAll20),
      child: Padding(
        padding: Dimension.pH24V16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              child: AppLogo.horizontal(color: context.color.primary),
              onTap: () => context.go(Routes.home),
            ),
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: context.width * 0.2, minWidth: context.width * 0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(getMenuItems(context).length, (index) {
                    final menuItem = getMenuItems(context)[index];
                    return MenuButton(menuItem: menuItem);
                  }),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ButtonWrap(child: Assets.icons.sun.svg(width: 20, height: 20), onPressed: () => print('object')),
                Dimension.wBox8,
                ButtonWrap(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Assets.icons.user.svg(width: 20, height: 20),
                      Dimension.wBox8,
                      Text(
                        context.l10n.profile,
                        style: context.textTheme.interW600s14.copyWith(color: context.color.gray700),
                      ),
                    ],
                  ),
                  onPressed: () => print('object'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

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

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouter.of(context).state.uri.toString();
    final isSelected = currentRoute == widget.menuItem.route;
    return InkWell(
      onTap: () => context.go(widget.menuItem.route),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          widget.menuItem.title,
          style: context.textTheme.interW500s18.copyWith(
            color: isSelected ? context.color.primary : context.color.gray700,
          ),
        ),
      ),
    );
  }
}

class ButtonWrap extends StatelessWidget {
  const ButtonWrap({required this.child, super.key, this.onPressed});

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onPressed,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.color.gray300),
        borderRadius: Dimension.rAll10,
      ),
      padding: Dimension.pAll10,
      child: child,
    ),
  );
}
