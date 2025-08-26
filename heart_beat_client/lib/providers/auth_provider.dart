class AuthProvider extends ChangeNotifier {
  String? _token;
  String? _userEmail;

  String? get token => _token;
  bool get isLoggedIn => _token != null;

  void login (String token, String email) {
    _token = token;
    _userEmail = email;
    notifyListeners();
  }

  void logout () {
    _token = null;
    _userEmail = null;
    notifyListeners();
  }
}