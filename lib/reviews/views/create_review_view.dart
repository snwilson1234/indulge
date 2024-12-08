import 'package:flutter/cupertino.dart';
import 'package:indulge/common/star_widget.dart';
import 'package:indulge/lists/models/dummy_restaurant.dart';
import 'package:indulge/lists/viewmodels/dummy_restaurant_view_model.dart';
import 'package:indulge/lists/viewmodels/lists_view_model.dart';
import 'package:indulge/reviews/models/review.dart';
import 'package:indulge/reviews/viewmodels/reviews_view_model.dart';
import 'package:indulge/reviews/widgets/review_editor_widget.dart';

import 'package:provider/provider.dart';


class CreateReviewView extends StatefulWidget {
  const CreateReviewView({super.key});

  @override
  State<CreateReviewView> createState() => _CreateReviewViewState();
}


class _CreateReviewViewState extends State<CreateReviewView> {
  int _selectedRestaurant = 0;
  double _rating = 0.0;

  TextEditingController _reviewController = TextEditingController();

  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ListsViewModel>(context, listen: false).fetchLists();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ListsViewModel>(context);
    final beenThereList = vm.lists[0];
    final alreadyReviwedList = beenThereList.listItems
        ?.where((item) => item.reviewed == 0)
        .toList() ?? [];

    if (alreadyReviwedList.isEmpty) {
      return const CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("New Review"),
          backgroundColor: CupertinoColors.white,
        ),
        child: Center(
          child: Text("There are no more restaurants to review. Get swiping!"),
        )
      );
    }

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          "New Review",
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
              "Selected:",
              style: TextStyle(
                color: CupertinoColors.black,
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _showDialog(
                CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32.0,
                  // This sets the initial item.
                  scrollController: FixedExtentScrollController(
                    initialItem: 0,
                  ),
                  // This is called when selected item is changed.
                  onSelectedItemChanged: (int selectedItem) {
                    setState(() {
                      _selectedRestaurant = selectedItem;
                    });
                  },
                  children:
                      List<Widget>.generate(alreadyReviwedList!.length, (int index) {
                    return Center(child: Text(alreadyReviwedList[index].restaurantName!));
                  }),
                ),
              ),
              // This displays the selected restaurant name.
              child: Text(
                alreadyReviwedList![_selectedRestaurant].restaurantName!,
                style: const TextStyle(
                  fontSize: 22.0,
                ),
              ),
            ),
            const Text(
              "Choose your rating:",
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
              child: StarWidget(
                initialRating: _rating,
                onRatingChanged: (rating) {
                  print("Changing rating in create reivew view $rating");
                  setState(() {
                    _rating = rating;
                  });
                }
              )
            ),
            const SizedBox(height: 30.0),
            const Text(
              "Describe your experience:",
              style: TextStyle(
                fontSize: 30,
                color: CupertinoColors.black,
              ),
            ),
            const SizedBox(height: 10.0),
            ReviewEditorWidget(
              initialComment: "",
              controller: _reviewController
            ),
            const SizedBox(height: 50.0),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  CupertinoButton(
                    color: CupertinoColors.black,
                    onPressed: () {
                      final review = Review.withParams(
                        restaurantId: alreadyReviwedList[_selectedRestaurant].id,
                        restaurantName: alreadyReviwedList[_selectedRestaurant].restaurantName,
                        rating: _rating,
                        comment: _reviewController.text,
                      );
                      final reviewsViewModel = Provider.of<ReviewsViewModel>(context, listen: false);
                      reviewsViewModel.submitReview(review);
                      DummyRestaurant restaurant = alreadyReviwedList[_selectedRestaurant];
                      restaurant.reviewed = 1;
                      Provider.of<DummyRestaurantViewModel>(context, listen: false).updateRestaurant(restaurant);
                      Provider.of<ReviewsViewModel>(context, listen: false).fetchReviews();
                      Navigator.of(context).pop();
                      print("submitted review!");
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  CupertinoButton(
                    color: CupertinoColors.inactiveGray,
                    onPressed: () {
                      // go back to reviews page
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.white
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