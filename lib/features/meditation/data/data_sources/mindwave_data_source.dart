abstract interface class MindwaveDataSource {
  Future<String> bluetoothConnect();
  Stream<int> getRaweegData();
}
