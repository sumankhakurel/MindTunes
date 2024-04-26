import 'package:flutter_mindwave_mobile_2_plugin/flutter_mindwave_mobile_2.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/exceptions.dart';
import 'package:mindtunes/core/error/failure.dart';
import 'package:mindtunes/features/meditation/data/data_sources/mindwave_data_source.dart';
import 'package:mindtunes/features/meditation/domain/repository/mindwave_repository.dart';

class MindwaveRepositoryImpl implements MindwaveRepository {
  final MindwaveDataSource mindwaveDataSource;

  MindwaveRepositoryImpl(this.mindwaveDataSource);
  @override
  Stream<Either<Failure, MWMConnectionState>> connectToBluetooth() async* {
    try {
      yield* mindwaveDataSource.bluetoothConnect().map((state) {
        print("State: $state");
        return Right(state);
      });
    } catch (e) {
      print("messagee: $e");
      yield left(Failure());
    }
  }

  @override
  Stream<Either<Failure, int>> getRaweegData() async* {
    try {
      final data = await mindwaveDataSource.getRaweegData();
      yield right(data as int);
    } on ServerException catch (e) {
      print(e.message);
      yield left(Failure(e.message));
    }
  }
}
