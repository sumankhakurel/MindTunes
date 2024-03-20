part of 'bluetooth_bloc.dart';

@immutable
sealed class BluetoothState {}

final class BluetoothInitial extends BluetoothState {}

final class BluetoothLoading extends BluetoothState {}

final class BluetoothSucess extends BluetoothState {
  final String message;

  BluetoothSucess(this.message);
}

final class BluetoothFailure extends BluetoothState {
  final String message;

  BluetoothFailure(this.message);
}
