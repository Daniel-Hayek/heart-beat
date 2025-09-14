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

    DeviceData latest = _userData[_userData.length - 1];

    // notifyListeners();

    return latest;
  }
}
