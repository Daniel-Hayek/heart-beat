import 'package:flutter/material.dart';
import 'package:heart_beat_client/providers/music_player_provider.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:provider/provider.dart';

class MusicTrack extends StatelessWidget {
  final String trackName;

  const MusicTrack({super.key, required this.trackName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<MusicPlayerProvider>().playSong(
          trackName,
          "Generic Artist",
        );
        debugPrint("Music selected");
      },
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 6, horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
    );
  }
}
