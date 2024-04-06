import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/failure.dart';
import 'package:mindtunes/core/usecase/usecase.dart';
import 'package:mindtunes/features/meditation/data/models/music_model.dart';
import 'package:mindtunes/features/meditation/domain/repository/firebase_repository.dart';

class GetMusic implements UseCase<List<MusicModel>, NoParams> {
  final FirebaseRepository firebaseRepository;

  GetMusic(this.firebaseRepository);
  @override
  Future<Either<Failure, List<MusicModel>>> call(NoParams params) async {
    return firebaseRepository.getMusic();
  }
}
