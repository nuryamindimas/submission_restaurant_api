import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_restaurant_with_api/data/api/api_service.dart';
import 'package:submission_restaurant_with_api/provider/detail_restaurant_provider.dart';
import 'package:submission_restaurant_with_api/ui/restaurant_detail/detail_drinks_food.dart';
import 'package:submission_restaurant_with_api/ui/restaurant_detail/detail_food_page.dart';
import 'package:submission_restaurant_with_api/ui/restaurant_detail/detail_home_page.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/detail_page';
  final String id;

  const RestaurantDetailPage({required this.id});

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  int _bottomNavIndex = 0;

  List<Widget> _listWidget = [
    DetailHomePage(),
    DetailFoodPage(),
    DetailDrinksPage(),
  ];

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.restaurant_menu),
      label: "Food",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.local_drink),
      label: "Drinks",
    ),

  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }



  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) => DetailRestaurantProvider(apiService: ApiService(), id: widget.id),
      child: Scaffold(
        body: _listWidget[_bottomNavIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomNavIndex,
          items: _bottomNavBarItems,
          onTap: _onBottomNavTapped,
        ),
      ),
    );
  }
}
