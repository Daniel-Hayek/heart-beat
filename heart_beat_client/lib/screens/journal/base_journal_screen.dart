import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_bottom_bar.dart';
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
      body: Column(
        children: [
          SizedBox(height: 40),
          TitleText(text: "What's on your mind today, $userName?", size: 20),
          SizedBox(height: 60),
          SizedBox(
            height: 530,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 160 / 200,
              padding: EdgeInsets.all(8),
              children: [
                JournalHomeCard(),
                JournalHomeCard(),
                JournalHomeCard(),
                JournalHomeCard(),
              ],
            ),
          ),
          SecondaryButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.listJournal);
            },
            label: "View All",
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
