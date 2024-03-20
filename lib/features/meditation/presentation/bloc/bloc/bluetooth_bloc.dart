import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtunes/core/usecase/usecase.dart';
import 'package:mindtunes/features/meditation/domain/usecases/bluetooth_connect.dart';

part 'bluetooth_event.dart';
part 'bluetooth_state.dart';

class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothState> {
  final BluetoothConnect _bluetoothConnect;
  BluetoothBloc({
    required BluetoothConnect bluetoothConnect,
  })  : _bluetoothConnect = bluetoothConnect,
        super(BluetoothInitial()) {
    on<BluetoothEvent>((_, emit) => emit(BluetoothLoading()));
    on<Bluconnect>((event, emit) async {
      final res = await _bluetoothConnect(NoParams());
      res.fold((l) => emit(BluetoothFailure(l.message)),
          (r) => emit(BluetoothSucess(r)));
    });
  }
}
