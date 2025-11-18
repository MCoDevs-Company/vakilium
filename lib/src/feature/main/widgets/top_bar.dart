import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:vakilium/src/common/constant/gen/assets.gen.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/router/router.dart';
import 'package:vakilium/src/common/util/dimension.dart';
import 'package:vakilium/src/common/widgets/app_logo.dart';
import 'package:vakilium/src/common/widgets/button_wrapper.dart';
import 'package:vakilium/src/feature/main/models/menu_item.dart';
import 'package:vakilium/src/feature/main/widgets/menu_button.dart';

class TopBar extends StatefulWidget {
  const TopBar({required this.menuItems, super.key});
  final List<MenuItem> menuItems;

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
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
              onTap: () => context.go(Routes.main),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 40,
                children: List.generate(widget.menuItems.length, (index) {
                  final menuItem = widget.menuItems[index];
                  return MenuButton(menuItem: menuItem);
                }),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ButtonWrapper(child: Assets.icons.sun.svg(width: 20, height: 20), onPressed: () => print('object')),
                Dimension.wBox8,
                ButtonWrapper(
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
