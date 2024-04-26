import 'package:flutter_mindwave_mobile_2_plugin/flutter_mindwave_mobile_2.dart';

abstract interface class MindwaveDataSource {
  Stream<MWMConnectionState> bluetoothConnect();
  Stream<int> getRaweegData();
}
