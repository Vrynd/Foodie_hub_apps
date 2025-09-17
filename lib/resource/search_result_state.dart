import 'package:restaurant_app/data/models/request/request.dart';

sealed class RestaurantSearchResultState {}

class SearchNoneState extends RestaurantSearchResultState {}

class SearchLoadingState extends RestaurantSearchResultState {}

class SearchErrorState extends RestaurantSearchResultState {
  final String error;

  SearchErrorState(this.error);
}

class SearchLoadedState extends RestaurantSearchResultState {
  final List<RestaurantList> data;

  SearchLoadedState(this.data);
}
