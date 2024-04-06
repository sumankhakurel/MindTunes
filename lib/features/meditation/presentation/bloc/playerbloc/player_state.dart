part of 'player_bloc.dart';

enum SongStatus { playing, pause, stopped }

@immutable
class PlayerState {
  final bool isPlaying;
  final double progress;

  final Music? music;
  final SongStatus status;
  final String duration;

  const PlayerState(
      {this.isPlaying = true,
      this.duration = "0:0",
      this.progress = 0.0,
      this.status = SongStatus.stopped,
      this.music});

  PlayerState copyWith({
    bool? isPlaying,
    double? progress,
    bool? isFavourite,
    SongStatus? status,
    final Music? music,
    String? duration,
  }) {
    return PlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      music: music ?? this.music,
      duration: duration ?? this.duration,
    );
  }
}

final class PlayerInitial extends PlayerState {}
