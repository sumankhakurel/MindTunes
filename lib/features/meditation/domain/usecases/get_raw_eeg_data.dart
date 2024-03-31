import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/failure.dart';
import 'package:mindtunes/features/meditation/domain/repository/mindwave_repository.dart';

class GetRaweegData {
  final MindwaveRepository mindwaveRepository;

  GetRaweegData(this.mindwaveRepository);

  Stream<Either<Failure, int>> call() {
    return mindwaveRepository.getRaweegData();
  }
}
