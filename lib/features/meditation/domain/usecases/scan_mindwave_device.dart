import 'package:fpdart/fpdart.dart';
import 'package:mindtunes/core/error/failure.dart';
import 'package:mindtunes/core/usecase/usecase.dart';
import 'package:mindtunes/features/meditation/domain/repository/mindwave_device_repository.dart';

class ScanMindwaveDevice implements UseCase<String, NoParams> {
  final MindwaveDeviceRepository mindwaveDeviceRepository;

  ScanMindwaveDevice(this.mindwaveDeviceRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return mindwaveDeviceRepository.scantodevice();
  }
}
