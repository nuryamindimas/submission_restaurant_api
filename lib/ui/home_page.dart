import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:submission_restaurant_with_api/provider/search_restaurant_provider.dart';
import 'package:submission_restaurant_with_api/ui/restaurant_list_page.dart';
import 'package:submission_restaurant_with_api/ui/search_restaurant_page.dart';
class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearching= false;
  final myController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.addListener(_onSearchTextChange);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.removeListener(_onSearchTextChange);
    myController.dispose();
    super.dispose();
  }

  void _onSearchTextChange() {
    final text = myController.text;
    print(text);
    Provider.of<SearchRestaurantProvider>(context, listen: false).fetchAllRestaurant(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching? Text('Restaurant')
            :TextField(
            controller: myController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                icon: Icon(Icons.search, color: Colors.white,),
                hintText: "Search Restaurant Here",
                hintStyle: TextStyle(color: Colors.white)
          ),
        ),
        actions: <Widget>[
          isSearching?
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: (){
              setState((){
                this.isSearching = false;
              });
            },
          ) :
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              print("Pressed");
              setState((){
                this.isSearching = true;
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            !isSearching ?
            RestaurantListPage() :
            SearchRestaurantPage()
          ],
        ),
      ),
    );
  }

}

