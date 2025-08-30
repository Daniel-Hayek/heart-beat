import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/common/buttons/tertiary_button.dart';

class SwapAuth extends StatelessWidget {
  final String text;
  final String buttonLabel;
  final VoidCallback onPressed;

  const SwapAuth({super.key, required this.text, required this.buttonLabel, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        TertiaryButton(onPressed: onPressed, label: buttonLabel),
      ],
    );
  }
}
