import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/common/player/music_player.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final bool showPlayer;

  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.showPlayer = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Expanded(child: body),
          if (showPlayer) MusicPlayer(),
        ],
      ),
    );
  }
}
