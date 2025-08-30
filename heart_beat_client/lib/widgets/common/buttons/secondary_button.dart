import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: null,
        side: const BorderSide(color: AppColors.primaryColor, width: 1.5),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16, color: AppColors.primaryColor),
      ),
    );
  }
}
