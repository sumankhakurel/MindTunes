import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mindtunes/features/meditation/data/models/meditation_model.dart';
import 'package:mindtunes/features/meditation/domain/usecases/update_meditation_session.dart';

part 'meditation_event.dart';
part 'meditation_state.dart';

class MeditationBloc extends Bloc<MeditationEvent, MeditationState> {
  final UpdateMeditationSession _meditationSession;
  MeditationBloc({
    required UpdateMeditationSession meditationSession,
  })  : _meditationSession = meditationSession,
        super(MeditationInitial()) {
    on<MeditationEvent>((event, emit) {});
    on<MeditationUpdateEvent>((event, emit) {
      emit(state.copywith(
        avgAttentation: event.avgAttentation,
        avgMeditation: event.avgMeditation,
        maxAttentation: event.maxAttentation,
        maxMeditation: event.maxMeditation,
        minAttentation: event.minAttentation,
        minMeditation: event.minMeditation,
      ));
    });

    on<MeditationStartEvent>((event, emit) {
      emit(state.copywith(starttime: DateTime.now()));
    });

    on<MeditationEndEvent>((event, emit) {
      Duration difference = DateTime.now().difference(state.starttime!);
      double minute = difference.inSeconds / 60;
      if (minute > 0.1) {
        final meditationModel = MeditationModel(
          minAttentation: state.minAttentation,
          maxAttentation: state.maxAttentation,
          avgAttentation: state.avgAttentation,
          maxMeditation: state.minMeditation,
          minMeditation: state.maxMeditation,
          avgMeditation: state.avgMeditation,
          starttime: state.starttime!,
          endtime: DateTime.now(),
          duration: minute,
        );

        _meditationSession.call(meditationModel);
      }
      print("sasasssssssssssssssssssssssssssss");
      emit(state.copywith(
        avgAttentation: 0,
        avgMeditation: 0,
        maxAttentation: 0,
        maxMeditation: 0,
        minAttentation: 0,
        minMeditation: 0,
      ));
    });
  }
}
