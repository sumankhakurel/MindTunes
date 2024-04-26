import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/exceptions.dart';
import 'package:mindtunes/core/error/failure.dart';
import 'package:mindtunes/features/auth/data/data_sources/auth_remote_data_source.dart';

import 'package:mindtunes/core/common/entities/user.dart';
import 'package:mindtunes/features/auth/domain/repository/auth_repository.dart';

class AuthReposotoriesImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthReposotoriesImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final user = await remoteDataSource.loginWithEmailPassword(
          email: email, password: password);
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> getUserStatus() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      if (user != null) {
        return right(user);
      } else {
        return left(Failure("User Not Logged in"));
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      await remoteDataSource.logout();
      return right("Logout");
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deleteAccount(
      {required String email, required String password}) async {
    try {
      await remoteDataSource.deleteAccount(email: email, password: password);
      return right("Account Deleted");
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> resetPasword({required String email}) async {
    try {
      await remoteDataSource.resetPassword(email: email);
      return right("Password Reset");
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
