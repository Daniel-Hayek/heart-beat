import 'package:flutter/material.dart';
import 'package:heart_beat_client/models/song.dart';
import 'package:heart_beat_client/services/supabase_service.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayerProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  Song? _currentSong;
  Song? get currentSong => _currentSong;

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  Duration _currentPosition = Duration.zero;
  Duration get currentPosition => _currentPosition;

  Duration _totalDuration = Duration.zero;
  Duration get totalDuration => _totalDuration;

  MusicPlayerProvider() {
    _player.positionStream.listen((position) {
      _currentPosition = position;
      notifyListeners();
    });

    _player.durationStream.listen((duration) {
      _totalDuration = duration ?? Duration.zero;
      notifyListeners();
    });
  }

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

  void resume() {
    _player.play();
    _isPlaying = true;

    notifyListeners();
  }

  // void stop() {
  //   title = null;
  //   artist = null;

  //   notifyListeners();
  // }

  String get formattedPosition => _formatDuration(_currentPosition);
  String get formattedTotalDuration => _formatDuration(_totalDuration);

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
