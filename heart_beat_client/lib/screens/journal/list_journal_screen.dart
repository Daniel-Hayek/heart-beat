import 'package:flutter/material.dart';
import 'package:heart_beat_client/providers/journal_provider.dart';
import 'package:heart_beat_client/widgets/common/bars/simple_app_bar.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:heart_beat_client/widgets/journal/journal_list_card.dart';
import 'package:provider/provider.dart';

class ListJournalScreen extends StatefulWidget {
  const ListJournalScreen({super.key});

  @override
  State<ListJournalScreen> createState() => _ListJournalScreenState();
}

class _ListJournalScreenState extends State<ListJournalScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the fetch once when the screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<JournalProvider>().fetchJournals();
    });
  }

  @override
  Widget build(BuildContext context) {
    final journalProvider = context.watch<JournalProvider>();

    return Scaffold(
      appBar: SimpleAppBar(title: 'Your Journal Entries'),
      body: Column(
        children: [
          const SizedBox(height: 30),
          journalProvider.journals.isEmpty
              ? Center(
                  child: TitleText(
                    text: journalProvider.isLoading
                        ? "Loading..."
                        : "No Journals Yet",
                    size: 20,
                  ),
                )
              : Expanded(
                  child: ListView.builder(
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
