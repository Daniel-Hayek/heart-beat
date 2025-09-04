import 'package:flutter/material.dart';
import 'package:heart_beat_client/providers/journal_provider.dart';
import 'package:heart_beat_client/widgets/common/bars/simple_app_bar.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:heart_beat_client/widgets/journal/journal_list_card.dart';
import 'package:provider/provider.dart';

class ListJournalScreen extends StatelessWidget {
  const ListJournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final journalProvider = context.watch<JournalProvider>();

    return Scaffold(
      appBar: SimpleAppBar(title: 'Your Journal Entries'),
      body: Column(
        children: [
          SizedBox(height: 30),
          Expanded(
            child: journalProvider.journals.isEmpty
                ? Center(child: TitleText(text: "No Journals Yet", size: 20))
                : ListView.builder(
                    itemCount: journalProvider.journals.length,
                    itemBuilder: (context, index) {
                      final journal = journalProvider.journals[index];
                      return JournalListCard(
                        title: journal.title,
                        content: journal.content,
                        date: journal.createdAt,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
