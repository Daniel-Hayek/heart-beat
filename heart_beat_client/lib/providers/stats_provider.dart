import 'package:flutter/material.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/repositories/journal_repository.dart';

class StatsProvider extends ChangeNotifier {
  final JournalRepository _journalRepo = JournalRepository();
  final AuthProvider _authProvider;

  StatsProvider(this._authProvider);

  int _journals = 0;
  // int _quizzes = 0;
  // int _phoneUsage = 0;
  // int _avgHeartRate = 0;
  bool _isLoading = true;

  int? get journals => _journals;
  // int? get quizzes => _quizzes;
  // int? get phoneUsage => _phoneUsage;
  // int? get avgHeartRate => _avgHeartRate;
  bool get isLoading => _isLoading;

  void loadStats() async {
    _isLoading = true;
    notifyListeners();

    try {
      _journals = int.parse(
        await _journalRepo.getNumber(
          token: _authProvider.token!,
          userId: _authProvider.userId!,
        ),
      );
    } catch (e) {
      _journals = 21;
      throw Exception(e);
    }

    _isLoading = false;
    notifyListeners();
  }
}
