import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mindtunes/features/meditation/domain/entities/music.dart';

class MusicModel extends Music {
  MusicModel({
    required super.name,
    required super.imageurl,
    required super.musicurl,
    required super.duration,
  });

  factory MusicModel.fromSnapshot(DocumentSnapshot snapshot) {
    return MusicModel(
      imageurl: snapshot.get('imageurl'),
      musicurl: snapshot.get('musicurl'),
      name: snapshot.get('name'),
      duration: snapshot.get('duration'),
    );
  }
}
