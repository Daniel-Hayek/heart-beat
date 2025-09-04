import 'package:dio/dio.dart';
import 'package:heart_beat_client/services/api_service.dart';

class JournalRepository {
  final ApiService _apiService = ApiService();

  Future<String> createJournal({
    required String content,
    required int id,
    required String token,
  }) async {
    try {
      await _apiService.client.get(
        '/journals',
        queryParameters: {
          'userId': id,
          'title': 'My Journal Entry',
          'content': content,
        },
        options: Options(headers: {'Authorization': token}),
      );

      return "Journal saved successfully";
    } catch (e) {
      throw Exception(e);
    }
  }
}
