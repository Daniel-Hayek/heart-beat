import 'package:flutter/material.dart';

class AuthInputField extends StatelessWidget {
  final String label;
  final bool isPass;
  final String placeholder;

  const AuthInputField({super.key, required this.label, required this.isPass, required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        hintText: placeholder,
      ),
    );
  }
}
