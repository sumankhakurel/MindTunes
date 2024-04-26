part of 'mindwavedevice_bloc.dart';

@immutable
sealed class MindwavedeviceEvent {}

final class MindwavedeviceScanEvent extends MindwavedeviceEvent {}

final class MindwavedeviceConnectEvent extends MindwavedeviceEvent {
  final String status;

  MindwavedeviceConnectEvent(this.status);
}

final class MindwavedeviceDisconnectEvent extends MindwavedeviceEvent {}
