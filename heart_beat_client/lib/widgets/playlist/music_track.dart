import 'package:flutter/material.dart';
import 'package:heart_beat_client/models/song.dart';
import 'package:heart_beat_client/providers/music_player_provider.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/services/supabase_service.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class MusicTrack extends StatelessWidget {
  final Song song;

  const MusicTrack({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.read<MusicPlayerProvider>().playSong(song.title, song.artist);

        final songUrl = SupabaseService.publicUrl(song.songUrl);

        debugPrint(songUrl);

        final player = AudioPlayer();

        await player.setUrl(songUrl);

        player.play();

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
              song.duration.toString(),
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
