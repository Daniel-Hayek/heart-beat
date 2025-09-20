import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/repositories/journal_repository.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/auth/auth_snack_bar.dart';
import 'package:heart_beat_client/widgets/common/fonts/body_text.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:provider/provider.dart';

class JournalListCard extends StatefulWidget {
  final int id;
  final String title;
  final String date;
  final String content;
  final String moods;
  final VoidCallback onDelete;

  const JournalListCard({
    super.key,
    required this.id,
    required this.title,
    required this.moods,
    required this.content,
    required this.date,
    required this.onDelete,
  });

  @override
  State<JournalListCard> createState() => _JournalListCardState();
}

class _JournalListCardState extends State<JournalListCard> {
  final journalRepo = JournalRepository();

  void deleteCard() async {
    try {
      final authProvider = context.read<AuthProvider>();

      journalRepo.deleteJournals(
        token: authProvider.token!,
        journalId: widget.id,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        AuthSnackBar(content: Text("Journal entry deleted successfully")),
      );

      widget.onDelete();
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
        height: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText(text: widget.title, size: 17),
                TextButton(
                  onPressed: deleteCard,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontFamily: 'nunito',
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText(text: widget.moods, size: 12),
                TitleText(text: widget.date.toString(), size: 9),
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
