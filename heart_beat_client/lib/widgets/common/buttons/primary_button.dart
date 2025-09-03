import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: AppColors.primaryColor,
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      ),
    );
  }
}
