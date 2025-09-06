import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/models/song.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/providers/music_player_provider.dart';
import 'package:heart_beat_client/repositories/song_repository.dart';
import 'package:heart_beat_client/widgets/common/bars/simple_app_bar.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:heart_beat_client/widgets/common/scaffold/app_scaffold.dart';
import 'package:heart_beat_client/widgets/playlist/music_track.dart';
import 'package:provider/provider.dart';

class ViewPlaylistScreen extends StatefulWidget {
  const ViewPlaylistScreen({super.key});

  @override
  State<ViewPlaylistScreen> createState() => _ViewPlaylistScreenState();
}

class _ViewPlaylistScreenState extends State<ViewPlaylistScreen> {
  List<Song> songs = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authProvider = context.read<AuthProvider>();

      final songRepo = SongRepository();
      final fetchedSongs = await songRepo.getAllSongs(
        token: authProvider.token!,
      );
      setState(() {
        songs = fetchedSongs;
        context.read<MusicPlayerProvider>().setPlaylist(songs);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: SimpleAppBar(title: "Playlist Name"),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          children: [
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TitleText(text: "Playlist Title", size: 29),
                    TitleText(text: "No of Songs", size: 24),
                    TitleText(text: "12:34 min", size: 20),
                  ],
                ),
                Icon(CupertinoIcons.play_circle, size: 80, color: Colors.white),
              ],
            ),
            SizedBox(height: 150),
            Expanded(
              child: ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  final song = songs[index];

                  return MusicTrack(song: song, index: index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
