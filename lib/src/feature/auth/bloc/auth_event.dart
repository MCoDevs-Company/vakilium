part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class LoginEvent extends AuthEvent {
  const LoginEvent();
}

final class RegisterEvent extends AuthEvent {
  const RegisterEvent();
}
