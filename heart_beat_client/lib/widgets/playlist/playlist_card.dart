import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/providers/playlist_provider.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:provider/provider.dart';

class PlaylistCard extends StatelessWidget {
  final String playlistName;
  final int playlistId;

  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.indigo,
    Colors.pink,
  ];

  PlaylistCard({
    super.key,
    required this.playlistName,
    required this.playlistId,
  });

  Color getRandomColor() {
    final Random random = Random();
    return colors[random.nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: getRandomColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(text: playlistName, size: 30),
              // TitleText(text: "Artists, Artist, Art", size: 20),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  context.read<PlaylistProvider>().setActivePlaylist(
                    playlistId,
                    playlistName,
                  );

                  Navigator.pushNamed(context, AppRoutes.viewPlaylist);
                },
                icon: Icon(
                  CupertinoIcons.play_circle,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
