import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/models/device_data.dart';
import 'package:heart_beat_client/services/api_service.dart';

class DeviceDataRepository {
  final ApiService _apiService = ApiService();

  Future<String> logData({
    required int id,
    required double sleepDuration,
    required double activityLevel,
    required double steps,
    required double heartrate,
    required int predictedStress,
    required String token,
  }) async {
    try {
      final response = await _apiService.client.post(
        '/device-data',
        data: {
          'userId': id,
          'sleep_duration': sleepDuration,
          "heartrate": heartrate,
          "activity_level": activityLevel,
          "steps": steps,
          "phone_usage": 230,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      debugPrint(response.statusCode.toString());

      return "Data logged successfully";
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<DeviceData>> fetchData(String token, int userId) async {
    try {
      final response = await _apiService.client.get(
        '/device-data/user/$userId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final data = response.data as List;

      debugPrint("=======================================");
      debugPrint("Data fetched for $userId");
      debugPrint("=======================================");

      return data.map((json) => DeviceData.fromJson(json)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
