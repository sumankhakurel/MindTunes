part of 'meditation_bloc.dart';

@immutable
sealed class MeditationEvent {}

final class MeditationUpdateEvent extends MeditationEvent {
  final int minAttentation;
  final int maxAttentation;
  final double avgAttentation;
  final int minMeditation;
  final int maxMeditation;
  final double avgMeditation;

  MeditationUpdateEvent(
      {required this.minAttentation,
      required this.maxAttentation,
      required this.avgAttentation,
      required this.minMeditation,
      required this.maxMeditation,
      required this.avgMeditation});
}

final class MeditationStartEvent extends MeditationEvent {}

final class MeditationEndEvent extends MeditationEvent {}
