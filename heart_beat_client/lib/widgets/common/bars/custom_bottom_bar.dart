import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heart_beat_client/providers/nav_provider.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:provider/provider.dart';

class CustomBottomBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> _routes = [
    AppRoutes.home,
    AppRoutes.journal,
    AppRoutes.home,
    AppRoutes.playlist,
    AppRoutes.home,
  ];

  CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavProvider>();

    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/graph.svg',
            width: 30,
            height: 30,
            colorFilter: ColorFilter.mode(
              navProvider.currentIndex == 0
                  ? Colors.white
                  : AppColors.backgroundColor,
              BlendMode.srcIn,
            ),
          ),
          label: "Graph",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/journal.svg',
            width: 30,
            height: 30,
            colorFilter: ColorFilter.mode(
              navProvider.currentIndex == 1
                  ? Colors.white
                  : AppColors.backgroundColor,
              BlendMode.srcIn,
            ),
          ),
          label: "Journal",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/home.svg',
            width: 30,
            height: 30,
            colorFilter: ColorFilter.mode(
              navProvider.currentIndex == 2
                  ? Colors.white
                  : AppColors.backgroundColor,
              BlendMode.srcIn,
            ),
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/music.svg',
            width: 30,
            height: 30,
            colorFilter: ColorFilter.mode(
              navProvider.currentIndex == 3
                  ? Colors.white
                  : AppColors.backgroundColor,
              BlendMode.srcIn,
            ),
          ),
          label: "Music",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/chatbot.svg',
            width: 30,
            height: 30,
            colorFilter: ColorFilter.mode(
              navProvider.currentIndex == 4
                  ? Colors.white
                  : AppColors.backgroundColor,
              BlendMode.srcIn,
            ),
          ),
          label: "Chatbot",
        ),
      ],
      backgroundColor: AppColors.primaryColor,
      type: BottomNavigationBarType.fixed,
      currentIndex: navProvider.currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
        if (navProvider.currentIndex == index) {
          return;
        }

        navProvider.setIndex(index);
        Navigator.pushReplacementNamed(context, _routes[index]);
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kBottomNavigationBarHeight);
}
