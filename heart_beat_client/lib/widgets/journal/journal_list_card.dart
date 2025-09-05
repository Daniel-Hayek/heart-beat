import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/repositories/journal_repository.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/common/buttons/tertiary_button.dart';
import 'package:heart_beat_client/widgets/common/fonts/body_text.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:provider/provider.dart';

class JournalListCard extends StatefulWidget {
  final int id;
  final String title;
  final String date;
  final String content;

  const JournalListCard({
    super.key,
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  @override
  State<JournalListCard> createState() => _JournalListCardState();
}

class _JournalListCardState extends State<JournalListCard> {
  final journalRepo = JournalRepository();

  void deleteCard() async {
    try {
      final authProvider = context.watch<AuthProvider>();

      journalRepo.deleteJournals(
        token: authProvider.token!,
        journalId: widget.id,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.viewJournal,
          arguments: {
            'title': widget.title,
            'date': widget.date,
            'text': widget.content,
          },
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText(text: widget.title, size: 17),
                TertiaryButton(onPressed: () {}, label: "Delete"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText(text: "Mood", size: 13),
                TitleText(text: widget.date.toString(), size: 13),
              ],
            ),
            SizedBox(height: 10),
            BodyText(text: widget.content, size: 13, maxLines: 4),
          ],
        ),
      ),
    );
  }
}
