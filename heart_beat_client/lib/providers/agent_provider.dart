import 'package:flutter/material.dart';

class AgentProvider extends ChangeNotifier {
  List<String> _messages = [];

  List<String> get messages => _messages;

  void addMessage(String message) {
    _messages.add(message);

    notifyListeners();
  }

  // latestData() {
  //   debugPrint("Hello from latest data");
  //   debugPrint(userData.length.toString());

  //   DeviceData latest = _userData[_userData.length - 1];

  //   // notifyListeners();

  //   return latest;
  // }
}
