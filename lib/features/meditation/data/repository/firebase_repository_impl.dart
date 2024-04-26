import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/exceptions.dart';
import 'package:mindtunes/core/error/failure.dart';
import 'package:mindtunes/features/meditation/data/data_sources/firebase_data_source.dart';
import 'package:mindtunes/features/meditation/data/models/meditation_model.dart';
import 'package:mindtunes/features/meditation/data/models/music_model.dart';
import 'package:mindtunes/features/meditation/domain/repository/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseDataSource firebaseDataSource;

  FirebaseRepositoryImpl(this.firebaseDataSource);
  @override
  Future<Either<Failure, List<MusicModel>>> getMusic() async {
    try {
      final music = await firebaseDataSource.getMusic();
      return Right(music);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  void updateMeditationdata(MeditationModel model) {
    firebaseDataSource.updateMeditationdata(meditationModel: model);
  }

  @override
  Future<Either<Failure, List<MeditationModel>>> getMeditationHistory() async {
    try {
      final meditation = await firebaseDataSource.getMeditationHistory();
      return Right(meditation);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
