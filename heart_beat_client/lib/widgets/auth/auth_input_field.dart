import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';

class AuthInputField extends StatelessWidget {
  final String label;
  final bool isPass;
  final String placeholder;

  const AuthInputField({
    super.key,
    required this.label,
    required this.isPass,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPass,
      style: const TextStyle(color: AppColors.black),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        hintText: placeholder,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
    );
  }
}
