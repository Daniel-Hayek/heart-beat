import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_bottom_bar.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:heart_beat_client/widgets/playlist/playlist_card.dart';

class PlaylistHomeScreen extends StatelessWidget {
  const PlaylistHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double cardHeight = 270;
    double overlap = cardHeight - 30;
    int cardCount = 5;

    // total height for stack = height of first card + overlap for remaining cards
    double stackHeight = cardHeight + (cardCount - 1) * overlap;

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
                  children: List.generate(cardCount, (index) {
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
