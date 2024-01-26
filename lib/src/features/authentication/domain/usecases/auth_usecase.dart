import 'package:dartz/dartz.dart';
import 'package:hacker_kernel_assignment/src/features/authentication/domain/entities/user.dart';
import 'package:hacker_kernel_assignment/src/features/authentication/domain/repositories/auth_repo.dart';
import 'package:hacker_kernel_assignment/src/features/failure.dart';

class AuthUsecase {
  final AuthRepo _authRepo;
  AuthUsecase({
    required AuthRepo authRepo,
  }) : _authRepo = authRepo;

  Future<Either<Failure, User?>> login({
    required String email,
    required String password,
  }) {
    return _authRepo.login(
      email: email,
      password: password,
    );
  }
}
