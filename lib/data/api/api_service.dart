import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:submission_restaurant_with_api/data/model/detail_restaurant.dart';
import 'package:submission_restaurant_with_api/data/model/list_restaurant.dart';
import 'package:submission_restaurant_with_api/data/model/search_restaurant.dart';

class ApiService{
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<ListRestaurant> listRestaurants() async{
    final response = await http.get(Uri.parse(_baseUrl+"list"));
    if (response.statusCode==200){
      return listRestaurantFromJson(response.body);
    }else{
      throw Exception('Failed to load List of Restaurant');
    }
  }

  Future<SearchRestaurant> searchRestaurants(String key) async{
    final response = await http.get(Uri.parse(_baseUrl+"search?q="+key));
    if (response.statusCode==200){
      return searchRestaurantFromJson(response.body);
    }else{
      throw Exception('Failed to load Search of Restaurant');
    }
  }

  Future<DetailRestaurant> detailRestaurants(String id) async{
    final response = await http.get(Uri.parse(_baseUrl+"detail/$id"));
    if (response.statusCode==200){
      return detailRestaurantFromJson(response.body);
    }else{
      throw Exception('Failed to load detail of Restaurant');
    }
  }

  Future<dynamic> postReview(String id, String name, String review) async{
    String apiURL = "https://restaurant-api.dicoding.dev/review";
    var apiResult = await http.post(
        Uri.parse(apiURL),
        headers: {
          "Content-Type" : "application/json",
          "X-Auth-Token" : "12345",
        },
        body: json.encode({
          "id" : id,
          "name" : name,
          "review" : review,
        })
    );
  }

}