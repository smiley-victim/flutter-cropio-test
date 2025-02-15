part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class LoginAsGuest extends AuthEvent {}

final class EmailLogin extends AuthEvent {
  final String email;
  final String password;
  const EmailLogin({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

final class EmailRegister extends AuthEvent {
  final String email;
  final String password;
  final String name;
  const EmailRegister(this.name, {required this.email, required this.password});

  @override
  List<Object> get props => [email, password,name];
}
