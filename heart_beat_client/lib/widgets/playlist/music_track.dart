import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/helpers/time_converter.dart';
import 'package:heart_beat_client/models/song.dart';
import 'package:heart_beat_client/providers/music_player_provider.dart';
// import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:provider/provider.dart';

class MusicTrack extends StatelessWidget {
  final Song song;
  final int index;

  const MusicTrack({super.key, required this.song, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.read<MusicPlayerProvider>().playSong(startIndex: index);

        // Navigator.pushNamed(context, AppRoutes.musicTrack);
        debugPrint("Music selected");
      },
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 6, horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TitleText(text: song.title, size: 20),
            Text(
              TimeConverter.convertTime(song.duration),
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
