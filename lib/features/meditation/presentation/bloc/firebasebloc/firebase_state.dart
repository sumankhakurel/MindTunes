part of 'firebase_bloc.dart';

@immutable
sealed class FirebaseState {}

final class FirebaseInitial extends FirebaseState {}

final class FirebaseLoading extends FirebaseState {}

final class FirebaseSucess extends FirebaseState {
  final List<Music> musics;

  FirebaseSucess(this.musics);
}

final class FirebaseFailure extends FirebaseState {
  final String message;

  FirebaseFailure(this.message);
}
