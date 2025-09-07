import 'package:flutter/cupertino.dart';
import 'package:heart_beat_client/models/mood_tracking.dart';

class MoodTrackingProvider extends ChangeNotifier {
  List<MoodTracking> _userMoods = [];

  List<MoodTracking> get userMoods => _userMoods;

  void setMoods(List<MoodTracking> moods) {
    _userMoods = moods;

    notifyListeners();
  }
}
