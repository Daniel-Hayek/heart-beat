import 'package:flutter/material.dart';
import 'package:heart_beat_client/models/message.dart';

class AgentProvider extends ChangeNotifier {
  final List<Message> _messages = [];

  List<Message> get messages => _messages;

  void addMessage(Message message) {
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
