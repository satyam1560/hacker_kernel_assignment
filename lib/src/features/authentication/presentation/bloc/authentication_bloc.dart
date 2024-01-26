import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_kernel_assignment/src/config/shared_prefs.dart';
import 'package:hacker_kernel_assignment/src/features/authentication/domain/entities/user.dart';
import 'package:hacker_kernel_assignment/src/features/authentication/domain/usecases/auth_usecase.dart';
import 'package:hacker_kernel_assignment/src/features/failure.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthUsecase _authUsecase;
  AuthenticationBloc({required AuthUsecase authUsecase})
      : _authUsecase = authUsecase,
        super(AuthenticationState.unknown()) {
    on<AuthLoggedIn>(_onAuthLoggedIn);
    on<AuthLoggedOut>(_onAuthLoggedOut);
  }

  Future<void> _onAuthLoggedIn(
    AuthLoggedIn event,
    Emitter<AuthenticationState> emit,
  ) async {
    final response = await _authUsecase.login(
      email: event.email,
      password: event.password,
    );
    response.fold(
      (left) => emit(
        state.copyWith(
          status: AuthenticationStateStatus.unauthenticated,
        ),
      ),
      (user) {
        if (user?.token != null) {
          SharedPrefs.setToken(user!.token);
          emit(
            state.copyWith(
              status: AuthenticationStateStatus.authenticated,
              user: user,
            ),
          );
        }
      },
    );
  }

  Future<void> _onAuthLoggedOut(
    AuthLoggedOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    await SharedPrefs.clear();

    emit(
      AuthenticationState.unknown(),
    );
  }
}
