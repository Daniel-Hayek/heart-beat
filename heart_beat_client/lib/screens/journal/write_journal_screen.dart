import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/repositories/journal_repository.dart';
import 'package:heart_beat_client/widgets/auth/auth_snack_bar.dart';
import 'package:heart_beat_client/widgets/common/buttons/primary_button.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:provider/provider.dart';

class WriteJournalScreen extends StatefulWidget {
  const WriteJournalScreen({super.key});

  @override
  State<WriteJournalScreen> createState() => _WriteJournalScreenState();
}

class _WriteJournalScreenState extends State<WriteJournalScreen> {
  final TextEditingController _journalController = TextEditingController();

  final JournalRepository _journalRepo = JournalRepository();

  @override
  void dispose() {
    _journalController.dispose();
    super.dispose();
  }

  void _createJournal() async {
    try {
      final authProvider = context.read<AuthProvider>();

      _journalRepo.createJournal(
        content: _journalController.text,
        id: authProvider.userId!,
        token: authProvider.token!,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(AuthSnackBar(content: Text('Journal saved succesfully!')));

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(AuthSnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.back, color: Colors.white),
        ),
        title: TitleText(text: "New Journal Entry", size: 18),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Column(
        children: [
          Text(
            "How was your experience today?",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontFamily: 'montserrat',
              fontSize: 18,
            ),
          ),
          TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: _journalController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.backgroundColor,
              hintText: "What's on your mind...",
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ],
      ),
      floatingActionButton: PrimaryButton(
        onPressed: _createJournal,
        label: "Save",
      ),
    );
  }
}
