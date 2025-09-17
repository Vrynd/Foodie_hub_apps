import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/resource/search_result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService _apiServices;
  RestaurantSearchProvider(this._apiServices);

  RestaurantSearchResultState _resultState = SearchNoneState();
  RestaurantSearchResultState get resultState => _resultState;

  Future<void> searchRestaurant(String query) async {
    try {
      _resultState = SearchLoadingState();
      notifyListeners();

      final result = await _apiServices.searchRestaurant(query);
      if (result.error) {
        _resultState = SearchErrorState("No restaurants found");
      } else {
        _resultState = SearchLoadedState(result.restaurants);
      }
      notifyListeners();
    } on Exception catch (e) {
      _resultState = SearchErrorState(e.toString());
      notifyListeners();
    }
  }

  void resetSearch() {
    _resultState = SearchNoneState();
    notifyListeners();
  }
}
