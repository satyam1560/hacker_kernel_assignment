// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthChangedEvent extends AuthenticationEvent {}

class AuthLoggedIn extends AuthenticationEvent {
  final String email;
  final String password;
  const AuthLoggedIn({
    required this.email,
    required this.password,
  });
  @override
  List<Object?> get props => [email, password];
}

class AuthLoggedOut extends AuthenticationEvent {}
