import 'package:dartz/dartz.dart';
import 'package:hacker_kernel_assignment/src/features/authentication/domain/entities/user.dart';
import 'package:hacker_kernel_assignment/src/features/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, User?>> login({
    required String email,
    required String password,
  });
  // Future<Either<Failure, bool>> signout(String token);
  // Future<Either<Failure, String>> getToken();
}
