import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/core/constants/sample_text.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/common/fonts/body_text.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';

class JournalListCard extends StatelessWidget {
  const JournalListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.viewJournal,
          arguments: {
            'title': "Title",
            'date': 'dd/mm/yy',
            'text': SampleText.sampleText,
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(color: AppColors.secondaryColor),
        padding: EdgeInsets.all(14),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        width: double.infinity,
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
            SizedBox(height: 10),
            BodyText(text: SampleText.sampleText, size: 13, maxLines: 4),
          ],
        ),
      ),
    );
  }
}
