import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindtunes/features/meditation/domain/entities/meditation.dart';

class MeditationModel extends Meditation {
  MeditationModel({
    required super.minAttentation,
    required super.maxAttentation,
    required super.avgAttentation,
    required super.minMeditation,
    required super.maxMeditation,
    required super.avgMeditation,
    required super.starttime,
    required super.endtime,
    required super.duration,
  });
  factory MeditationModel.fromSnapshot(DocumentSnapshot snapshot) {
    return MeditationModel(
      maxAttentation: snapshot.get("maxAttentation"),
      maxMeditation: snapshot.get("maxMeditation"),
      minAttentation: snapshot.get("minAttentation"),
      avgAttentation: snapshot.get("avgAttentation"),
      avgMeditation: snapshot.get("avgMeditation"),
      duration: snapshot.get("duration"),
      endtime: snapshot.get("endtime").toDate(),
      minMeditation: snapshot.get("minMeditation"),
      starttime: snapshot.get("starttime").toDate(),
    );
  }
  Map<String, dynamic> toDocument() {
    return {
      "minAttentation": minAttentation,
      "maxAttentation": maxAttentation,
      "avgAttentation": avgAttentation,
      "minMeditation": minMeditation,
      "maxMeditation": maxMeditation,
      "avgMeditation": avgMeditation,
      "starttime": starttime,
      "endtime": endtime,
      "duration": duration,
    };
  }
}
