import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/failure.dart';
import 'package:mindtunes/core/common/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> getUserStatus();

  Future<Either<Failure, String>> logout();

  Future<Either<Failure, String>> deleteAccount({
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> resetPasword({
    required String email,
  });
}
