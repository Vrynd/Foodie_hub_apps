import 'package:restaurant_app/data/models/request/request.dart';

class RestaurantSearchResponse {
  bool error;
  int founded;
  List<RestaurantList> restaurants;

  RestaurantSearchResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantSearchResponse(
      error: json["error"],
      founded: json["founded"],
      restaurants: List<RestaurantList>.from(
        json["restaurants"].map((x) => RestaurantList.fromJson(x)),
      ),
    );
  }
}