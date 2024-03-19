import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/failure.dart';
import 'package:mindtunes/core/usecase/usecase.dart';
import 'package:mindtunes/core/common/entities/user.dart';
import 'package:mindtunes/features/auth/domain/repository/auth_repository.dart';

class UserLogin implements UseCase<User, UserLoginParms> {
  final AuthRepository authRepository;

  UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParms params) async {
    return await authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParms {
  final String email;
  final String password;

  UserLoginParms({
    required this.email,
    required this.password,
  });
}
