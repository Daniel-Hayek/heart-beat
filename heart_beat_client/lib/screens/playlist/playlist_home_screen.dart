import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_bottom_bar.dart';

class PlaylistHomeScreen extends StatelessWidget {
  const PlaylistHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Playlists"),
      body: Column(),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
