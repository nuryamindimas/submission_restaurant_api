import 'dart:convert';

import 'package:submission_restaurant_with_api/data/model/list_restaurant.dart';

SearchRestaurant searchRestaurantFromJson(String str) => SearchRestaurant.fromJson(json.decode(str));

class SearchRestaurant {
  SearchRestaurant({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<Restaurant> restaurants;

  factory SearchRestaurant.fromJson(Map<String, dynamic> json) => SearchRestaurant(
    error: json["error"],
    founded: json["founded"],
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );

}

