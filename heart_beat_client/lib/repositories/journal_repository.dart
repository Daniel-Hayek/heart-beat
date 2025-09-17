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

  Future<List<Journal>> getJournals(String token, int id) async {
    try {
      final response = await _apiService.client.get(
        '/journals/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final data = response.data as List;

      debugPrint("=======================================");
      debugPrint("Journals fetched for $id");
      debugPrint("=======================================");

      return data.map((json) => Journal.fromJson(json)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> deleteJournals({
    required String token,
    required int journalId,
  }) async {
    try {
      final response = await _apiService.client.delete(
        '/journals/$journalId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Journal> getLatest({
    required String token,
    required int userId,
  }) async {
    try {
      final response = await _apiService.client.get(
        '/journals/latest/$userId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return Journal.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> getNumber({required String token, required int userId}) async {
    try {
      final response = await _apiService.client.get(
        '/journals/number/$userId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
