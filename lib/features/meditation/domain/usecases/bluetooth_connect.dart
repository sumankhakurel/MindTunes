import 'package:flutter_mindwave_mobile_2_plugin/flutter_mindwave_mobile_2.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/failure.dart';
import 'package:mindtunes/core/usecase/usecase.dart';
import 'package:mindtunes/features/meditation/domain/repository/mindwave_repository.dart';

class BluetoothConnect {
  final MindwaveRepository bluetoothRepository;

  BluetoothConnect(this.bluetoothRepository);

  Stream<Either<Failure, MWMConnectionState>> call(NoParams params) {
    return bluetoothRepository.connectToBluetooth();
  }
}
