import 'package:flutter/material.dart';
import 'package:vakilium/src/common/app/app.dart';
import 'package:vakilium/src/common/app/di.dart';
import 'package:vakilium/src/common/util/logger.dart';
import 'package:yandex_js_maps/yandex_js_maps.dart';

sealed class Init {
  static Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();
    await setupDi();
    await initYandexMaps();
    runApp(const App());
  }

  static Future<void> initYandexMaps() async {
    const yandexMapKitKey = String.fromEnvironment('YANDEX_MAPKIT_API_KEY', defaultValue: '');
    if (yandexMapKitKey.isEmpty) {
      throw StateError('YANDEX_MAPKIT_API_KEY is not provided. Pass it via --dart-define.');
    }
    info('Initializing Yandex Maps with API key: $yandexMapKitKey');
    await YandexJsMapFactory.setMapApi(yandexMapKitKey);
  }
}
