import 'package:flutter/material.dart';
import 'package:heart_beat_client/models/playlist.dart';

class PlaylistProvider extends ChangeNotifier {
  List<Playlist> _playlists = [];
  int _activePlaylist = 0;

  List<Playlist> get playlists => _playlists;
  int get activePlaylist => _activePlaylist;

  void setPlaylists(List<Playlist> list) {
    _playlists = list;

    notifyListeners();
  }

  void setActivePlaylist(int activeId) {
    _activePlaylist = activeId;

    notifyListeners();
  }
}
