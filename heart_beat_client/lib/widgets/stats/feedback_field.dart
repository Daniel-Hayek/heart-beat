import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/widgets/common/fonts/body_text.dart';

class FeedbackField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;

  const FeedbackField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BodyText(text: label, size: 16, maxLines: 3),
        SizedBox(height: 6),
        SizedBox(
          height: 40,
          child: TextFormField(
            maxLines: null,
            keyboardType: TextInputType.number,
            textAlignVertical: TextAlignVertical.center,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ],
            controller: controller,
            style: TextStyle(fontSize: 14, color: Colors.white),
            decoration: InputDecoration(
              hint: Text("Enter a number"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: const Color(0xFFD3D3D3),
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
              ),
              contentPadding: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.03,
              ),
              filled: true,
              fillColor: AppColors.backgroundColor,
            ),
          ),
        ),
      ],
    );
  }
}
