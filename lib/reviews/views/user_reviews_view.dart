
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge/reviews/widgets/review_item_widget.dart';

class UserReviewsView extends StatefulWidget {
  const UserReviewsView({Key? key}) : super(key : key);

  @override
  State<UserReviewsView> createState() => _DefaultState();
}

class _DefaultState extends State<UserReviewsView> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "My Reviews",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        Divider(),
        // TODO: make this functional
        CupertinoSearchTextField(
          controller: TextEditingController(text: 'helloworld'),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: 20,
            itemBuilder: (context, index) {
              return ReviewItemWidget();
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          ),
        )
      ],
    );
  }
  
}