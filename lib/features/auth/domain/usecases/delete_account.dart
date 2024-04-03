import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/common/entities/user.dart';
import 'package:mindtunes/core/error/failure.dart';
import 'package:mindtunes/core/usecase/usecase.dart';
import 'package:mindtunes/features/auth/domain/repository/auth_repository.dart';
import 'package:mindtunes/features/auth/domain/usecases/user_login.dart';

class DeleteAccount implements UseCase<String, UserLoginParms> {
  final AuthRepository authRepository;

  DeleteAccount(this.authRepository);
  @override
  Future<Either<Failure, String>> call(UserLoginParms params) async {
    return await authRepository.deleteAccount(
      email: params.email,
      password: params.password,
    );
  }
}
