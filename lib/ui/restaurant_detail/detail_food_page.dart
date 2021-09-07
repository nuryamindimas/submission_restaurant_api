import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_restaurant_with_api/data/model/detail_restaurant.dart';
import 'package:submission_restaurant_with_api/provider/detail_restaurant_provider.dart';


class DetailFoodPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Consumer<DetailRestaurantProvider>(
      builder: (context,state,_){
        if(state.state==ResultState.Loading){
          return Center(child: CircularProgressIndicator(),);
        }else if(state.state==ResultState.HasData){
          return _listFood(state.list.restaurant.menus, Theme.of(context).textTheme);
        }else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }
}

Widget _listFood(Menus menus, TextTheme textTheme){
  return GridView.count(
    crossAxisCount: 2,
    mainAxisSpacing: 16,
    crossAxisSpacing: 16,
    children: menus.foods.map((list){
      return InkWell(
        child: Card(
          child: Column(
            children: [
              Image.asset('images/placeholder.png'),
              Text(list.name, style: textTheme.subtitle1,),
            ],
          ),
        ),
      );
    }).toList()
  );
}
