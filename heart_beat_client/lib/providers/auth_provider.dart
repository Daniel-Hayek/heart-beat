import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();

  String? _token;
  String? _userName;
  bool _isLoading = true;

  String? get token => _token;
  String? get userName => _userName;
  bool get isLoggedIn => _token != null;
  bool get isLoading => _isLoading;

  // AuthProvider {
  //   loadName();
  // }

  Future<String?> loadToken() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 200));
    _token = await _storage.read(key: 'auth_token');

    if (_token != null) {
      _userName = JwtDecoder.decode(_token!)['name'];
    } else {
      _token = null;
      _userName = null;
    }

    _isLoading = false;

    notifyListeners();

    return _token;
  }

  // String loadName() {
  //   _userName = JwtDecoder.decode(_token!)['name'];

  //   notifyListeners();

  //   return _userName!;
  // }

  void login(String token) async {
    _token = token;
    _userName = JwtDecoder.decode(_token!)['name'];

    await _storage.write(key: 'auth_token', value: token);

    notifyListeners();
  }

  void logout() async {
    _token = null;
    _userName = null;

    await _storage.delete(key: 'auth_token');
    //_userEmail = null;
    notifyListeners();
  }
}
