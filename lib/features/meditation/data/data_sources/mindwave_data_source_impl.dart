// ignore_for_file: unused_import

import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_mindwave_mobile_2_plugin/flutter_mindwave_mobile_2.dart';
import 'package:mindtunes/core/error/exceptions.dart';
import 'package:mindtunes/features/meditation/data/data_sources/mindwave_data_source.dart';
import 'package:permission_handler/permission_handler.dart';

class MindwaveDataSourceImpl implements MindwaveDataSource {
  final FlutterBlue _ble;
  final FlutterMindWaveMobile2 _flutterMindWaveMobile2;
  MWMConnectionState _connectingState;
  StreamSubscription<MWMConnectionState>? _connectionSubscription;

  MindwaveDataSourceImpl(
      this._ble, this._flutterMindWaveMobile2, this._connectingState,
      [this._connectionSubscription]);

  @override
  Stream<MWMConnectionState> bluetoothConnect() async* {
    if (!await _ble.isOn) {
      throw const ServerException("Blutooth is off");
    }
    try {
      await Permission.bluetoothScan.request().isGranted;
      await Permission.bluetoothConnect.request().isGranted;
    } catch (e) {
      throw const ServerException("Blutooth Permission Denied");
    }

    if (_ble.connectedDevices.toString() == "SOUNDPEATS WATCH 1") {
      yield MWMConnectionState.connected;
    }

    try {
      final scanResults = await _ble
          .scan(timeout: const Duration(seconds: 5), withServices: []).toList();
      final scanResult = scanResults.firstWhere(
        (results) {
          return results.device.name == 'SOUNDPEATS WATCH 1';
        },
        orElse: () => throw ('Device Not Found'),
      );
      yield* _flutterMindWaveMobile2.connect(scanResult.device.id.toString());
    } catch (e) {
      print(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Stream<int> getRaweegData() async* {
    final _random = Random();

    while (true) {
      await Future.delayed(Duration(seconds: 1)); // Simulate delay
      yield _random.nextInt(100); // Generate random data
    }
  }
}


//  Future<String> bluetoothConnect() async {
//     StreamSubscription<ScanResult>? scanSubscription;
//     var found = false;
//     if (!await _ble.isOn) {
//       throw const ServerException("Blutooth is off");
//     }
//     try {
//       await Permission.bluetoothScan.request().isGranted;
//       await Permission.bluetoothConnect.request().isGranted;
//     } catch (e) {
//       throw const ServerException("Blutooth Permission Denied");
//     }

//     if (_ble.connectedDevices.toString() == "MindWave Mobile") {
//       return "Connected";
//     }

//     try {
//       scanSubscription = _ble.scan(timeout: const Duration(seconds: 5)).listen(
//           (ScanResult scanResult) {
//         var name = scanResult.device.name;
//         print(name);
//         if (name == 'MindWave Mobile') {
//           found = true;
//           print(found);
//           scanSubscription?.cancel();
//           try {
//             _connectionSubscription = _flutterMindWaveMobile2
//                 .connect(scanResult.device.id.toString())
//                 .listen((MWMConnectionState connectionState) {
//               print(connectionState);
//               print("2");

//               if (connectionState == MWMConnectionState.connected) {
//                 print("3");
//                 _connectionSubscription?.cancel();
//                 _connectingState = connectionState;
//               } else if (connectionState == MWMConnectionState.disconnected) {
//                 print("4");
//                 _connectionSubscription?.cancel();
//                 _connectingState = connectionState;
//               }
//             });
//           } catch (e) {
//             print("error");
//             print(e);
//           }
//         }
//       }, onError: (error) {
//         _connectionSubscription?.cancel();
//         _ble.stopScan();
//         scanSubscription?.cancel();
//         throw (error);
//       }, cancelOnError: true);

//       await Future.delayed(const Duration(milliseconds: 5000), () {});
//       if (!found) {
//         _connectionSubscription?.cancel();
//         scanSubscription.cancel();
//         _ble.stopScan();
//         throw ("Device Not Found");
//       } else {
//         return (_connectingState.name);
//       }
//     } catch (e) {
//       throw ServerException(e.toString());
//     }
//   }
