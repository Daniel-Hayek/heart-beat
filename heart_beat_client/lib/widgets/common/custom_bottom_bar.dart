import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';

class CustomBottomBar extends StatelessWidget implements PreferredSizeWidget {
  final String currentActive;

  const CustomBottomBar({super.key, required this.currentActive});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.graph_square), label: 'Stats'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.book), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.music_note_2), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.chat_bubble), label: 'Home'),
      ],
      backgroundColor: AppColors.primaryColor,
      type: BottomNavigationBarType.fixed,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kBottomNavigationBarHeight);
}
