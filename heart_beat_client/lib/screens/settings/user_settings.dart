import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/settings/settings_checkbox.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  bool test = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SettingsCheckbox(label: "Test", value: test, onChanged: (val) {
            setState(() => test = val ?? false);
          }),
        ],
      ),
    );
  }
}
