import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/exceptions.dart';
import 'package:mindtunes/core/error/failure.dart';
import 'package:mindtunes/features/meditation/data/data_sources/bluetooth_data_source.dart';
import 'package:mindtunes/features/meditation/domain/repository/bluetooth_repository.dart';

class BluetoothRepositoryImpl implements BluetoothRepository {
  final BluetoothDataSource bluetoothDataSource;

  BluetoothRepositoryImpl(this.bluetoothDataSource);
  @override
  Future<Either<Failure, String>> connectToBluetooth() async {
    try {
      final result = await bluetoothDataSource.bluetoothConnect();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
