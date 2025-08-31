import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';

class MusicTrack extends StatelessWidget {
  final String trackName;

  const MusicTrack({super.key, required this.trackName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint("Music selected");
      },
      child: Row(
        children: [
          TitleText(text: "Song Name $trackName", size: 20),
          Text(
            "xx:xx",
            style: TextStyle(
              fontFamily: 'montserrat',
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
