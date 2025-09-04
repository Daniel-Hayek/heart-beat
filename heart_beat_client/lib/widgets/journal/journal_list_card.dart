import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/common/fonts/body_text.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';

class JournalListCard extends StatelessWidget {
  final String title;
  final DateTime date;
  final String content;

  const JournalListCard({
    super.key,
    required this.title,
    required this.content,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.viewJournal,
          arguments: {'title': title, 'date': date, 'text': content},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(14),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        width: double.infinity,
        height: 160,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText(text: title, size: 17),
                TitleText(text: "Delete", size: 11),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText(text: "Mood", size: 13),
                TitleText(text: date.toString(), size: 13),
              ],
            ),
            SizedBox(height: 10),
            BodyText(text: content, size: 13, maxLines: 4),
          ],
        ),
      ),
    );
  }
}
