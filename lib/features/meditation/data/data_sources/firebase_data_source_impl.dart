import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindtunes/core/error/exceptions.dart';

import 'package:mindtunes/features/meditation/data/data_sources/firebase_data_source.dart';
import 'package:mindtunes/features/meditation/data/models/music_model.dart';

class FirebaseDataSourceImpl implements FirebaseDataSource {
  final FirebaseFirestore _firestore;

  FirebaseDataSourceImpl(this._firestore);
  @override
  Future<List<MusicModel>> getMusic() async {
    List<MusicModel> musics = [];
    try {
      final musicCollection = _firestore.collection("music");
      final docSnapshot = await musicCollection.get();
      musics = docSnapshot.docs.map((doc) {
        return MusicModel.fromSnapshot(doc);
      }).toList();

      return musics;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
