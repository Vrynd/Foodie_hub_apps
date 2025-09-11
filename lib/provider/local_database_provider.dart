import 'package:flutter/material.dart';
import 'package:restaurant_app/data/database/local_database_service.dart';
import 'package:restaurant_app/data/models/request/request.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final LocalDatabaseService _service;
  LocalDatabaseProvider(this._service);

  String _message = "";
  String get message => _message;

  List<RestaurantList>? _restaurantList;
  List<RestaurantList>? get restaurantList => _restaurantList;

  RestaurantList? _restaurant;
  RestaurantList? get restaurant => _restaurant;

  Future<void> addFavorite(RestaurantList value) async {
    try {
      final result = await _service.insertItem(value);

      final isError = result == 0;
      if (isError) {
        _message = "Failed to save your data";
      } else {
        _message = "Your data is saved";
      }
    } catch (e) {
      _message = "Failed to save your data";
    }
    notifyListeners();
  }

  Future<void> loadRestaurantById(int id) async {
    try {
      _restaurant = await _service.getItemById(id);
      _message = "Your data is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your data";
      notifyListeners();
    }
  }

  Future<void> removeRestaurantById(int id) async {
    try {
      await _service.removeItem(id);

      _message = "Your data is removed";
      notifyListeners();
    } catch (e) {
      _message = "Failed to remove your data";
      notifyListeners();
    }
  }

}
