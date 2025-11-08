part of 'app_bloc.dart';

sealed class AppEvent {
  const AppEvent();
}

class ChangeTheme extends AppEvent {
  const ChangeTheme({required this.mode});
  final ThemeMode mode;
}

class ChangeLocale extends AppEvent {
  const ChangeLocale({required this.locale});
  final Locale locale;
}
