import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_mindwave_mobile_2_plugin/flutter_mindwave_mobile_2.dart';
import 'package:mindtunes/core/error/exceptions.dart';
import 'package:mindtunes/features/meditation/data/data_sources/mindwave_device_data_source.dart';
import 'package:permission_handler/permission_handler.dart';

class MindwaveDeviceDataSourceImpl implements MindwaveDeviceDataSource {
  final FlutterBlue _ble;
  FlutterMindWaveMobile2 flutterMindWaveMobile2 = FlutterMindWaveMobile2();
  MindwaveDeviceDataSourceImpl(this._ble);
  @override
  Future<String> scantodevice() async {
    try {
      if (!await _ble.isOn) {
        throw "Blutooth is off";
      }
      try {
        await Permission.storage.request();
        await Permission.bluetoothScan.request().isGranted;
        await Permission.bluetoothConnect.request().isGranted;
      } catch (e) {
        throw "Blutooth Permission Denied";
      }
      final scanResults = await _ble
          .scan(timeout: const Duration(seconds: 5), withServices: []).toList();
      final scanResult = scanResults.firstWhere(
        (results) {
          return results.device.name == 'MindWave Mobile';
        },
        orElse: () => throw ('Device Not Found'),
      );
      return scanResult.device.id.toString();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  void disconnecttodevice() {
    flutterMindWaveMobile2.disconnect();
  }
}
