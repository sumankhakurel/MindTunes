import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/failure.dart';
import 'package:mindtunes/core/usecase/usecase.dart';
import 'package:mindtunes/features/meditation/domain/repository/bluetooth_repository.dart';

class BluetoothConnect implements UseCase<String, NoParams> {
  final BluetoothRepository bluetoothRepository;

  BluetoothConnect(this.bluetoothRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await bluetoothRepository.connectToBluetooth();
  }
}
