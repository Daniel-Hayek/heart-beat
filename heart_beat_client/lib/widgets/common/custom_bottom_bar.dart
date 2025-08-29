import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomBar extends StatelessWidget implements PreferredSizeWidget {
  final String currentActive;

  const CustomBottomBar({super.key, required this.currentActive});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/graph.svg',
            width: 30,
            height: 30,
          ),
          label: "Graph",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/journal.svg',
            width: 30,
            height: 30,
          ),
          label: "Journal",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/home.svg',
            width: 30,
            height: 30,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/music.svg',
            width: 30,
            height: 30,
          ),
          label: "Music",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/chatbot.svg',
            width: 30,
            height: 30,
          ),
          label: "Chatbot",
        ),
      ],
      backgroundColor: AppColors.primaryColor,
      type: BottomNavigationBarType.fixed,
      currentIndex: 1,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kBottomNavigationBarHeight);
}
