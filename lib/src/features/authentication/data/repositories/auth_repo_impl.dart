// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:hacker_kernel_assignment/src/features/authentication/data/datasources/auth_datasource.dart';
import 'package:hacker_kernel_assignment/src/features/authentication/data/models/user_dto.dart';
import 'package:hacker_kernel_assignment/src/features/authentication/domain/repositories/auth_repo.dart';
import 'package:hacker_kernel_assignment/src/features/failure.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthDataSource _authDataSource;
  AuthRepoImpl({required AuthDataSource authDataSource})
      : _authDataSource = authDataSource;

  @override
  Future<Either<Failure, UserDto?>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authDataSource.login(
        email: email,
        password: password,
      );

      return Right(user);
    } catch (error) {
      return Left(
        Failure(
          failureMessage: error.toString(),
        ),
      );
    }
  }
}
