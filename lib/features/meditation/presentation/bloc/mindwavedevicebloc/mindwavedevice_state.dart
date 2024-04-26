part of 'mindwavedevice_bloc.dart';

@immutable
sealed class MindwavedeviceState {}

final class MindwavedeviceInitial extends MindwavedeviceState {}

final class MindwavedeviceLoadingState extends MindwavedeviceState {}

final class MindwavedeviceSucess extends MindwavedeviceState {
  final String status;
  final Stream<dynamic>? attdata;
  final Stream<dynamic>? signal;
  final Stream<dynamic>? meddata;
  final Stream<dynamic>? bandpower;

  MindwavedeviceSucess(
      {this.status = "Disconnect",
      this.attdata,
      this.signal,
      this.meddata,
      this.bandpower});

  MindwavedeviceSucess copywith(
      {String? status,
      Stream<dynamic>? attdata,
      Stream<dynamic>? meddata,
      Stream<dynamic>? bandpower,
      Stream<dynamic>? signal}) {
    return MindwavedeviceSucess(
      attdata: attdata ?? this.attdata,
      status: status ?? this.status,
      signal: signal ?? this.signal,
      meddata: meddata ?? this.meddata,
      bandpower: bandpower ?? this.bandpower,
    );
  }
}

final class MindwavedeviceScanFail extends MindwavedeviceState {
  final String message;

  MindwavedeviceScanFail(this.message);
}
