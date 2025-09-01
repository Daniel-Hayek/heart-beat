import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/common/bars/simple_app_bar.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:heart_beat_client/widgets/common/scaffold/app_scaffold.dart';
import 'package:heart_beat_client/widgets/playlist/music_track.dart';

class ViewPlaylistScreen extends StatelessWidget {
  const ViewPlaylistScreen({super.key});

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
              child: ListView(
                children: List.generate(10, (index) {
                  return MusicTrack(trackName: index.toString());
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
