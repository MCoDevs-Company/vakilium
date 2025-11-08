import 'package:flutter/material.dart';
import 'package:thunder/thunder.dart';
import 'package:vakilium/src/common/constant/config.dart';
import 'package:vakilium/src/common/router/router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) => MaterialApp.router(
    restorationScopeId: 'material_app',

    debugShowCheckedModeBanner: false,
    title: "Vakilium",

    routerConfig: Routes.router,
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: Thunder(enabled: Config.current.thunderEnabled, child: child ?? const SizedBox.shrink()),
    ),
  );
}
