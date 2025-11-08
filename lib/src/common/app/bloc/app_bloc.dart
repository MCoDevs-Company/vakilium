import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:local_source/local_source.dart';
import 'package:vakilium/src/common/constant/gen/fonts.gen.dart';
import 'package:vakilium/src/common/theme/theme_data.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this.localSource)
    : super(AppState(locale: localSource.localization, theme: _getThemeData(localSource.theme))) {
    on<AppEvent>(
      (event, emit) => switch (event) {
        ChangeTheme event => _onChangeTheme(event, emit),
        ChangeLocale event => _onChangeLocale(event, emit),
      },
    );
  }
  final LocalSource localSource;

  static AppThemeData _getThemeData(ThemeMode theme) {
    final lightTheme = AppThemeData.light(FontFamily.inter);
    final darkTheme = AppThemeData.dark(FontFamily.inter);
    return switch (theme) {
      ThemeMode.light => lightTheme,
      ThemeMode.dark => darkTheme,
      _ => lightTheme,
    };
  }

  Future<void> _onChangeTheme(ChangeTheme event, Emitter<AppState> emit) async {
    await localSource.setTheme(event.mode);
    emit(state.copyWith(theme: _getThemeData(event.mode)));
  }

  Future<void> _onChangeLocale(ChangeLocale event, Emitter<AppState> emit) async {
    await localSource.setLocalization(event.locale);
    emit(state.copyWith(locale: event.locale));
  }
}
