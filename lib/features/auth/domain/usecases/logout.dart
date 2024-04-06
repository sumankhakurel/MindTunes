import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/failure.dart';
import 'package:mindtunes/core/usecase/usecase.dart';
import 'package:mindtunes/features/auth/domain/repository/auth_repository.dart';

class Logout implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  Logout(this.authRepository);
  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return authRepository.logout();
  }
}
