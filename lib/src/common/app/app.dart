import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_source/local_source.dart';
import 'package:thunder/thunder.dart';
import 'package:vakilium/src/common/app/bloc/app_bloc.dart';
import 'package:vakilium/src/common/app/di.dart';
import 'package:vakilium/src/common/constant/config.dart';
import 'package:vakilium/src/common/localization/localization.dart';
import 'package:vakilium/src/common/router/router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late AppBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = AppBloc(di<LocalSource>());
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _bloc,
    child: BlocBuilder<AppBloc, AppState>(
      bloc: _bloc,
      builder: (context, state) => MaterialApp.router(
        restorationScopeId: 'material_app',

        debugShowCheckedModeBanner: false,
        title: "Vakilium",

        // Theme
        theme: state.theme,

        // Locale
        supportedLocales: Localization.supportedLocales,
        localizationsDelegates: Localization.delegates,
        locale: state.locale,

        routerConfig: Routes.router,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: Thunder(enabled: Config.current.thunderEnabled, child: child ?? const SizedBox.shrink()),
        ),
      ),
    ),
  );
}
