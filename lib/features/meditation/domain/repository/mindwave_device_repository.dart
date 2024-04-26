import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/failure.dart';

abstract interface class MindwaveDeviceRepository {
  Future<Either<Failure, String>> scantodevice();
  void disconnecttodevice();
}
