import 'package:flutter/material.dart';
import 'package:heart_beat_client/models/journal.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/repositories/journal_repository.dart';

class JournalProvider extends ChangeNotifier {
  final JournalRepository journalRepo;
  final AuthProvider authProvider;

  List<Journal> _journals = [];
  bool _isLoading = false;

  JournalProvider({required this.journalRepo, required this.authProvider});

  List<Journal> get journals => _journals;
  bool get isLoading => _isLoading;

  Future<void> fetchJournals() async {
    _isLoading = true;
    notifyListeners();

    try {
      final token = authProvider.token;
      final userId = authProvider.userId;

      if (token == null) {
        throw Exception("No token");
      }

      _journals = await journalRepo.getJournals(token: token, id: userId!);
    } catch (e) {
      throw Exception(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addJournal(Journal journal) {
    _journals.add(journal);
  }
}
