import 'package:flutter/material.dart';
import 'package:heart_beat_client/models/device_data.dart';
import 'package:heart_beat_client/providers/device_data_provider.dart';
import 'package:heart_beat_client/providers/mood_tracking_provider.dart';
import 'package:heart_beat_client/providers/playlist_provider.dart';
import 'package:heart_beat_client/providers/stats_provider.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_bottom_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/side_bar.dart';
import 'package:heart_beat_client/widgets/common/buttons/primary_button.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:heart_beat_client/widgets/common/logos/small_logo.dart';
import 'package:heart_beat_client/widgets/stats/stat_card.dart';
import 'package:heart_beat_client/widgets/stats/stats_chart.dart';
import 'package:provider/provider.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int playlists = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      playlists = context.read<PlaylistProvider>().playlists.length;

      final dataProvider = context.read<DeviceDataProvider>();

      
      dataProvider.latestData();
      context.read<StatsProvider>().loadStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    final stats = context.watch<StatsProvider>();
    final moodTracker = context.watch<MoodTrackingProvider>();

    final dataProvider = context.read<DeviceDataProvider>();
    DeviceData data = dataProvider.latestData();

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
              TitleText(text: "Your Mood Scores", size: 24),
              SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width * 0.9,
                child: StatsChart(
                  scores: [4, 6, 7, 5, 8, 3, 9],
                  days: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                  moods: moodTracker.lastSeven(),
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
                  StatCard(statType: "Playlists Created", statNum: playlists),
                  StatCard(
                    statType: "Phone Usage (Minutes per day)",
                    statNum: data.phoneUsage.toInt(),
                  ),
                  StatCard(
                    statType: "Average Heart Rate",
                    statNum: data.heartrate.toInt(),
                  ),
                ],
              ),
              SizedBox(height: 20),
              PrimaryButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.feedback);
                },
                label: "Submit Vitals Manually",
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
