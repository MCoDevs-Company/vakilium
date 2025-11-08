import 'package:get_it/get_it.dart';
import 'package:local_source/local_source.dart';

GetIt di = GetIt.instance;

Future<void> setupDi() async {
  final storage = await LocalSource.instance;
  di.registerSingleton<LocalSource>(storage);
}
