import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/helpers/time_converter.dart';
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

  List<Song> _playlist = [];
  int _currentIndex = 0;

  Song? get nextSong => (_currentIndex + 1 < _playlist.length)
      ? _playlist[_currentIndex + 1]
      : null;

  MusicPlayerProvider() {
    _player.positionStream.listen((position) {
      _currentPosition = position;
      notifyListeners();
    });

    _player.durationStream.listen((duration) {
      _totalDuration = duration ?? Duration.zero;
      notifyListeners();
    });

    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        playNext();
      }
    });
  }

  void playSong({int startIndex = 0}) async {
    _currentIndex = startIndex;
    _isPlaying = true;

    final fullUrl = SupabaseService.publicUrl(_playlist[_currentIndex].songUrl);

    _currentSong = _playlist[_currentIndex];

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

  String get formattedPosition =>
      TimeConverter.convertTime(_currentPosition.inSeconds);
  String get formattedTotalDuration =>
      TimeConverter.convertTime(_totalDuration.inSeconds);


  void setPlaylist(List<Song> songs) {
    _playlist = songs;
    _currentIndex = 0;

    // if (_playlist.isNotEmpty) {
    //   playSong(_playlist[_currentIndex]);
    // }
  }

  void playNext() {
    if (_currentIndex + 1 < _playlist.length) {
      _currentIndex++;
      playSong(startIndex: _currentIndex);
    } else {
      _isPlaying = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
