import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_bottom_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/side_bar.dart';
import 'package:heart_beat_client/widgets/common/buttons/secondary_button.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:heart_beat_client/widgets/journal/journal_home_card.dart';
import 'package:provider/provider.dart';

class BaseJournalScreen extends StatelessWidget {
  const BaseJournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final userName = authProvider.userName;

    return Scaffold(
      appBar: CustomAppBar(title: "Journal"),
      drawer: const SideBar(),
      body: ListView(
        children: [
          SizedBox(height: 40),
          TitleText(text: "What's on your mind today, $userName?", size: 20),
          SizedBox(height: 20),
          SecondaryButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.listJournal);
            },
            label: "View Your Journals",
          ),
          SizedBox(
            height: 530,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 160 / 200,
              padding: EdgeInsets.all(8),
              children: [
                JournalHomeCard(
                  prompt:
                      "What is something that happened this week that really bothered you? Why do you think it bothered you so much?",
                ),
                JournalHomeCard(
                  prompt:
                      "If you're feeling angry, what triggered this anger, and what is my reaction telling me? How would I like to respond to this situation ideally?",
                ),
                JournalHomeCard(
                  prompt:
                      "Rate your mood today on a scale of 1 to 10 and explain why. Which moments of the day changed your mood the most?",
                ),
                JournalHomeCard(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.writeJournal);
        },
        backgroundColor: AppColors.primaryColor,
        shape: CircleBorder(),
        child: Icon(CupertinoIcons.add),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
