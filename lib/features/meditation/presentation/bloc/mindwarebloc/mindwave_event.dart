part of 'mindwave_bloc.dart';

@immutable
sealed class MindwaveEvent {}

final class Bluconnect extends MindwaveEvent {}

final class GetRawSignal extends MindwaveEvent {}
