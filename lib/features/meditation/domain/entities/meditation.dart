class Meditation {
  final int minAttentation;
  final int maxAttentation;
  final double avgAttentation;
  final int minMeditation;
  final int maxMeditation;
  final double avgMeditation;
  final DateTime starttime;
  final DateTime endtime;
  final double duration;

  Meditation({
    required this.minAttentation,
    required this.maxAttentation,
    required this.avgAttentation,
    required this.minMeditation,
    required this.maxMeditation,
    required this.avgMeditation,
    required this.starttime,
    required this.endtime,
    required this.duration,
  });
}
