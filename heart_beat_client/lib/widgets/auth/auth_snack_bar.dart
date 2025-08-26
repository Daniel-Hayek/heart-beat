import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';

class AuthSnackBar extends SnackBar {
  AuthSnackBar({Key? key, required Widget content})
    : super(
        key: key,
        content: content,
        backgroundColor: AppColors.secondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(8),
        duration: const Duration(seconds: 3),
      );
}
