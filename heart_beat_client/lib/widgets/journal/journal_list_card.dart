import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/widgets/common/fonts/body_text.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';

class JournalListCard extends StatelessWidget {
  const JournalListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: AppColors.secondaryColor),
        padding: EdgeInsets.all(14),
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        width: 320,
        height: 160,
        child: Column(
          children: [
            Row(
              children: [
                TitleText(text: "Title", size: 16),
                TitleText(text: "Delete", size: 12),
              ],
            ),
            Row(
              children: [
                TitleText(text: "Mood", size: 16),
                TitleText(text: "dd/mm/yy", size: 16),
              ],
            ),
            BodyText(text: "Journal Text", size: 13),
          ],
        ),
      ),
    );
  }
}
