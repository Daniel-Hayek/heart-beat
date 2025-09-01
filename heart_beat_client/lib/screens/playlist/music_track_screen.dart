import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/providers/music_player_provider.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:provider/provider.dart';

class MusicTrackScreen extends StatelessWidget {
  const MusicTrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final playerProvider = context.watch<MusicPlayerProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.back, color: Colors.white),
        ),
        title: TitleText(text: "Music", size: 18),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Column(
        children: [
          SizedBox(height: 200),
          SizedBox(
            width: 200,
            height: 200,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          SizedBox(height: 40),
          TitleText(text: playerProvider.title ?? "Unknown Track", size: 20),
          Text(
            playerProvider.artist ?? "Unknown artist",
            style: TextStyle(
              fontFamily: 'montserrat',
              fontSize: 15,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 50),
          SizedBox(
            height: 2,
            width: double.infinity,
            child: Container(
              color: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleText(text: "00:40", size: 14),
              Text(
                "02:03",
                style: TextStyle(
                  fontFamily: 'montserrat',
                  fontSize: 14,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
