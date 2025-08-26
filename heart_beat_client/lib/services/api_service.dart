import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    final baseURL = dotenv.env['API_URL'];
    final port = dotenv.env['BASE_PORT'];

    _dio = Dio(
      BaseOptions(
        baseUrl: '$baseURL:$port',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
  }

  Dio get client => _dio;
}
