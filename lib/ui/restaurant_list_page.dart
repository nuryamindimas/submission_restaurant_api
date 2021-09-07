import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_restaurant_with_api/provider/list_restaurant_provider.dart';
import 'package:submission_restaurant_with_api/widget/card_restaurant.dart';

class RestaurantListPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Consumer<ListRestaurantProvider>(
      builder: (context, state, _){
        if(state.state==ResultState.Loading){
          return Center(child: CircularProgressIndicator(),);
        }else if(state.state==ResultState.HasData){
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.list.restaurants.length,
            itemBuilder: (context, index){
              var restaurant = state.list.restaurants[index];
              return CardRestaurants(restaurant: restaurant);
            },
          );
        }else if (state.state == ResultState.NoData) {
          return Container(
            height: 400,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 200,),
                Center(child: Text('Data Tidak Ditemukan', style: TextStyle(fontSize: 20),)),
              ],
            ),
          );
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else if (state.state==ResultState.NoInternet){
          return Container(
            height: 400,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.network_check, size: 200,),
                Center(child: Text('Tidak ada koneksi', style: TextStyle(fontSize: 20),)),
              ],
            ),
          );
        }else{
          return Center(child: Text(''));
        }
      },
    );
  }
}
