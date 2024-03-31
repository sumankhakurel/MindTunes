import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/exceptions.dart';
import 'package:mindtunes/core/error/failure.dart';
import 'package:mindtunes/features/meditation/data/data_sources/mindwave_data_source.dart';
import 'package:mindtunes/features/meditation/domain/repository/mindwave_repository.dart';

class MindwaveRepositoryImpl implements MindwaveRepository {
  final MindwaveDataSource mindwaveDataSource;

  MindwaveRepositoryImpl(this.mindwaveDataSource);
  @override
  Future<Either<Failure, String>> connectToBluetooth() async {
    try {
      final result = await mindwaveDataSource.bluetoothConnect();
      return right(result);
    } on ServerException catch (e) {
      print(e.message);
      return left(Failure(e.message));
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
