import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:heart_beat_client/models/mood_tracking.dart';
import 'package:heart_beat_client/services/api_service.dart';

class MoodTrackingRepository {
  final _apiService = ApiService();

  void createMoodEntry({
    required String token,
    required int userId,
    required MoodTracking mood,
  }) async {
    try {
      final response = await _apiService.client.post(
        '/mood-tracking',
        data: {
          'userId': userId,
          'source': mood.source,
          'mood': mood.mood,
          'score': mood.score,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 201) {
        debugPrint('Mood tracked successfully');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<MoodTracking>> getUserMoods(String token, int userId) async {
    try {
      final response = await _apiService.client.get(
        '/mood-tracking/$userId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final moods = response.data as List;

      return moods.map((json) => MoodTracking.fromJson(json)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
