import 'package:flutter/material.dart';
import 'package:submission_restaurant_with_api/data/api/api_service.dart';
import 'package:submission_restaurant_with_api/ui/restaurant_detail/restaurant_detail_page.dart';

class ReviewForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final myControllerName = TextEditingController();
  final myControllerReview = TextEditingController();
  final ApiService apiService = ApiService();
  final String id;
  ReviewForm({required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white24,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        content: Stack(
          children: <Widget>[
            Positioned(
              right: -40.0,
              top: -40.0,
              child: InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: CircleAvatar(
                  child: Icon(Icons.close),
                  backgroundColor: Colors.red,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: myControllerName,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Masukan Nama anda',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: myControllerReview,
                      decoration: InputDecoration(
                        icon: Icon(Icons.message),
                        hintText: 'Beri Review',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text("Submitß"),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                        apiService.postReview(id, myControllerName.text, myControllerReview.text);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                          return RestaurantDetailPage(id: id);
                        }));
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
