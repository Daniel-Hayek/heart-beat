import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/providers/music_player_provider.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:provider/provider.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final playerProvider = context.watch<MusicPlayerProvider>();

    return Container(
      decoration: BoxDecoration(color: AppColors.secondaryColor),
      width: double.infinity,
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleText(text: playerProvider.formattedPosition, size: 14),
              IconButton(
                onPressed: () {
                  if (playerProvider.isPlaying) {
                    playerProvider.pause();
                  } else {
                    playerProvider.resume();
                  }
                },
                icon: Icon(
                  playerProvider.isPlaying
                      ? CupertinoIcons.pause
                      : CupertinoIcons.play_arrow_solid,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            children: [
              TitleText(
                text: playerProvider.currentSong?.title ?? "",
                size: 16,
              ),
              Text(
                playerProvider.currentSong?.artist ?? "",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontFamily: 'montserrat',
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                playerProvider.formattedTotalDuration,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontFamily: 'montserrat',
                  fontSize: 14,
                ),
              ),
              IconButton(
                onPressed: () {
                  playerProvider.playNext();
                },
                icon: Icon(
                  Icons.skip_next_sharp,
                  color: Colors.white,
                  size: 42,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
