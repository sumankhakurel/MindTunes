import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/exceptions.dart';
import 'package:mindtunes/core/error/failure.dart';
import 'package:mindtunes/features/meditation/data/data_sources/mindwave_device_data_source.dart';
import 'package:mindtunes/features/meditation/domain/repository/mindwave_device_repository.dart';

class MindwaveDeviceRepositoryImpl implements MindwaveDeviceRepository {
  final MindwaveDeviceDataSource mindwaveDeviceDataSource;

  MindwaveDeviceRepositoryImpl(this.mindwaveDeviceDataSource);
  @override
  Future<Either<Failure, String>> scantodevice() async {
    try {
      final deviceId = await mindwaveDeviceDataSource.scantodevice();
      return right(deviceId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  void disconnecttodevice() {
    mindwaveDeviceDataSource.disconnecttodevice();
  }
}
