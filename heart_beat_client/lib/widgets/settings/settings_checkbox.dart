import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';

class SettingsCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const SettingsCheckbox({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: TitleText(text: label, size: 18),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: AppColors.primaryColor,
    );
  }
}
