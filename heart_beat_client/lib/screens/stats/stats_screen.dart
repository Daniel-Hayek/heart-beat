import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/providers/stats_provider.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_bottom_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/side_bar.dart';
import 'package:heart_beat_client/widgets/common/buttons/primary_button.dart';
import 'package:heart_beat_client/widgets/common/logos/small_logo.dart';
import 'package:heart_beat_client/widgets/stats/stat_card.dart';
import 'package:provider/provider.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StatsProvider>().loadStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    final stats = context.watch<StatsProvider>();

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
                  StatCard(
                    statType: "Journals Written",
                    statNum: stats.journals!,
                  ),
                  StatCard(statType: "Quizzes Taken", statNum: stats.quizzes!),
                  StatCard(
                    statType: "Phone Usage (Hours/7 days)",
                    statNum: stats.phoneUsage!,
                  ),
                  StatCard(
                    statType: "Average Heart Rate",
                    statNum: stats.avgHeartRate!,
                  ),
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
