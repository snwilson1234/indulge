import 'package:flutter/cupertino.dart';
import 'package:indulge/common/star_widget.dart';
import 'package:indulge/reviews/widgets/review_editor_widget.dart';

import 'package:flutter_rating/flutter_rating.dart';


class ReviewDetailView extends StatelessWidget {
  final String restaurantName;

  const ReviewDetailView({Key? key, required this.restaurantName}) : super(key : key);
  
  @override
  Widget build(BuildContext context) {    
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Reviewing $restaurantName"),
      ),
      child: Container(
      color: CupertinoColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Writing a review for:",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            '$restaurantName:',
            style: const TextStyle(
              fontSize: 40,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 10.0),
          const IconTheme(
            data: IconThemeData(
              color: CupertinoColors.black,
              size: 40.0
            ), 
            child: StarWidget()
          ),
          const SizedBox(height: 50.0),
          const ReviewEditorWidget(),
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
                SizedBox(height: 10.0),
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
    ));
  }
  
}