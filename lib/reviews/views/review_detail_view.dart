import 'package:flutter/cupertino.dart';
import 'package:indulge/common/star_widget.dart';
import 'package:indulge/reviews/viewmodels/review_view_model.dart';
import 'package:indulge/reviews/widgets/review_editor_widget.dart';


class ReviewDetailView extends StatelessWidget {
  final ReviewViewModel reviewViewModel;

  const ReviewDetailView({super.key, required this.reviewViewModel});
  
  @override
  Widget build(BuildContext context) {
    final restaurantName = "test";//reviewViewModel.restaurantName; 
    final rating = 1.0;//reviewViewModel.rating; 
    final comment = "test";//reviewViewModel.comment;    
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Reviewing $restaurantName"),
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
              ),
            ),
            const SizedBox(height: 20.0),
            IconTheme(
              data: const IconThemeData(
                color: CupertinoColors.black,
                size: 40.0
              ), 
              child: StarWidget(
                initialRating: rating
              )
            ),
            const SizedBox(height: 30.0),
            const Text(
              "Redescribe your experience:",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 10.0),
            ReviewEditorWidget(
              initialComment: comment
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