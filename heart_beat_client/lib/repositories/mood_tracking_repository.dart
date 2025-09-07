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
      );

      if (response.statusCode == 201) {
        debugPrint('Mood tracked successfully');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
