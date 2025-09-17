import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class N8nService {
  late final Dio _dio;

  N8nService() {
    final baseURL = dotenv.env['N8N_URL'];
    final port = dotenv.env['N8N_PORT'];

    _dio = Dio(
      BaseOptions(
        baseUrl: '$baseURL:$port',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );
  }

  Dio get client => _dio;
}