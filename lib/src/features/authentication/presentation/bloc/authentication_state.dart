part of 'authentication_bloc.dart';

enum AuthenticationStateStatus { unknown, authenticated, unauthenticated }

class AuthenticationState extends Equatable {
  final AuthenticationStateStatus status;
  final User? user;
  final Failure? failure;

  const AuthenticationState({
    required this.status,
    this.user,
    this.failure,
  });

  factory AuthenticationState.unknown() => const AuthenticationState(
        status: AuthenticationStateStatus.unknown,
      );

  AuthenticationState copyWith({
    AuthenticationStateStatus? status,
    User? user,
    Failure? failure,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      user: user ?? this.user,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, user, failure];
}
