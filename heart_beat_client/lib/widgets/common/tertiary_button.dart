import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';

class TertiaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const TertiaryButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.primaryColor,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.primaryColor,
        ),
      ),
    );
  }
}
