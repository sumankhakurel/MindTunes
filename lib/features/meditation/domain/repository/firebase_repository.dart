import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/failure.dart';
import 'package:mindtunes/features/meditation/data/models/music_model.dart';

abstract interface class FirebaseRepository {
  Future<Either<Failure, List<MusicModel>>> getMusic();
}
