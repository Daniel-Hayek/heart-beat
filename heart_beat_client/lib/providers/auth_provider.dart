import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();

  String? _token;
  String? _userName;

  String? get token => _token;
  bool get isLoggedIn => _token != null;

  Future<String?> loadToken() async {
    _token = await _storage.read(key: 'auth_token');

    notifyListeners();

    return _token;
  }

  String loadName() {
    _userName = JwtDecoder.decode(_token!)['name'];

    notifyListeners();

    return _userName!;
  }

  void login(String token) async {
    _token = token;
    //_userEmail = email;
    await _storage.write(key: 'auth_token', value: token);

    _userName = JwtDecoder.decode(token)['name'];

    notifyListeners();
  }

  void logout() async {
    _token = null;

    await _storage.delete(key: 'auth_token');
    //_userEmail = null;
    notifyListeners();
  }
}
