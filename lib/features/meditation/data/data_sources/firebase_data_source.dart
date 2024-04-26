import 'package:mindtunes/features/meditation/data/models/meditation_model.dart';
import 'package:mindtunes/features/meditation/data/models/music_model.dart';

abstract interface class FirebaseDataSource {
  Future<List<MusicModel>> getMusic();
  void updateMeditationdata({
    required MeditationModel meditationModel,
  });
  Future<List<MeditationModel>> getMeditationHistory();
}
