import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/models/song.dart';
import 'package:heart_beat_client/services/api_service.dart';

class SongRepository {
  final _apiService = ApiService();

  Future<Song> getSong({required int id, required String token}) async {
    try {
      final response = await _apiService.client.get(
        '/songs/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      debugPrint(response.data.toString());

      return Song.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Song>> getAllSongs({required String token}) async {
    try {
      final response = await _apiService.client.get(
        '/songs',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final data = response.data as List;

      return data.map((json) => Song.fromJson(json)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Song>> getPlaylistSongs({
    required String token,
    required int playlistId,
  }) async {
    try {
      final response = await _apiService.client.get(
        '/playlist-song/$playlistId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final data = response.data as List;

      return data.map((json) => Song.fromJson(json)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
