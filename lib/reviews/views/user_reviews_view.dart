
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:indulge/reviews/viewmodels/review_view_model.dart';
import 'package:indulge/reviews/viewmodels/reviews_view_model.dart';
import 'package:indulge/reviews/widgets/review_item_widget.dart';
import 'package:indulge/reviews/widgets/review_list_widget.dart';
import 'package:provider/provider.dart';

class UserReviewsView extends StatefulWidget {
  const UserReviewsView({super.key});

  @override
  _UserReviewsViewState createState() => _UserReviewsViewState();
}

class _UserReviewsViewState extends State<UserReviewsView> {
  
  @override
  void initState() {
    super.initState();
    Provider.of<ReviewsViewModel>(context, listen: false).fetchReviewsJson();
  }
  
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ReviewsViewModel>(context);
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
        CupertinoSearchTextField(
          controller: TextEditingController(text: 'helloworld'),
        ),
        Expanded(
          child: ReviewListWidget(
            reviews: vm.reviews
          ),
        )
      ],
    );
  }
  
}