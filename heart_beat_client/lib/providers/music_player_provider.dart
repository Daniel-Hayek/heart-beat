import 'package:flutter/material.dart';

class MusicPlayerProvider extends ChangeNotifier {
  String? title;
  String? artist;
  // bool isPlaying = false;

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
