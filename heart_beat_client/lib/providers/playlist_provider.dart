import 'package:flutter/material.dart';
import 'package:heart_beat_client/models/playlist.dart';

class PlaylistProvider extends ChangeNotifier {
  List<Playlist> _playlists = [];
  int _activePlaylistId = 0;
  String _activePlaylistName = '';

  List<Playlist> get playlists => _playlists;
  int get activePlaylistId => _activePlaylistId;
  String get activePlaylistName => _activePlaylistName;

  void setPlaylists(List<Playlist> list) {
    _playlists += list;

    notifyListeners();
  }

  void setActivePlaylist(int activeId, String activeName) {
    _activePlaylistId = activeId;
    _activePlaylistName = activeName;

    notifyListeners();
  }

  void clearPlaylists() {
    _playlists = [];
  }
}
