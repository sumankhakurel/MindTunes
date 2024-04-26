part of 'firebasedata_bloc.dart';

@immutable
sealed class FirebasedataState {}

final class FirebasedataInitial extends FirebasedataState {}

final class FirebasedataLoading extends FirebasedataState {}

final class FirebasedataSucess extends FirebasedataState {
  final List<Meditation> meditation;
  final double totalminutes;
  final int totalsessions;

  FirebasedataSucess(this.meditation, this.totalminutes, this.totalsessions);
}

final class FirebasedataFailure extends FirebasedataState {
  final String message;

  FirebasedataFailure(this.message);
}
