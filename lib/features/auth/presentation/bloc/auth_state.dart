part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User user;
  const AuthSuccess(this.user);
}

final class AuthSucess2 extends AuthState {}

final class AuthSuccess1 extends AuthState {
  final String message;

  const AuthSuccess1(this.message);
}

final class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
}
