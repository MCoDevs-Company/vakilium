part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({this.authStatus = Status.initial});

  final Status authStatus;

  AuthState copyWith({Status? authStatus}) => AuthState(authStatus: authStatus ?? this.authStatus);

  @override
  List<Object?> get props => [authStatus];
}
