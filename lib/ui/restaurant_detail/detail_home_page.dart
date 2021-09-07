import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:submission_restaurant_with_api/data/model/detail_restaurant.dart';
import 'package:submission_restaurant_with_api/provider/detail_restaurant_provider.dart';
import 'package:submission_restaurant_with_api/widget/review_form.dart';

class DetailHomePage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Consumer<DetailRestaurantProvider>(
      builder: (context, state, _){
        if(state.state==ResultState.Loading){
          return Center(child: CircularProgressIndicator(),);
        }else if(state.state==ResultState.HasData){
          return _buildDetail(state.list.restaurant, state.id);
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
        }else if (state.state==ResultState.NoInternet){
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
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  Widget _buildDetail(RestaurantDetail restaurantDetail, String id){
    return NestedScrollView(
      headerSliverBuilder: (context, isScrolled){
        return [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            title: Text(restaurantDetail.name),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned.fill(
                    child: Stack(
                      children: [
                        Container(
                          child: Hero(
                              tag: restaurantDetail.pictureId,
                              child: Image.network(
                                'https://restaurant-api.dicoding.dev/images/medium/'+restaurantDetail.pictureId,
                                fit: BoxFit.cover,
                              )
                          ),
                          width: double.infinity,
                          height: 400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ];
      },
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index){
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.black12,
                    child: Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.location_on),
                                          Text(restaurantDetail.city, style: Theme.of(context).textTheme.headline6,)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.star_rate),
                                          Text(restaurantDetail.rating.toString(), style: Theme.of(context).textTheme.headline6),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(color:Colors.grey),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Category : ', style: GoogleFonts.merriweather(
                                          fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15),),
                                    ),
                                    Row(
                                      children: restaurantDetail.categories.map((category) {
                                        return Container(
                                          width: 80,
                                          child: Card(
                                              color: Colors.white12,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(category.name, textAlign: TextAlign.center,),
                                          )),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                                Divider(color:Colors.grey),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(restaurantDetail.description,
                                    textAlign:TextAlign.justify,
                                    style: Theme.of(context).textTheme.bodyText1),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Container(
                              child: Center(
                                  child: Text('Review', style: Theme.of(context).textTheme.headline6,)),
                              width: double.infinity,
                              padding: EdgeInsets.all(8.0),
                            ),
                            shadowColor: Colors.black,
                          ),
                        ),
                        Column(
                          children: restaurantDetail.customerReviews.map((review) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(review.name),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(review.date, textAlign: TextAlign.right),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Flexible(child: Text(review.review)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        TextButton(
                            onPressed: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                return ReviewForm(id: id);
                              }));
                            },
                            child: Text('Tambah Review'))
                      ],
                    ),
                  );
                },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
  
}

