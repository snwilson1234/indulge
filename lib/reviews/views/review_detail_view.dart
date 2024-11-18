import 'package:flutter/cupertino.dart';
import 'package:indulge/common/star_widget.dart';
import 'package:indulge/common/static_star_widget.dart';
import 'package:indulge/reviews/viewmodels/review_view_model.dart';
import 'package:indulge/reviews/widgets/review_editor_widget.dart';


class ReviewDetailView extends StatelessWidget {
  final ReviewViewModel reviewViewModel;

  final TextEditingController _reviewController = TextEditingController();

  ReviewDetailView({super.key, required this.reviewViewModel});
  
  @override
  Widget build(BuildContext context) {
    final restaurantName = reviewViewModel.restaurantName; 
    final rating = reviewViewModel.rating; 
    final comment = reviewViewModel.comment;
    _reviewController.text = comment!;
    print("COMMENT: $comment");   
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Reviewing $restaurantName",
          style: TextStyle(
            color: CupertinoColors.black,
          ),
        ),
        backgroundColor: CupertinoColors.white,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
        color: CupertinoColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Update your rating:",
              style: TextStyle(
                fontSize: 30,
                color: CupertinoColors.black,
              ),
            ),
            const SizedBox(height: 20.0),
            IconTheme(
              data: const IconThemeData(
                color: CupertinoColors.black,
                size: 40.0
              ), 
              child: 
              StaticStarWidget(rating: rating!)
              // StarWidget(
              //   initialRating: rating!,
              //   onRatingChanged: (rating) {
              //     print("test");
              //   },
              // )
            ),
            const SizedBox(height: 30.0),
            const Text(
              "Redescribe your experience:",
              style: TextStyle(
                fontSize: 30,
                color: CupertinoColors.black,
              ),
            ),
            const SizedBox(height: 10.0),
            ReviewEditorWidget(
              initialComment: comment!,
              controller: _reviewController,
            ),
            const SizedBox(height: 50.0),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  CupertinoButton(
                    color: CupertinoColors.black,
                    onPressed: () {
                      print("pressed submit!");
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  CupertinoButton(
                    color: CupertinoColors.inactiveGray,
                    onPressed: () {
                      print("pressed cancel!");
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
  
}