import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final bool isObsecuteText;
  final TextEditingController controller;
  final TextInputAction action;
  final Icon icon;
  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObsecuteText = false,
    required this.action,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: action,
      decoration: InputDecoration(
        labelText: hintText,
        prefixIcon: icon,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
      obscureText: isObsecuteText,
    );
  }
}
