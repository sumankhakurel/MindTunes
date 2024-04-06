import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_mindwave_mobile_2_plugin/flutter_mindwave_mobile_2.dart';

class TestWeidget extends StatefulWidget {
  const TestWeidget({super.key});

  @override
  State<TestWeidget> createState() => _TestWeidgetState();
}

class _TestWeidgetState extends State<TestWeidget> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  FlutterMindWaveMobile2 flutterMindWaveMobile2 = FlutterMindWaveMobile2();

  MWMConnectionState _connectingState = MWMConnectionState.disconnected;
  late StreamSubscription<ScanResult> _scanSubscription;
  late StreamSubscription<MWMConnectionState> _connectionSubscription;
  @override
  Widget build(BuildContext context) {
    String connectionStatusText = "Disconnected";
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(connectionStatusText),
            ElevatedButton(
                onPressed: () {
                  _connect();
                },
                child: Text("Connect")),
          ],
        ),
      ),
    );
  }

  void _connect() {}
}
