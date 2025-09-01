import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/common/bars/simple_app_bar.dart';

class UserSettings extends StatelessWidget {
  const UserSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Settings"),
      body: Container(),
    );
  }
}
