part of 'mindwave_bloc.dart';

@immutable
sealed class MindwaveState {}

final class MindwaveInitial extends MindwaveState {}

final class MindwaveLoading extends MindwaveState {}

final class MindwaveSuccess extends MindwaveState {
  final MWMConnectionState message;

  MindwaveSuccess(this.message);
}

final class MindwaveFailure extends MindwaveState {
  final String message;

  MindwaveFailure(this.message);
}

class MindwaveDataSuccess extends MindwaveState {
  final int data;

  MindwaveDataSuccess(this.data);
}
