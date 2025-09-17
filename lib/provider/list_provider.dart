import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/resource/list_result_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService _apiServices;
  RestaurantListProvider(this._apiServices);

  RestaurantListResultState _resultState = ListNoneState();
  RestaurantListResultState get resultState => _resultState;

  Future<void> fetchRestaurantList() async {
    try {
      _resultState = ListLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantList();
      if (result.error) {
        _resultState = ListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = ListLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = ListErrorState(e.toString());
      notifyListeners();
    }
  }
}
