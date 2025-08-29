import 'package:flutter/material.dart';

class NavProvider extends ChangeNotifier {
  int _currentIndex = 2;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;

    notifyListeners();
  }
}
