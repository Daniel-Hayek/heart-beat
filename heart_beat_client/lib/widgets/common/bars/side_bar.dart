import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/common/buttons/secondary_button.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final email = authProvider.email;

    return Drawer(
      backgroundColor: AppColors.secondaryColor,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primaryColor),
            child: Container(
              height: 100,
              alignment: Alignment.center,
              child: TitleText(text: "Menu", size: 24),
            ),
          ),
          ListTile(
            leading: const Icon(LucideIcons.bookOpenCheck, color: Colors.white),
            title: const TitleText(text: "Mood Quizzes", size: 20),
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoutes.quiz);
            },
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.profile_circled,
              color: Colors.white,
            ),
            title: const TitleText(text: "Profile", size: 20),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.profile);
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.gear, color: Colors.white),
            title: const TitleText(text: "Settings", size: 20),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.settings);
            },
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Text(
              "Currently logged in as $email",
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 16,
                fontFamily: 'montserrat',
              ),
            ),
          ),
          SecondaryButton(
            onPressed: () {
              authProvider.logout();
              Navigator.pushReplacementNamed(context, AppRoutes.landing);
            },
            label: "Logout",
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
