import 'package:flutter/material.dart';
import 'package:heart_beat_client/providers/music_player_provider.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:provider/provider.dart';

class MusicTrack extends StatelessWidget {
  final String trackName;
  final int duration;

  const MusicTrack({
    super.key,
    required this.trackName,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<MusicPlayerProvider>().playSong(
          trackName,
          "Generic Artist",
        );

        Navigator.pushNamed(context, AppRoutes.musicTrack);
        debugPrint("Music selected");
      },
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 6, horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TitleText(text: trackName, size: 20),
            Text(
              duration.toString(),
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
