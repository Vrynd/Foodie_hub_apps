import 'package:flutter/material.dart';

class IndexNavProvider extends ChangeNotifier {
  int _indexBottomNavBar = 0;

  int get indexBottomNavBar => _indexBottomNavBar;

  set indextBottomNavBar(int value) {
    _indexBottomNavBar = value;
    notifyListeners();
  }
}
