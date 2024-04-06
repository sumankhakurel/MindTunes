part of 'player_bloc.dart';

@immutable
sealed class PlayerEvent {}

class PlayPauseEvent extends PlayerEvent {
  final bool isPlaying;
  final double progress;
  final Music music;
  PlayPauseEvent(
      {required this.isPlaying, required this.music, this.progress = 0.0});
}

class PlayEvent extends PlayerEvent {
  final bool isPlaying;
  final Music music;

  PlayEvent({this.isPlaying = true, required this.music});
}

class ProgressUpdateEvent extends PlayerEvent {
  final double progress;
  ProgressUpdateEvent({required this.progress});
}

class ProgressSeekEvent extends PlayerEvent {
  final double progress;

  ProgressSeekEvent({required this.progress});
}

class PlayerStopEvent extends PlayerEvent {}
