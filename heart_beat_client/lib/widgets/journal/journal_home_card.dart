import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/widgets/common/fonts/body_text.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';

class JournalHomeCard extends StatelessWidget {
  const JournalHomeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      height: 400,
      width: 160,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          TitleText(text: "Journal Entry #", size: 15),
          SizedBox(height: 8),
          TitleText(text: "dd/mm/yy", size: 15),
          SizedBox(height: 15),
          Row(children: [BodyText(text: "Jounrnal Body Text", size: 14)]),
        ],
      ),
    );
  }
}
