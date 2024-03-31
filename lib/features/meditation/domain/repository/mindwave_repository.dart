import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/failure.dart';

abstract interface class MindwaveRepository {
  Future<Either<Failure, String>> connectToBluetooth();
  Stream<Either<Failure, int>> getRaweegData();
}
