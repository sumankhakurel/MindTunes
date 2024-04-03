import 'package:flutter/material.dart';

class MeditationLive extends StatelessWidget {
  final String title;
  const MeditationLive({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text(title)),
    );
  }
}
