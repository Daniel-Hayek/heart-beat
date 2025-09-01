import 'package:flutter/material.dart';
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
        BodyText(text: label, size: 16, maxLines: null),
        SizedBox(height: 6),
        SizedBox(
          height: 140,
          child: TextFormField(
            maxLines: null,
            expands: true,
            keyboardType: TextInputType.multiline,
            textAlignVertical: TextAlignVertical.top,
            controller: controller,
            style: TextStyle(fontSize: 14, color: Colors.white),
            decoration: InputDecoration(
              hint: Text("What are your thoughts..."),
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
