import 'package:mindtunes/features/meditation/domain/repository/mindwave_device_repository.dart';

class MindwaveDeviceDisconnect {
  final MindwaveDeviceRepository mindwaveDeviceRepository;

  MindwaveDeviceDisconnect(this.mindwaveDeviceRepository);
  void call() {
    mindwaveDeviceRepository.disconnecttodevice();
  }
}
