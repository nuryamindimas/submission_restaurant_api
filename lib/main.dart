import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_restaurant_with_api/provider/list_restaurant_provider.dart';
import 'package:submission_restaurant_with_api/provider/search_restaurant_provider.dart';
import 'package:submission_restaurant_with_api/ui/home_page.dart';
import 'package:submission_restaurant_with_api/ui/restaurant_detail/restaurant_detail_page.dart';

import 'common/navigation.dart';
import 'data/api/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
        providers: [
        ChangeNotifierProvider<ListRestaurantProvider>(
        create: (_) => ListRestaurantProvider(apiService: ApiService())),
    ChangeNotifierProvider<SearchRestaurantProvider>(
    create: (_) => SearchRestaurantProvider(apiService: ApiService()))
    ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: navigatorKey,
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(id: ModalRoute.of(context)?.settings.arguments as String,),
        },
      ),
    );
  }
}

