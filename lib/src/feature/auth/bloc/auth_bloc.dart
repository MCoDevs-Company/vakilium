import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vakilium/src/common/models/status.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<AuthEvent>(
      (event, emit) => switch (event) {
        final LoginEvent event => _onLoginEvent(event, emit),
        final RegisterEvent event => _onRegisterEvent(event, emit),
      },
    );
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: Status.loading));
    // ignore: inference_failure_on_instance_creation
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(authStatus: Status.success));
  }

  Future<void> _onRegisterEvent(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: Status.loading));
    // ignore: inference_failure_on_instance_creation
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(authStatus: Status.success));
  }
}
