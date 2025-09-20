import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/providers/playlist_provider.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:provider/provider.dart';

class PlaylistCard extends StatelessWidget {
  final String playlistName;
  final int playlistId;
  final String playlistColor;

  const PlaylistCard({
    super.key,
    required this.playlistName,
    required this.playlistId,
    required this.playlistColor,
  });

  int setColor() {
    int colorCode = int.parse("0xFF$playlistColor");
    debugPrint(playlistColor);
    debugPrint(colorCode.toString());
    return colorCode;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Color(int.parse("FF$playlistColor", radix: 16)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(text: playlistName, size: 32, align: TextAlign.left),
              // TitleText(text: "Artists, Artist, Art", size: 20),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: IconButton(
                  onPressed: () {
                    context.read<PlaylistProvider>().setActivePlaylist(
                      playlistId,
                      playlistName,
                    );

                    Navigator.pushNamed(context, AppRoutes.viewPlaylist);
                  },
                  icon: Icon(
                    CupertinoIcons.play_circle,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
