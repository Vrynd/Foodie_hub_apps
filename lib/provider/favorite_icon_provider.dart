import 'package:flutter/material.dart';

class FavoriteIconProvider extends ChangeNotifier {
  bool _isFavorited = false;

  bool get isFavorites => _isFavorited;

  set isFavorite(bool value) {
    _isFavorited = value;
    notifyListeners();
  }
}
