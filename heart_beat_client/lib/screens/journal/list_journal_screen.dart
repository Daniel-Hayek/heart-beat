import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/common/bars/simple_app_bar.dart';
import 'package:heart_beat_client/widgets/journal/journal_list_card.dart';

class ListJournalScreen extends StatelessWidget {
  const ListJournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: 'Your Journal Entries'),
      body: Column(
        children: [
          SizedBox(height: 30),
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
