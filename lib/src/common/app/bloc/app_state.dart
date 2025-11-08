part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState({required this.theme, required this.locale});
  final AppThemeData theme;
  final Locale locale;

  AppState copyWith({AppThemeData? theme, Locale? locale}) =>
      AppState(theme: theme ?? this.theme, locale: locale ?? this.locale);

  @override
  List<Object> get props => [theme, locale];
}
