import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:submission_restaurant_with_api/data/api/api_service.dart';
import 'package:submission_restaurant_with_api/data/model/search_restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error, Idle, NoInternet }

class SearchRestaurantProvider extends ChangeNotifier{
  final ApiService apiService;
  SearchRestaurantProvider({required this.apiService});
  SearchRestaurant _searchRestaurant = SearchRestaurant(error: false, founded: 0, restaurants: []);
  String _message = '';
  ResultState _state = ResultState.Idle;

  SearchRestaurant get list => _searchRestaurant;
  String get message => _message;
  ResultState get state => _state;

  Future<dynamic> fetchAllRestaurant(String key) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await ApiService().searchRestaurants(key);
      if(restaurant.restaurants.isEmpty){
        _state = ResultState.NoData;
        notifyListeners();
        return _message = "Empty Data";
      }else{
        _state = ResultState.HasData;
        notifyListeners();
        return _searchRestaurant = restaurant;
      }
    }on SocketException catch(e){
      _state = ResultState.NoInternet;
      notifyListeners();
      return _message ='Error --> $e';
    }catch(e){
      print(e);
      _state = ResultState.Error;
      notifyListeners();
      return _message ='Error --> $e';
    }
  }
}