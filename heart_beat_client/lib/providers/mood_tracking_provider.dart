import 'package:flutter/cupertino.dart';
import 'package:heart_beat_client/models/mood_tracking.dart';

class MoodTrackingProvider extends ChangeNotifier {
  List<MoodTracking> _userMoods = [];

  List<MoodTracking> get userMoods => _userMoods;

  void setMoods(List<MoodTracking> moods) {
    _userMoods = moods;

    notifyListeners();
  }

  List<MoodTracking> lastSeven() {
    List<MoodTracking> seven = [];

    for (int i = 0; i < 7 && i < _userMoods.length; i++) {
      seven.add(_userMoods[_userMoods.length - i - 1]);
    }

    return seven;
  }
}
