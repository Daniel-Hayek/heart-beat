import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/widgets/common/fonts/body_text.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';

class JournalListCard extends StatelessWidget {
  const JournalListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.secondaryColor),
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      width: 300,
      height: 160,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleText(text: "Title", size: 16),
              TitleText(text: "Delete", size: 12),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleText(text: "Mood", size: 16),
              TitleText(text: "dd/mm/yy", size: 16),
            ],
          ),
          BodyText(text: "Journal Text", size: 13),
        ],
      ),
    );
  }
}
