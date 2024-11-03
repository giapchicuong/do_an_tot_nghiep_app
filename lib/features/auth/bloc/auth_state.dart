part of 'auth_bloc.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoginInitial extends AuthState {
  AuthLoginInitial({required this.email, required this.password});

  final String email, password;
}

class AuthLoginInProgress extends AuthState {}

class AuthLoginSuccess extends AuthState {}

class AuthLoginFailure extends AuthState {
  AuthLoginFailure(this.message);
  final String message;
}

class AuthRegisterInProgress extends AuthState {}

class AuthRegisterSuccess extends AuthState {}

class AuthRegisterFailure extends AuthState {
  AuthRegisterFailure(this.message);
  final String message;
}

class AuthAuthenticatedSuccess extends AuthState {
  AuthAuthenticatedSuccess(this.data);

  final UserAccountSuccessDto data;
}

class AuthAuthenticateUnauthenticated extends AuthState {}

class AuthAuthenticatedFailure extends AuthState {
  AuthAuthenticatedFailure(this.message);

  final String message;
}

class AuthLogoutSuccess extends AuthState {}

class AuthLogoutFailure extends AuthState {
  AuthLogoutFailure(this.message);

  final String message;
}
