import 'package:flutter/material.dart';
import 'package:heart_beat_client/models/playlist.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/providers/playlist_provider.dart';
import 'package:heart_beat_client/repositories/playlist_repository.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_bottom_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/side_bar.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:heart_beat_client/widgets/playlist/playlist_card.dart';
import 'package:provider/provider.dart';

class PlaylistHomeScreen extends StatefulWidget {
  const PlaylistHomeScreen({super.key});

  @override
  State<PlaylistHomeScreen> createState() => _PlaylistHomeScreenState();
}

class _PlaylistHomeScreenState extends State<PlaylistHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final playlistProvider = context.read<PlaylistProvider>();
      playlistProvider.clearPlaylists();

      _loadMore();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          page++;
          _loadMore();
        });
      }
    });
  }

  void _loadMore() async {
    final authProvider = context.read<AuthProvider>();
    final playlistProvider = context.read<PlaylistProvider>();

    final playlistRepo = PlaylistRepository();

    String curToken = authProvider.token!;
    int curUserId = authProvider.userId!;

    playlistProvider.setPlaylists(
      await playlistRepo.getFivePlaylists(curToken, curUserId, page),
    );
  }

  final ScrollController _scrollController = ScrollController();
  final double overlap = 235;
  int page = 1;

  @override
  Widget build(BuildContext context) {
    final playlistProvider = context.watch<PlaylistProvider>();
    List<Playlist> playlists = playlistProvider.playlists;

    double stackHeight = playlists.isEmpty
        ? 0
        : 270 + (playlists.length - 1) * overlap;

    return Scaffold(
      appBar: CustomAppBar(title: "Playlists"),
      drawer: const SideBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 4),
            child: TitleText(
              text: "What do you feel like listening to today?",
              size: 20,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: SizedBox(
                height: playlists.isEmpty ? 200 : stackHeight,
                child: playlists.isEmpty
                    ? Center(
                        child: Text(
                          'No playlists available',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      )
                    : Stack(
                        children: List.generate(playlists.length, (index) {
                          return Positioned(
                            top: index * overlap,
                            left: 0,
                            right: 0,
                            child: PlaylistCard(
                              playlistName:
                                  playlists[index].name,
                              playlistId:
                                  playlists[index].id,
                              playlistColor:
                                  playlists[index].color,
                            ),
                          );
                        }),
                      ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: CustomBottomBar(),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
