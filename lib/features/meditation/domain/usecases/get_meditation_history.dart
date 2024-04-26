import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/failure.dart';
import 'package:mindtunes/core/usecase/usecase.dart';
import 'package:mindtunes/features/meditation/data/models/meditation_model.dart';
import 'package:mindtunes/features/meditation/domain/repository/firebase_repository.dart';

class GetMeditationHistory implements UseCase<List<MeditationModel>, NoParams> {
  final FirebaseRepository firebaseRepository;

  GetMeditationHistory(this.firebaseRepository);
  @override
  Future<Either<Failure, List<MeditationModel>>> call(NoParams params) async {
    return firebaseRepository.getMeditationHistory();
  }
}
