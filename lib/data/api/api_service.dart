import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:restaurant_app/data/models/response/detail_response.dart';
import 'package:restaurant_app/data/models/response/response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestaurantListResponse> getRestaurantList() async {
    try {
      final response = await http
          .get(Uri.parse("$_baseUrl/list"))
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        return RestaurantListResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load restaurant list');
      }
    } on SocketException {
      throw Exception("No Internet Connection. Please check your network.");
    } on TimeoutException {
      throw Exception("Connection Timeout. Please try again later.");
    } catch (e) {
      rethrow;
    }
  }

  Future<RestaurantDetailResponse> getDetailRestaurant(String id) async {
    try {
      final response = await http
          .get(Uri.parse("$_baseUrl/detail/$id"))
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load restaurant detail for id: $id');
      }
    } on SocketException {
      throw Exception("No Internet Connection. Please check your network.");
    } on TimeoutException {
      throw Exception("Connection Timeout. Please try again later.");
    } catch (e) {
      rethrow;
    }
  }
}
