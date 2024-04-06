import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/exceptions.dart';
import 'package:mindtunes/core/error/failure.dart';
import 'package:mindtunes/features/meditation/data/data_sources/firebase_data_source.dart';
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
}
