import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';

class ViewPlaylistScreen extends StatelessWidget {
  const ViewPlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.back, color: Colors.white),
        ),
        title: TitleText(text: "New Journal Entry", size: 18),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  TitleText(text: "Playlist Title", size: 29),
                  TitleText(text: "No of Songs", size: 24),
                  TitleText(text: "12:34 min", size: 20),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
