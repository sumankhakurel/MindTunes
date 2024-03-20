import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mindtunes/features/meditation/data/data_sources/bluetooth_data_source.dart';
import 'package:mindtunes/features/meditation/utils/flutter_mindwave_mobile_2.dart';

class BluetoothDataSourceImpl implements BluetoothDataSource {
  final FlutterBlue flutterBlue;
  final FlutterMindWaveMobile2 flutterMindWaveMobile2;

  late StreamSubscription<ScanResult> _scanSubscription;
  late StreamSubscription<MWMConnectionState> _connectionSubscription;

  BluetoothDataSourceImpl(
    this.flutterBlue,
    this.flutterMindWaveMobile2,
  );

  // @override
  // Future<String> bluetoothConnect() async {
  //   try {
  //     var found = false;
  //     print("Scan Start");
  //     _scanSubscription = flutterBlue.scan().listen((scanResult) {
  //       var name = scanResult.device.name;
  //       if (name == 'MindWave Mobile') {
  //         found = true;
  //         _scanSubscription.cancel();
  //       }
  //     }, onError: (error) {
  //       _connectionSubscription.cancel();
  //       print("Is bluetooth on?");
  //       throw ServerException("Bluetooth is off");
  //     }, cancelOnError: true);

  //     // Cancel scan after 5 seconds
  //     await Future.delayed(const Duration(seconds: 5));

  //     // Check if the device is found
  //     if (!found) {
  //       _scanSubscription.cancel();
  //       _connectionSubscription.cancel();
  //       print("Unable to find MindWave Mobile");
  //       throw ServerException("Unable to find MindWave Mobile");
  //     } else {
  //       return "Success"; // Return "Success" if the device is found
  //     }
  //   } catch (e) {
  //     throw ServerException("Error occurred during Bluetooth scanning: $e");
  //   }
  // }
  @override
  Future<String> bluetoothConnect() async {
    try {
      PermissionStatus permissionStatus = await Permission.location.status;
      if (permissionStatus != PermissionStatus.granted) {
        // Request location permissions
        PermissionStatus newStatus = await Permission.location.request();
        if (newStatus != PermissionStatus.granted) {
          print('Location permissions not granted.');
        } else {
          print("Granted");
        }
      } else {
        print("Granted");
      }

      return ("Sucess");
    } catch (e) {
      print("Error occurred: $e");

      return ("Error");
    }
  }
}
