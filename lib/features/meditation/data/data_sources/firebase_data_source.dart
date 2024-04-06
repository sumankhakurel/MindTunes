import 'package:mindtunes/features/meditation/data/models/music_model.dart';

abstract interface class FirebaseDataSource {
  Future<List<MusicModel>> getMusic();
}
