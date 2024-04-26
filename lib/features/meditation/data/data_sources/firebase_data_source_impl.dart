import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:mindtunes/core/error/exceptions.dart';

import 'package:mindtunes/features/meditation/data/data_sources/firebase_data_source.dart';
import 'package:mindtunes/features/meditation/data/models/meditation_model.dart';
import 'package:mindtunes/features/meditation/data/models/music_model.dart';

class FirebaseDataSourceImpl implements FirebaseDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  FirebaseDataSourceImpl(this.firestore, this.firebaseAuth);
  @override
  Future<List<MusicModel>> getMusic() async {
    List<MusicModel> musics = [];
    try {
      final musicCollection = firestore.collection("music");
      final docSnapshot = await musicCollection.get();
      musics = docSnapshot.docs.map((doc) {
        return MusicModel.fromSnapshot(doc);
      }).toList();

      return musics;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  void updateMeditationdata({required MeditationModel meditationModel}) async {
    await firebaseAuth.currentUser?.reload();
    final uid = firebaseAuth.currentUser?.uid;
    if (uid != null) {
      final userCollection = firestore.collection(uid);
      userCollection.doc().set(meditationModel.toDocument());
    } else {}
  }

  @override
  Future<List<MeditationModel>> getMeditationHistory() async {
    List<MeditationModel> meditation = [];
    await firebaseAuth.currentUser?.reload();
    final uid = firebaseAuth.currentUser?.uid;
    try {
      final meditationCollection = firestore.collection(uid!);
      final docSnapshot = await meditationCollection.get();

      meditation = docSnapshot.docs.map((doc) {
        return MeditationModel.fromSnapshot(doc);
      }).toList();
      print(meditation.length);
      return meditation;
    } catch (e) {
      print(e.toString());
      throw ServerException(e.toString());
    }
  }
}
