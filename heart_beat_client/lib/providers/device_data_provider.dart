import 'package:flutter/material.dart';
import 'package:heart_beat_client/models/device_data.dart';

class DeviceDataProvider extends ChangeNotifier {
  List<DeviceData> _userData = [];

  List<DeviceData> get userData => _userData;

  void setData(List<DeviceData> data) {
    _userData = data;

    notifyListeners();
  }

  latestData() {
    debugPrint("Hello from latest data");
    debugPrint(userData.length.toString());

    if (_userData.isNotEmpty) {
      DeviceData latest = _userData[_userData.length - 1];
      return latest;
    }

    // notifyListeners();

    return DeviceData(
      id: 0,
      sleepDuration: 0,
      activityLevel: 0,
      steps: 0,
      heartrate: 0,
      phoneUsage: 0,
      predictedStress: 0,
      createdAt: DateTime.now(),
    );
  }
}
