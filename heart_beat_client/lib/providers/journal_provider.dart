import 'package:flutter/material.dart';
import 'package:heart_beat_client/models/journal.dart';

class JournalProvider extends ChangeNotifier {
  List<Journal> _userJournals = [];

  List<Journal> get userJournals => _userJournals;

  void setJournals(List<Journal> journals) {
    _userJournals = journals;

    notifyListeners();
  }
}
