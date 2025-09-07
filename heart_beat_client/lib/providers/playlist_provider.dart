import 'package:flutter/material.dart';
import 'package:heart_beat_client/models/playlist.dart';

class PlaylistProvider extends ChangeNotifier {
  List<Playlist> _playlists = [];

  List<Playlist> get playlists => _playlists;
}
