import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/common/buttons/primary_button.dart';
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
          Container(
            height: kToolbarHeight + MediaQuery.of(context).padding.top,
            decoration: BoxDecoration(color: AppColors.primaryColor),
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            alignment: Alignment.center,
            child: TitleText(text: "Menu", size: 24),
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ListTile(
                leading: const Icon(
                  LucideIcons.bookOpenCheck,
                  color: Colors.white,
                ),
                title: TitleText(
                  text: "Mood Quizzes",
                  size: 20,
                  align: TextAlign.left,
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.quiz);
                },
              ),
              ListTile(
                leading: const Icon(
                  CupertinoIcons.profile_circled,
                  color: Colors.white,
                ),
                title: const TitleText(
                  text: "Profile",
                  size: 20,
                  align: TextAlign.left,
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.profile);
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.gear, color: Colors.white),
                title: const TitleText(
                  text: "Settings",
                  size: 20,
                  align: TextAlign.left,
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.settings);
                },
              ),
            ],
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Text(
              "Currently logged in as\n$email",
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14,
                fontFamily: 'montserrat',
              ),
            ),
          ),
          PrimaryButton(
            onPressed: () {
              authProvider.logout();
              Navigator.pushReplacementNamed(context, AppRoutes.landing);
            },
            label: "Logout",
          ),
          SizedBox(height: 70),
        ],
      ),
    );
  }
}
