import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/failure.dart';
import 'package:mindtunes/core/usecase/usecase.dart';
import 'package:mindtunes/core/common/entities/user.dart';
import 'package:mindtunes/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<User, UserSignupParms> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignupParms params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignupParms {
  final String email;
  final String password;
  final String name;

  UserSignupParms({
    required this.email,
    required this.password,
    required this.name,
  });
}
