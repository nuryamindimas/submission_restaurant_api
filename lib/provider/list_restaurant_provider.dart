import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:submission_restaurant_with_api/data/api/api_service.dart';
import 'package:submission_restaurant_with_api/data/model/list_restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error, NoInternet}

class ListRestaurantProvider extends ChangeNotifier{
  final ApiService apiService;
  ListRestaurantProvider({required this.apiService}){
    _fetchAllRestaurant();
  }

  late ListRestaurant? _listRestaurant;
  String _message = '';
  late ResultState? _state;

  ListRestaurant get list => _listRestaurant!;
  String get message => _message;
  ResultState get state => _state!;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await ApiService().listRestaurants();
      if(restaurant.restaurants.isEmpty){
        _state = ResultState.NoData;
        notifyListeners();
        return _message = "Empty Data";
      }else{
        _state = ResultState.HasData;
        notifyListeners();
        return _listRestaurant = restaurant;
      }
    }on SocketException catch(e){
      _state = ResultState.NoInternet;
      notifyListeners();
      return _message ='Error --> $e';
    }on HandshakeException catch(e){
      _state = ResultState.NoInternet;
      notifyListeners();
      return _message ='Error --> $e';
    } catch(e){
      _state = ResultState.Error;
      notifyListeners();
      return _message ='Error --> $e';
    }
  }


}