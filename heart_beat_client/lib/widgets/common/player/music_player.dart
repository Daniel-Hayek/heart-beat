import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.secondaryColor),
      width: double.infinity,
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleText(text: "00:40", size: 14),
              Icon(CupertinoIcons.pause, size: 30, color: Colors.white),
            ],
          ),
          Column(
            children: [
              TitleText(text: "Track Name", size: 16),
              Text(
                "Artist",
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
                "02:03",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontFamily: 'montserrat',
                  fontSize: 14,
                ),
              ),
              Icon(Icons.skip_next_sharp, color: Colors.white, size: 30),
            ],
          ),
        ],
      ),
    );
  }
}
