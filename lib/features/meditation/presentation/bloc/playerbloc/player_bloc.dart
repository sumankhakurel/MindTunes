import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mindtunes/features/meditation/domain/entities/music.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final AudioPlayer player;
  bool isPlaying = false;
  Timer? timer;
  PlayerBloc(this.player) : super(PlayerInitial()) {
    on<PlayerEvent>((event, emit) {});
    on<PlayPauseEvent>((event, Emitter<PlayerState> emit) async {
      if (isPlaying) {
        player.pause();

        emit(state.copyWith(
          isPlaying: false,
        ));
      } else {
        if (state.progress == 0.0) {
          add(PlayEvent(music: state.music!));
        }
        player.play();

        emit(state.copyWith(
          isPlaying: true,
        ));
      }

      isPlaying = event.isPlaying;
    });

    on<PlayEvent>((event, Emitter<PlayerState> emit) async {
      await player.setUrl(event.music.musicurl);
      player.play();

      isPlaying = true;
      double progress = 0.0;
      emit(state.copyWith(
          isPlaying: true, status: SongStatus.playing, music: event.music));
      Timer.periodic(const Duration(milliseconds: 1), (timer) {
        progress = player.duration == null
            ? 0.0
            : player.position.inMilliseconds / player.duration!.inMilliseconds;
        add(ProgressUpdateEvent(progress: progress));
        if (progress >= 1.0) {
          timer.cancel();
        }
      });
    });
    on<ProgressUpdateEvent>((event, Emitter<PlayerState> emit) async {
      if (event.progress == 1.0) {
        player.pause();

        isPlaying = false;

        player.seek(const Duration(seconds: 0));
        emit(state.copyWith(
          duration: "0:0",
          progress: 0.0,
          isPlaying: false,
        ));
        // add(PlayEvent(music: state.music!));
      } else {
        String minute = player.position.inMinutes.toString();
        String second = player.position.inSeconds.remainder(60).toString();

        emit(state.copyWith(
          progress: event.progress,
          duration: "$minute:$second",
        ));
      }
    });
    on<ProgressSeekEvent>((event, Emitter<PlayerState> emit) async {
      Duration duration = Duration(
          milliseconds:
              (player.duration!.inMilliseconds * event.progress).toInt());
      player.seek(duration);
    });
    on<PlayerStopEvent>((event, Emitter<PlayerState> emit) async {
      player.stop();
    });
  }
}
