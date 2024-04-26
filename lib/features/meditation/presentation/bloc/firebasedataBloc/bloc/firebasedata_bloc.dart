import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mindtunes/core/usecase/usecase.dart';

import 'package:mindtunes/features/meditation/domain/entities/meditation.dart';
import 'package:mindtunes/features/meditation/domain/usecases/get_meditation_history.dart';

part 'firebasedata_event.dart';
part 'firebasedata_state.dart';

class FirebasedataBloc extends Bloc<FirebasedataEvent, FirebasedataState> {
  final GetMeditationHistory _getMeditationHistory;
  FirebasedataBloc({
    required GetMeditationHistory getMeditationHistory,
  })  : _getMeditationHistory = getMeditationHistory,
        super(FirebasedataInitial()) {
    on<FirebasedataEvent>((_, emit) => emit(FirebasedataLoading()));

    on<Firebasedatagetevent>((event, emit) async {
      late double totalMinute = 0;
      late int totalSession;
      final res = await _getMeditationHistory(NoParams());
      res.fold((l) => emit(FirebasedataFailure(l.message)), (r) {
        totalSession = r.length;
        for (Meditation data in r) {
          totalMinute = totalMinute + data.duration;
        }
        emit(FirebasedataSucess(r, totalMinute, totalSession));
      });
    });
  }
}
