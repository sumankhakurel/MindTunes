import 'dart:async';

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
                  if (_connectingState.name == "connected") {
                    _disconnect();
                  } else {
                    _connect();
                  }
                },
                child: Text(_connectingState.name)),
            Expanded(
              child: Column(
                children: <Widget>[
                  _header("Algo State and Reason"),
                  _algoStateAndReasonStreamBuilder(),
                  Spacer(),
                  _header("Attention (Att)"),
                  _dataStreamBuilder(
                      "Attention", flutterMindWaveMobile2.onAttention()),
                  Spacer(),
                  _header("Band Power (BP)"),
                  _bandPowerStreamBuilder(),
                  Spacer(),
                  _header("Eye Blink (Blink)"),
                  _dataStreamBuilder(
                      "Eye Blink", flutterMindWaveMobile2.onEyeBlink()),
                  Spacer(),
                  _header("Meditation (Med)"),
                  _dataStreamBuilder(
                      "Meditation", flutterMindWaveMobile2.onMeditation()),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _disconnect() {
    flutterMindWaveMobile2.disconnect();
  }

  void _connect() {
    setState(() {
      _connectingState = MWMConnectionState.scanning;
    });
    var found = false;

    _scanSubscription = flutterBlue.scan().listen((ScanResult scanResult) {
      var name = scanResult.device.name;

      if (name == 'SOUNDPEATS WATCH 1') {
        found = true;
        print(found);
        _scanSubscription.cancel();
        flutterBlue.stopScan();
        try {
          setState(() {
            _connectingState = MWMConnectionState.connecting;
          });
          _connectionSubscription = flutterMindWaveMobile2
              .connect(scanResult.device.id.toString())
              .listen((MWMConnectionState connectionState) {
            if (connectionState == MWMConnectionState.connected) {
              print(1);
              setState(() {
                _connectingState = connectionState;
              });
            } else if (connectionState == MWMConnectionState.disconnected) {
              print(2);
              _connectionSubscription.cancel();

              setState(() {
                _connectingState = MWMConnectionState.disconnected;
              });
            }
          });
        } catch (e) {
          print("error");
          print(e);
        }
      }
    }, onError: (error) {
      print("error Occur: $error");
      _connectionSubscription.cancel();
      setState(() {
        _connectingState = MWMConnectionState.disconnected;
      });
    }, cancelOnError: true);
    Future.delayed(const Duration(milliseconds: 5000), () {
      if (!found) {
        flutterBlue.stopScan();
        _scanSubscription.cancel();
        _connectionSubscription.cancel();
        setState(() {
          _connectingState = MWMConnectionState.disconnected;
        });
      }
    });
  }

  Widget _algoStateAndReasonStreamBuilder() {
    return StreamBuilder(
      stream: flutterMindWaveMobile2.onAlgoStateAndReason(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var algoStateAndReason = snapshot.data as AlgoStateAndReason;
          return Column(
            children: <Widget>[
              _value(
                  "state: ${algoStateAndReason.state.toString().split('.').last}"),
              _value(
                  "reason: ${algoStateAndReason.reason.toString().split('.').last}"),
            ],
          );
        }
        return Column(
          children: <Widget>[
            _value("state: N/A"),
            _value("reason: N/A"),
          ],
        );
      },
    );
  }

  Widget _dataStreamBuilder(String title, Stream stream) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _value("$title: ${snapshot.data.toString()}");
        }
        return _value("$title: N/A");
      },
    );
  }

  Widget _bandPowerStreamBuilder() {
    return StreamBuilder(
      stream: flutterMindWaveMobile2.onBandPower(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var bandPower = snapshot.data as BandPower;
          return Column(
            children: <Widget>[
              _value("delta: ${bandPower.delta.toString()} dB"),
              _value("theta: ${bandPower.theta.toString()} dB"),
              _value("alpha: ${bandPower.alpha.toString()} dB"),
              _value("beta: ${bandPower.beta.toString()} dB"),
              _value("gamma: ${bandPower.gamma.toString()} dB"),
            ],
          );
        }
        return Column(
          children: <Widget>[
            _value("delta: N/A"),
            _value("theta: N/A"),
            _value("alpha: N/A"),
            _value("beta: N/A"),
            _value("gamma: N/A"),
          ],
        );
      },
    );
  }

  Widget _header(String text) {
    return Text(text,
        style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold));
  }

  Widget _value(String text) {
    return Text(text, style: TextStyle(fontSize: 16.0));
  }
}
