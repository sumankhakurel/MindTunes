import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mindwave_mobile_2_plugin/flutter_mindwave_mobile_2.dart';
import 'package:logger/logger.dart';
import 'package:mindtunes/core/usecase/usecase.dart';
import 'package:mindtunes/features/meditation/domain/usecases/mindwave_device_disconnect.dart';
import 'package:mindtunes/features/meditation/domain/usecases/scan_mindwave_device.dart';

part 'mindwavedevice_event.dart';
part 'mindwavedevice_state.dart';

class MindwavedeviceBloc
    extends Bloc<MindwavedeviceEvent, MindwavedeviceState> {
  FlutterMindWaveMobile2 flutterMindWaveMobile2 = FlutterMindWaveMobile2();
  final ScanMindwaveDevice _mindwaveDevice;
  final MindwaveDeviceDisconnect _deviceDisconnect;
  late StreamSubscription<MWMConnectionState>? _connectionSubscription;

  MindwavedeviceBloc({
    required ScanMindwaveDevice mindwaveDevice,
    required MindwaveDeviceDisconnect mindwaveDeviceDisconnect,
  })  : _mindwaveDevice = mindwaveDevice,
        _deviceDisconnect = mindwaveDeviceDisconnect,
        super(MindwavedeviceInitial()) {
    on<MindwavedeviceEvent>((_, emit) => emit(MindwavedeviceLoadingState()));

    on<MindwavedeviceScanEvent>(((event, emit) async {
      final res = await _mindwaveDevice(NoParams());
      res.fold(
        (l) => emit(MindwavedeviceScanFail(l.message)),
        (r) => _setupListener(r),
      );
    }));

    on<MindwavedeviceConnectEvent>((event, emit) {
      if (event.status == "Disconnected") {
        emit(MindwavedeviceInitial());
      } else {
        Stream attentation = flutterMindWaveMobile2.onAttention();
        Stream signal = flutterMindWaveMobile2.onSignalQuality();
        Stream meditation = flutterMindWaveMobile2.onMeditation();
        Stream bandpower = flutterMindWaveMobile2.onBandPower();
        emit(MindwavedeviceSucess().copywith(
          status: event.status,
          attdata: attentation,
          signal: signal,
          meddata: meditation,
          bandpower: bandpower,
        ));
      }
    });

    on<MindwavedeviceDisconnectEvent>(
      (event, emit) => _deviceDisconnect(),
    );
  }
  @override
  Future<void> close() {
    _connectionSubscription?.cancel();
    _deviceDisconnect();
    return super.close();
  }

  void _setupListener(String deviceid) {
    String status;
    _connectionSubscription = flutterMindWaveMobile2
        .connect(deviceid)
        .takeWhile((event) => event.name != "disconnect")
        .listen((MWMConnectionState connectionState) {
      Logger().d(connectionState);
      if (connectionState.name == "connected") {
        status = "Connected";
      } else if (connectionState.name == "disconnected") {
        status = "Disconnected";
      } else if (connectionState.name == "connecting") {
        status = "Connecting";
      } else {
        status = "Disconnected";
      }

      add(MindwavedeviceConnectEvent(status));
    });
  }
}
