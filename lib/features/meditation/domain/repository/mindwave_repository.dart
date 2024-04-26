import 'package:flutter_mindwave_mobile_2_plugin/flutter_mindwave_mobile_2.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/failure.dart';

abstract interface class MindwaveRepository {
  Stream<Either<Failure, MWMConnectionState>> connectToBluetooth();
  Stream<Either<Failure, int>> getRaweegData();
}
