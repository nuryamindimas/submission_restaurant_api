import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:submission_restaurant_with_api/data/api/api_service.dart';
import 'package:submission_restaurant_with_api/data/model/detail_restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error, NoInternet}

class DetailRestaurantProvider extends ChangeNotifier{
  final ApiService apiService;
  final String id;

  DetailRestaurantProvider({required this.apiService, required this.id}){
    _fetchDetailRestaurant();
  }

  late DetailRestaurant? _detailRestaurant;
  String _message = '';
  late ResultState? _state;

  DetailRestaurant get list => _detailRestaurant!;
  String get message => _message;
  ResultState get state => _state!;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await ApiService().detailRestaurants(id);
      if(restaurant.error){
        _state = ResultState.NoData;
        notifyListeners();
        return _message = restaurant.message;
      }else{
        _state = ResultState.HasData;
        notifyListeners();
        return _detailRestaurant = restaurant;
      }
    }on SocketException catch(e){
      _state = ResultState.NoInternet;
      notifyListeners();
      return _message ='Error --> $e';
    }catch(e){
      _state = ResultState.Error;
      notifyListeners();
      return _message ='Error --> $e';
    }
  }
}