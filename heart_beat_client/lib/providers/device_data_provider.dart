import 'package:flutter/cupertino.dart';
import 'package:heart_beat_client/models/device_data.dart';

class DeviceDataProvider extends ChangeNotifier {
  List<DeviceData> _userData = [];

  List<DeviceData> get userData => _userData;

  void setMoods(List<DeviceData> data) {
    _userData = data;

    notifyListeners();
  }

  DeviceData latestData() {
    DeviceData latest = _userData[_userData.length - 1];

    return latest;
  }
}
