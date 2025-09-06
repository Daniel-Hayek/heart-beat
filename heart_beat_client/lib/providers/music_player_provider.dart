import 'package:flutter/material.dart';
import 'package:heart_beat_client/models/song.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/services/supabase_service.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayerProvider extends ChangeNotifier {
  // final SongRepository _songRepo = SongRepository();
  final AuthProvider _authProvider;

  MusicPlayerProvider(this._authProvider);

  final AudioPlayer _player = AudioPlayer();

  Song? _currentSong;
  Song? get currentSong => _currentSong;

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  void playSong(Song song) async {
    _currentSong = song;
    _isPlaying = true;

    final fullUrl = SupabaseService.publicUrl(song.songUrl);

    try {
      await _player.setUrl(fullUrl);
      _player.play();
    } catch (e) {
      throw Exception(e);
    }

    notifyListeners();
  }

  void pause() {
    _player.pause();
    _isPlaying = false;

    notifyListeners();
  }

  // void stop() {
  //   title = null;
  //   artist = null;

  //   notifyListeners();
  // }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
