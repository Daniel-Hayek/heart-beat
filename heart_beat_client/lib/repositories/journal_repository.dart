import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/models/journal.dart';
import 'package:heart_beat_client/services/api_service.dart';

class JournalRepository {
  final ApiService _apiService = ApiService();

  Future<String> createJournal({
    required String content,
    required int id,
    required String token,
  }) async {
    try {
      final response = await _apiService.client.post(
        '/journals',

        data: {'userId': id, 'title': 'My Journal Entry', 'content': content},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      debugPrint(response.statusCode.toString());

      return "Journal saved successfully";
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Journal>> getJournals({
    required String token,
    required int id,
  }) async {
    try {
      final response = await _apiService.client.get(
        '/journals',
        queryParameters: {'id': id},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final data = response.data as List;

      return data.map((json) => Journal.fromJson(json)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
