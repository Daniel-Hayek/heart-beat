import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/models/playlist.dart';
import 'package:heart_beat_client/services/api_service.dart';

class PlaylistRepository {
  final _apiService = ApiService();

  Future<List<Playlist>> getAllPlaylists(String token, int userId) async {
    try {
      final response = await _apiService.client.get(
        '/playlist/$userId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      debugPrint("=======================================");
      debugPrint("Playlists fetched for $userId");
      debugPrint("=======================================");

      final data = response.data as List;

      return data.map((json) => Playlist.fromJson(json)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
