import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/common/bars/simple_app_bar.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Edit Profile"),
      body: Container(),
    );
  }
}
