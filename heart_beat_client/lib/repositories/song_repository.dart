import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/services/api_service.dart';

class SongRepository {
  final _apiService = ApiService();

  Future<String> getSong({required int id, required String token}) async {
    try {
      final response = await _apiService.client.get(
        '/songs/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      debugPrint(response.data.toString());

      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
