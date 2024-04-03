import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/failure.dart';
import 'package:mindtunes/core/usecase/usecase.dart';
import 'package:mindtunes/features/auth/domain/repository/auth_repository.dart';

class ResetPassword implements UseCase<String, String> {
  final AuthRepository authRepository;

  ResetPassword(this.authRepository);
  @override
  Future<Either<Failure, String>> call(String email) async {
    return await authRepository.resetPasword(
      email: email,
    );
  }
}
