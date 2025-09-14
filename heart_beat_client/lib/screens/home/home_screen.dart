import 'package:flutter/material.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/providers/device_data_provider.dart';
import 'package:heart_beat_client/providers/journal_provider.dart';
import 'package:heart_beat_client/providers/mood_tracking_provider.dart';
import 'package:heart_beat_client/providers/playlist_provider.dart';
import 'package:heart_beat_client/repositories/device_data_repository.dart';
import 'package:heart_beat_client/repositories/journal_repository.dart';
import 'package:heart_beat_client/repositories/mood_tracking_repository.dart';
import 'package:heart_beat_client/repositories/playlist_repository.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_bottom_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/side_bar.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:heart_beat_client/widgets/home/home_info_card.dart';
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
      final playlistProvider = context.read<PlaylistProvider>();
      final moodProvider = context.read<MoodTrackingProvider>();
      final dataProvider = context.read<DeviceDataProvider>();
      final journalProvider = context.read<JournalProvider>();

      final playlistRepo = PlaylistRepository();
      final moodRepo = MoodTrackingRepository();
      final dataRepo = DeviceDataRepository();
      final journalRepo = JournalRepository();

      String curToken = authProvider.token!;
      int curUserId = authProvider.userId!;

      playlistProvider.setPlaylists(
        await playlistRepo.getAllPlaylists(curToken, curUserId),
      );

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
        ? dataProvider.userData.last.predictedStress.toString()
        : "No predicted stress";

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
                // HomeInfoCard(title: 'Stress Level', content: data),
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
