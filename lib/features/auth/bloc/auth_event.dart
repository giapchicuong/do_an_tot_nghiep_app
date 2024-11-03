part of 'auth_bloc.dart';

class AuthEvent {}

class AuthStarted extends AuthEvent {}

class AuthLoginStarted extends AuthEvent {
  AuthLoginStarted({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}

class AuthLoginPrefilled extends AuthEvent {
  AuthLoginPrefilled({required this.email, required this.password});

  final String email, password;
}

class AuthRegisterStarted extends AuthEvent {
  AuthRegisterStarted({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
  });

  final String fullName;
  final String email;
  final String phone;
  final String password;
}

class AuthAuthenticatedStarted extends AuthEvent {}

class AuthLogoutStarted extends AuthEvent {}
