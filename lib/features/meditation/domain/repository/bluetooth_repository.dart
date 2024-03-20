import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/failure.dart';

abstract interface class BluetoothRepository {
  Future<Either<Failure, String>> connectToBluetooth();
}
