import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/failure.dart';
import 'package:mindtunes/features/meditation/data/models/meditation_model.dart';
import 'package:mindtunes/features/meditation/data/models/music_model.dart';

abstract interface class FirebaseRepository {
  Future<Either<Failure, List<MusicModel>>> getMusic();
  void updateMeditationdata(MeditationModel meditation);
  Future<Either<Failure, List<MeditationModel>>> getMeditationHistory();
}
