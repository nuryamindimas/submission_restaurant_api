import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:submission_restaurant_with_api/common/navigation.dart';
import 'package:submission_restaurant_with_api/data/model/list_restaurant.dart';
import 'package:submission_restaurant_with_api/ui/restaurant_detail/restaurant_detail_page.dart';

final Color primaryColor = Color(0xFFFFFFFF);
final Color secondaryColor = Color(0xFF6B38FB);

class CardRestaurants extends StatelessWidget{
  final Restaurant restaurant;

  const CardRestaurants({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    String pictureId = restaurant.pictureId;
    return Material(
      color: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
          ),
          shadowColor: Colors.black54,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            leading: Hero(
              tag: pictureId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/small/$pictureId",fit: BoxFit.fill,errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                  return const Text('ð¢');
                },
                  width: 100,
                ),
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(restaurant.name),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.star_rate, size: 15,),
                      Text(restaurant.rating.toString(), style: TextStyle(
                          fontSize: 15
                      ),),
                    ],
                  ),
                ),
              ],
            ),
            subtitle: Text(restaurant.city),
            onTap: ()=>Navigation.intentWithData(RestaurantDetailPage.routeName,restaurant.id),
          ),
        ),
      ),
    );
  }

}