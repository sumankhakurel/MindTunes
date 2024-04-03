import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final bool isObsecuteText;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  final TextInputAction action;
  final Icon icon;
  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObsecuteText = false,
    required this.action,
    required this.icon,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: action,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        labelText: hintText,
        prefixIcon: icon,
      ),
      validator: validator,
      obscureText: isObsecuteText,
    );
  }
}
