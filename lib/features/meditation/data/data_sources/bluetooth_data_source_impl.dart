import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:mindtunes/core/error/exceptions.dart';
import 'package:mindtunes/features/meditation/data/data_sources/bluetooth_data_source.dart';
import 'package:mindtunes/features/meditation/utils/flutter_mindwave_mobile_2.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothDataSourceImpl implements BluetoothDataSource {
  final FlutterBlue _ble;
  final FlutterMindWaveMobile2 flutterMindWaveMobile2;
  MWMConnectionState _connectingState;
  BluetoothDataSourceImpl(
      this._ble, this.flutterMindWaveMobile2, this._connectingState);

  @override
  Future<String> bluetoothConnect() async {
    late StreamSubscription<MWMConnectionState> connectionSubscription;
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
              print(name);
              if (name == 'MindWave Mobile') {
                found = true;
                scanSubscription.cancel();
                _ble.stopScan;

                connectionSubscription = flutterMindWaveMobile2
                    .connect(scanResult.device.id.toString())
                    .listen((MWMConnectionState connectionState) {
                  if (connectionState == MWMConnectionState.connected) {
                    _connectingState = connectionState;
                  } else if (connectionState ==
                      MWMConnectionState.disconnected) {
                    connectionSubscription.cancel();
                    _connectingState = MWMConnectionState.disconnected;
                  }
                });

                //connect if device is found
              }
            }, onError: (error) {
              _connectingState = MWMConnectionState.disconnected;
              print(_connectingState);

              throw (error);
            }, cancelOnError: true);
          }
        }

        _ble.stopScan();
      } else {
        throw ("Bluetooth is off");
      }

      String re = await Future.delayed(
        const Duration(milliseconds: 6000),
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
