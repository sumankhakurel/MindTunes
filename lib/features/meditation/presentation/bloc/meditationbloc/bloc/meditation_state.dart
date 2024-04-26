part of 'meditation_bloc.dart';

class MeditationState {
  final int minAttentation;
  final int maxAttentation;
  final double avgAttentation;
  final int minMeditation;
  final int maxMeditation;
  final double avgMeditation;
  final DateTime? starttime;
  final DateTime? endtime;

  MeditationState(
      {this.starttime,
      this.endtime,
      this.minAttentation = 0,
      this.maxAttentation = 0,
      this.avgAttentation = 0,
      this.minMeditation = 0,
      this.maxMeditation = 0,
      this.avgMeditation = 0});

  MeditationState copywith({
    int? minAttentation,
    int? maxAttentation,
    double? avgAttentation,
    int? minMeditation,
    int? maxMeditation,
    double? avgMeditation,
    DateTime? starttime,
    DateTime? endtime,
  }) {
    return MeditationState(
      minAttentation: minAttentation ?? this.minAttentation,
      avgAttentation: avgAttentation ?? this.avgMeditation,
      maxAttentation: maxAttentation ?? this.maxAttentation,
      minMeditation: minMeditation ?? this.minMeditation,
      avgMeditation: avgMeditation ?? this.avgMeditation,
      maxMeditation: maxMeditation ?? this.maxMeditation,
      starttime: starttime ?? this.starttime,
      endtime: endtime ?? this.endtime,
    );
  }
}

final class MeditationInitial extends MeditationState {
  MeditationInitial();
}
