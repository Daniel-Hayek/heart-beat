import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/common/bars/side_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/simple_app_bar.dart';
import 'package:heart_beat_client/widgets/common/buttons/primary_button.dart';
import 'package:heart_beat_client/widgets/common/buttons/secondary_button.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:lucide_icons/lucide_icons.dart';

class QuizBaseScreen extends StatelessWidget {
  const QuizBaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Mood Quizzes"),
      drawer: const SideBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            margin: EdgeInsets.symmetric(vertical: 50, horizontal: 4),
            child: TitleText(
              text: "Let's figure out how you're feeling!",
              size: 20,
            ),
          ),
          SizedBox(height: 60),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(text: "Last Mood Quiz Result", size: 20),
                TitleText(text: "mm/yy/dd", size: 19),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleText(text: "Sad", size: 30),
                    Icon(LucideIcons.frown, size: 90, color: Colors.white),
                  ],
                ),
              ],
            ),
          ),
          PrimaryButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.quizQuestion);
            },
            label: "Take A Quiz",
            padding: EdgeInsetsGeometry.symmetric(vertical: 10, horizontal: 28),
          ),
          SizedBox(height: 10),
          SecondaryButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            },
            label: "Back to Home",
          ),
        ],
      ),
    );
  }
}
