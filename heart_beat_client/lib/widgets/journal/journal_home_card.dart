import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/widgets/common/fonts/body_text.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';

class JournalHomeCard extends StatelessWidget {
  final String prompt;

  const JournalHomeCard({
    super.key,
    this.prompt =
        "Talk about your experience today, whether at work, school or at home. How did it make you feel?",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      height: 360,
      width: 160,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          TitleText(text: "Journal Prompt", size: 15),
          SizedBox(height: 8),
          SizedBox(height: 15),
          BodyText(text: prompt, size: 13, maxLines: 10),
        ],
      ),
    );
  }
}
