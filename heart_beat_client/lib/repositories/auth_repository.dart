import 'package:dio/dio.dart';
import 'package:heart_beat_client/services/api_service.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.client.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw Exception(e.response?.data['message'] ?? 'Login failed');
      }

      throw Exception('Login failed: $e');
    }
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.client.post(
        '/auth/register',
        data: {'name': name, 'email': email, 'password': password},
      );

      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw Exception(e.response?.data['message'] ?? 'Registeration failed');
      }

      throw Exception('Registration failed: $e');
    }
  }
}
