import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/models/playlist.dart';
import 'package:heart_beat_client/providers/playlist_provider.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_bottom_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/side_bar.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:heart_beat_client/widgets/playlist/playlist_card.dart';
import 'package:provider/provider.dart';

class PlaylistHomeScreen extends StatelessWidget {
  final double overlap = 220;

  const PlaylistHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final playlistProvider = context.watch<PlaylistProvider>();
    List<Playlist> playlists = playlistProvider.playlists;

    double stackHeight = playlists.isEmpty
        ? 0
        : 270 + (playlists.length - 1) * overlap;

    return Scaffold(
      appBar: CustomAppBar(title: "Playlists"),
      drawer: const SideBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 4),
            child: TitleText(
              text: "What do you feel like listening to today?",
              size: 20,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                height: stackHeight,
                child: Stack(
                  children: List.generate(playlists.length, (index) {
                    return Positioned(
                      top: index * overlap,
                      left: 0,
                      right: 0,
                      child: PlaylistCard(playlistName: playlists[index].name),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryColor,
        shape: CircleBorder(),
        child: Icon(CupertinoIcons.add),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
// Hero widget