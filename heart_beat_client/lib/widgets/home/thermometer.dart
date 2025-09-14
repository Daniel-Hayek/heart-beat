import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';

class Thermometer extends StatelessWidget {
  final double value;

  const Thermometer({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 180,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          heightFactor: value / 10,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
            ),
          ),
        ),
      ),
    );
  }
}
