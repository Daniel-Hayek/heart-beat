import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();

  String? _token;
  String? _userEmail;

  String? get token => _token;
  bool get isLoggedIn => _token != null;

  Future<String?> loadToken() async {
    _token = await _storage.read(key: 'auth_token');

    notifyListeners();

    return _token;
  }

  void login(String token) async {
    _token = token;
    //_userEmail = email;
    await _storage.write(key: 'auth_token', value: token);

    notifyListeners();
  }

  void logout() async {
    _token = null;

    await _storage.delete(key: 'auth_token');
    //_userEmail = null;
    notifyListeners();
  }
}
