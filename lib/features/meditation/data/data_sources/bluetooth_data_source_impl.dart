import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:mindtunes/core/error/exceptions.dart';
import 'package:mindtunes/features/meditation/data/data_sources/bluetooth_data_source.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothDataSourceImpl implements BluetoothDataSource {
  final FlutterBlue _ble;

  BluetoothDataSourceImpl(this._ble);

  @override
  Future<String> bluetoothConnect() async {
    late StreamSubscription<ScanResult> scanSubscription;
    var found = false;
    try {
      if (await _ble.isOn) {
        if (await Permission.bluetoothScan.request().isGranted) {
          if (await Permission.bluetoothConnect.request().isGranted) {
            scanSubscription = _ble
                .scan(timeout: const Duration(seconds: 5))
                .listen((ScanResult scanResult) {
              var name = scanResult.device.name;

              if (name == 'MindWave Mobile') {
                found = true;
                scanSubscription.cancel();
                _ble.stopScan;
              }
            }, onError: (error) {
              throw (error);
            }, cancelOnError: true);
          }
        }

        _ble.stopScan();
      } else {
        throw ("Bluetooth is off");
      }

      String re = await Future.delayed(
        const Duration(milliseconds: 5010),
        () {
          if (found) {
            return ("Sucess");
          } else {
            throw ("Device not found");
          }
        },
      );

      return (re);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
