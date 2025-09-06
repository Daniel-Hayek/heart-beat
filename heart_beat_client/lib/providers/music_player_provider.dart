import 'package:flutter/material.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/repositories/song_repository.dart';

class MusicPlayerProvider extends ChangeNotifier {
  final SongRepository _songRepo = SongRepository();
  final AuthProvider _authProvider;

  MusicPlayerProvider(this._authProvider);

  String? title;
  String? artist;
  // bool isPlaying = false;

  void fetchSong() async {
    try {
      // song = await _songRepo.getSong(id: 1, token: _authProvider.token!);
    } catch (e) {
      throw Exception(e);
    }
  }

  void playSong(String songTitle, String songArtist) {
    title = songTitle;
    artist = songArtist;

    notifyListeners();
  }

  void pause() {
    notifyListeners();
  }

  void stop() {
    title = null;
    artist = null;

    notifyListeners();
  }
}
