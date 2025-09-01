import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_bottom_bar.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:heart_beat_client/widgets/playlist/playlist_card.dart';

class PlaylistHomeScreen extends StatelessWidget {
  final List<String> playlists = ["", "", ""];
  final double overlap = 220;

  PlaylistHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double stackHeight = playlists.isEmpty
        ? 0
        : 270 + (playlists.length - 1) * overlap;

    return Scaffold(
      appBar: CustomAppBar(title: "Playlists"),
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
                      child: PlaylistCard(),
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
