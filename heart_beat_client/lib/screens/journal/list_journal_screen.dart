import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:heart_beat_client/widgets/journal/journal_list_card.dart';

class ListJournalScreen extends StatelessWidget {
  const ListJournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Journal"),
      body: Column(
        children: [
          SizedBox(height: 30),
          TitleText(text: "Your Journal Entries", size: 20),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                JournalListCard(),
                JournalListCard(),
                JournalListCard(),
                JournalListCard(),
                JournalListCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
