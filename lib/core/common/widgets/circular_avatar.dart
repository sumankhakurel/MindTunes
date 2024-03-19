import 'package:flutter/material.dart';
import 'package:mindtunes/core/theme/app_pallet.dart';

class CustomCircularAvatar extends StatelessWidget {
  final String imageurl;
  final Color boderColor;
  final Color insideColor;
  const CustomCircularAvatar(
      {super.key,
      required this.imageurl,
      required this.boderColor,
      required this.insideColor});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: boderColor,
      child: CircleAvatar(
        radius: 28,
        backgroundColor: insideColor,
        child: CircleAvatar(
          radius: 18,
          backgroundColor: AppPallete.transparentColor,
          backgroundImage: AssetImage(imageurl),
        ),
      ),
    );
  }
}
