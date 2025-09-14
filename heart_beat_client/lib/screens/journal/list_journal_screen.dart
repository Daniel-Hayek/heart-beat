import 'package:flutter/material.dart';
import 'package:heart_beat_client/models/journal.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/repositories/journal_repository.dart';
import 'package:heart_beat_client/widgets/common/bars/simple_app_bar.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:heart_beat_client/widgets/journal/journal_list_card.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';

class ListJournalScreen extends StatefulWidget {
  const ListJournalScreen({super.key});

  @override
  State<ListJournalScreen> createState() => _ListJournalScreenState();
}

class _ListJournalScreenState extends State<ListJournalScreen> {
  bool isLoading = true;
  List<Journal> journals = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authProvider = context.read<AuthProvider>();

      journals = [];

      final journalRepo = JournalRepository();
      final fetchedJournals = await journalRepo.getJournals(
        authProvider.token!,
        authProvider.userId!,
      );
      setState(() {
        journals = fetchedJournals;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: 'Your Journal Entries'),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : journals.isEmpty
                ? const Center(
                    child: TitleText(text: "No Journals Yet", size: 20),
                  )
                : ListView.builder(
                    itemCount: journals.length,
                    itemBuilder: (context, index) {
                      final journal = journals[journals.length - index - 1];

                      final formattedDate = DateFormat(
                        'MMM d, yyyy',
                      ).format(journal.createdAt);
                      final relativeTime = timeago.format(journal.createdAt);
                      final displayDate = '$formattedDate • $relativeTime';

                      return JournalListCard(
                        id: journal.id,
                        title: journal.title,
                        moods: journal.moods,
                        content: journal.content,
                        date: displayDate,
                        onDelete: () {
                          setState(() {
                            journals.removeWhere((j) => j.id == journal.id);
                          });
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
