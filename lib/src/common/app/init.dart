import 'package:flutter/material.dart';
import 'package:vakilium/src/common/app/app.dart';
import 'package:vakilium/src/common/app/di.dart';

sealed class Init {
  static Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();
    await setupDi();
    runApp(const App());
  }
}
