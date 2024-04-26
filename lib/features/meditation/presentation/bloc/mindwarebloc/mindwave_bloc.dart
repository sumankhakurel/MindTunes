import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mindwave_mobile_2_plugin/flutter_mindwave_mobile_2.dart';

import 'package:mindtunes/core/usecase/usecase.dart';
import 'package:mindtunes/features/meditation/domain/usecases/bluetooth_connect.dart';
import 'package:mindtunes/features/meditation/domain/usecases/get_raw_eeg_data.dart';

part 'mindwave_event.dart';
part 'mindwave_state.dart';

class MindwaveBloc extends Bloc<MindwaveEvent, MindwaveState> {
  final BluetoothConnect _bluetoothConnect;
  final GetRaweegData _getRaweegData;
  MindwaveBloc({
    required BluetoothConnect bluetoothConnect,
    required GetRaweegData getRaweegData,
  })  : _bluetoothConnect = bluetoothConnect,
        _getRaweegData = getRaweegData,
        super(MindwaveInitial()) {
    on<MindwaveEvent>((_, emit) => emit(MindwaveLoading()));

    on<Bluconnect>((event, emit) async {
      _bluetoothConnect(NoParams()).listen((res) {
        res.fold(
          (l) => emit(MindwaveFailure(l.message)),
          (r) => emit(MindwaveSuccess(r)),
        );
      });
    });

    on<GetRawSignal>((event, emit) {
      final stream = _getRaweegData();
      stream.listen((data) {
        data.fold((l) => emit(MindwaveFailure(l.message)),
            (r) => emit(MindwaveDataSuccess(r)));
      });
    });
  }
}
