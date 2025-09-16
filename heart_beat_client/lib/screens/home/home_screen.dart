import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/providers/device_data_provider.dart';
import 'package:heart_beat_client/providers/journal_provider.dart';
import 'package:heart_beat_client/providers/mood_tracking_provider.dart';
import 'package:heart_beat_client/repositories/device_data_repository.dart';
import 'package:heart_beat_client/repositories/journal_repository.dart';
import 'package:heart_beat_client/repositories/mood_tracking_repository.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_bottom_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/side_bar.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:heart_beat_client/widgets/home/home_info_card.dart';
import 'package:heart_beat_client/widgets/home/thermometer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authProvider = context.read<AuthProvider>();
      final moodProvider = context.read<MoodTrackingProvider>();
      final dataProvider = context.read<DeviceDataProvider>();
      final journalProvider = context.read<JournalProvider>();

      final moodRepo = MoodTrackingRepository();
      final dataRepo = DeviceDataRepository();
      final journalRepo = JournalRepository();

      String curToken = authProvider.token!;
      int curUserId = authProvider.userId!;

      moodProvider.setMoods(await moodRepo.getUserMoods(curToken, curUserId));

      dataProvider.setData(await dataRepo.fetchData(curToken, curUserId));

      journalProvider.setJournals(
        await journalRepo.getJournals(curToken, curUserId),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final moodProvider = context.watch<MoodTrackingProvider>();
    final dataProvider = context.watch<DeviceDataProvider>();
    final journalProvider = context.watch<JournalProvider>();

    final userName = authProvider.userName;

    final data = dataProvider.userData.isNotEmpty
        ? dataProvider.userData.last.predictedStress
        : 0;

    String stressText =
        "Your vitals indicate that you are feeling quite stressed. Maybe try taking a day off?";

    if (data < 7) {
      stressText =
          "Your vitals indicate that you are feeling mildly stressed. Stay mindful of how you manage it.";
      if (data < 4) {
        stressText =
            "Your vitals indicate that you are feeling pretty relaxed. That's great!";
        if (data == 0) {
          stressText = "No predicted stress data available";
        }
      }
    }

    final mood = moodProvider.userMoods.isNotEmpty
        ? moodProvider.userMoods.last.mood
        : "No moods detected";

    final journal = journalProvider.userJournals.isNotEmpty
        ? journalProvider.userJournals.last.content
        : "No journal entries written";

    return Scaffold(
      appBar: CustomAppBar(title: "Home Screen"),
      drawer: const SideBar(),
      body: Column(
        children: [
          SizedBox(height: 20),
          TitleText(text: "How are you doing today, $userName?", size: 20),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                HomeInfoCard(
                  title: 'Mood',
                  content:
                      "Your last mood review indicates that you are feeling $mood.",
                  image: 'mood.png',
                ),
                Container(
                  padding: EdgeInsets.all(14),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Stress Level",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'montserrat',
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              stressText,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: Thermometer(value: data.toDouble()),
                      ),
                      SizedBox(width: 28),
                    ],
                  ),
                ),
                HomeInfoCard(
                  title: 'Recent Journal',
                  content: journal,
                  image: 'writing.png',
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
