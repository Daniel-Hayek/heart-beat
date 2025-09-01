import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/buttons/primary_button.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:lucide_icons/lucide_icons.dart';

class QuizBaseScreen extends StatelessWidget {
  const QuizBaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Mood Quizzes"),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 4),
            child: TitleText(
              text: "Let's figure out how you're feeling!",
              size: 20,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                TitleText(text: "Last Mood Quiz Result", size: 20),
                TitleText(text: "mm/yy/dd", size: 19),
                Row(
                  children: [
                    TitleText(text: "Sad", size: 30),
                    Icon(LucideIcons.frown),
                  ],
                ),
                PrimaryButton(onPressed: () {}, label: "Take A Quiz"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
