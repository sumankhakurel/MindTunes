import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mindtunes/core/usecase/usecase.dart';

import 'package:mindtunes/features/meditation/domain/entities/music.dart';
import 'package:mindtunes/features/meditation/domain/usecases/get_music.dart';

part 'firebase_event.dart';
part 'firebase_state.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState> {
  final GetMusic _getMusic;
  FirebaseBloc({
    required GetMusic getMusic,
  })  : _getMusic = getMusic,
        super(FirebaseInitial()) {
    on<FirebaseEvent>((_, emit) => emit(FirebaseLoading()));
    on<FirebaseGetMusic>((event, emit) async {
      final res = await _getMusic(NoParams());
      res.fold((l) => emit(FirebaseFailure(l.message)),
          (r) => emit(FirebaseSucess(r)));
    });
  }
}
