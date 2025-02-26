import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wonderfood/data/model/restaurant_detail_response.dart';
import 'package:wonderfood/data/model/restaurant_list_response.dart';
import 'package:wonderfood/data/model/restaurant_review_request.dart';
import 'package:wonderfood/data/model/restaurant_review_response.dart';
import 'package:wonderfood/data/model/restaurant_search_response.dart';

class ApiServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<RestaurantSearchResponse> searchRestaurantList(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));

    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to search restaurant');
    }
  }

  Future<RestaurantReviewResponse> postRestaurantReview(
      RestaurantReviewRequest review) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/review"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(review.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return RestaurantReviewResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to review restaurant');
    }
  }
}
