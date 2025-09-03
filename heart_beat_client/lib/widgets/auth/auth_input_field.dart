import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';

class AuthInputField extends StatelessWidget {
  final String label;
  final bool isPass;
  final String placeholder;
  final TextEditingController controller;

  const AuthInputField({
    super.key,
    required this.label,
    required this.isPass,
    required this.placeholder,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'montserrat',
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: isPass,
          controller: controller,
          style: const TextStyle(color: AppColors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            hintText: placeholder,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 12,
            ),
          ),
        ),
      ],
    );
  }
}
