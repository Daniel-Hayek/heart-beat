import 'package:flutter/cupertino.dart';
import 'package:heart_beat_client/models/mood_tracking.dart';

class DeviceDataProvider extends ChangeNotifier {
  List<MoodTracking> _userMoods = [];

  List<MoodTracking> get userMoods => _userMoods;

  void setMoods(List<MoodTracking> moods) {
    _userMoods = moods;

    notifyListeners();
  }

  List<MoodTracking> lastSeven() {
    List<MoodTracking> temp = [];
    List<MoodTracking> seven = [];

    for (int i = 0; i < 7 && i < _userMoods.length; i++) {
      temp.add(_userMoods[_userMoods.length - i - 1]);
    }

    for (int i = 0; i < temp.length; i++) {
      seven.add(temp[temp.length - i - 1]);
    }
    
    return seven;
  }
}