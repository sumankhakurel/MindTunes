abstract interface class MindwaveDeviceDataSource {
  Future<String> scantodevice();

  void disconnecttodevice() {}
}
