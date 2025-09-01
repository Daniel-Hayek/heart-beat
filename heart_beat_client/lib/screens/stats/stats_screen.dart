import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_bottom_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/side_bar.dart';
import 'package:heart_beat_client/widgets/common/buttons/primary_button.dart';
import 'package:heart_beat_client/widgets/common/logos/small_logo.dart';
import 'package:heart_beat_client/widgets/stats/stat_card.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Mood Tracking Stats"),
      drawer: SideBar(),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: MediaQuery.of(context).size.width * 0.06,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              SmallLogo(),
              SizedBox(
                height: 250,
                width: 330,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(color: AppColors.secondaryColor),
                ),
              ),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  StatCard(statType: "Journals Written", statNum: 200),
                  StatCard(statType: "Quizzes Taken", statNum: 12),
                  StatCard(
                    statType: "Phone Usage (Hours/7 days)",
                    statNum: 100,
                  ),
                  StatCard(statType: "Average Heart Rate", statNum: 90),
                ],
              ),
              SizedBox(height: 20),
              PrimaryButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.feedback);
                },
                label: "Improve Mood Tracking",
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
