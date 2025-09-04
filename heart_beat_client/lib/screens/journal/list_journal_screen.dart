import 'package:flutter/material.dart';
import 'package:heart_beat_client/models/journal.dart';
import 'package:heart_beat_client/widgets/common/bars/simple_app_bar.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:heart_beat_client/widgets/journal/journal_list_card.dart';

class ListJournalScreen extends StatelessWidget {
  final List<Journal> journals;

  const ListJournalScreen({super.key, required this.journals});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: 'Your Journal Entries'),
      body: Column(
        children: [
          SizedBox(height: 30),
          journals.isEmpty
              ? Center(child: TitleText(text: "No Journals Yet", size: 20))
              : ListView.builder(
                  itemCount: journals.length,
                  itemBuilder: (context, index) {
                    final journal = journals[index];
                    return JournalListCard(
                      title: journal.title,
                      content: journal.content,
                      date: journal.createdAt,
                    );
                  },
                ),
        ],
      ),
    );
  }
}
