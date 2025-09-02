import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:heart_beat_client/widgets/settings/settings_checkbox.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  bool passiveTracking = false;
  bool playlistGeneration = false;
  bool moodAnalysis = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.05,
            horizontal: MediaQuery.of(context).size.height * 0.05,
          ),
          child: Column(
            children: [
              TitleText(
                text: "Enable the following automation tasks?",
                size: 24,
              ),
              SizedBox(height: 40),
              SettingsCheckbox(
                label: "Passively track your mood through your phone usage and smart watch",
                value: passiveTracking,
                onChanged: (val) {
                  setState(() => passiveTracking = val ?? false);
                },
              ),
              SizedBox(height: 20),
              SettingsCheckbox(
                label: "Generate playlists at noon every day based on compiled moods",
                value: playlistGeneration,
                onChanged: (val) {
                  setState(() => playlistGeneration = val ?? false);
                },
              ),
              SizedBox(height: 20),
              SettingsCheckbox(
                label: "Analyse journal entries for your mood once you're done writing",
                value: moodAnalysis,
                onChanged: (val) {
                  setState(() => moodAnalysis = val ?? false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
