import 'package:flutter/material.dart';
import 'package:heart_beat_client/models/journal.dart';
import 'package:heart_beat_client/models/playlist.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/providers/playlist_provider.dart';
import 'package:heart_beat_client/repositories/journal_repository.dart';
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
  Journal latest = Journal(
    id: 0,
    title: "",
    content: "No Journal Entry Found",
    createdAt: DateTime.now(),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authProvider = context.read<AuthProvider>();
      final playlistProvider = context.read<PlaylistProvider>();

      final journalRepo = JournalRepository();
      final playlistRepo = PlaylistRepository();

      final recent = await journalRepo.getLatest(
        token: authProvider.token!,
        userId: authProvider.userId!,
      );

      if (!mounted) {
        return;
      }

      List<Playlist> temp = await playlistRepo.getAllPlaylists(
        authProvider.token!,
        authProvider.userId!,
      );

      debugPrint(temp[0].name);

      playlistProvider.setPlaylists(temp);

      if (!mounted) {
        return;
      }

      setState(() {
        latest = recent;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final userName = authProvider.userName;

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
                  title: 'Recent Journal Entry',
                  content: latest.content,
                ),
                HomeInfoCard(title: "Title", content: "Content"),
                HomeInfoCard(title: "Title", content: "Content"),
              ],
            ),
          ),
          // ElevatedButton(
          //   onPressed: () async {
          //     final authProvider = context.read<AuthProvider>();
          //     final token = await authProvider.loadToken();
          //     final decodedToken = JwtDecoder.decode(token!);

          //     ScaffoldMessenger.of(context).showSnackBar(
          //       AuthSnackBar(content: Text(decodedToken.toString())),
          //     );
          //   },
          //   child: const Text("Get token"),
          // ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
