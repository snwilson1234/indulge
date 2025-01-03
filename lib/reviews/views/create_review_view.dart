import 'package:flutter/cupertino.dart';
import 'package:indulge/common/star_widget.dart';
import 'package:indulge/common/theme.dart';
import 'package:indulge/lists/viewmodels/lists_view_model.dart';
import 'package:indulge/restaurant/models/restaurant.dart';
import 'package:indulge/restaurant/viewmodels/restaurant_view_model.dart';
import 'package:indulge/reviews/models/review.dart';
import 'package:indulge/reviews/viewmodels/reviews_view_model.dart';
import 'package:indulge/reviews/widgets/review_editor_widget.dart';
import 'package:indulge/user/view_models/user_view_model.dart';

import 'package:provider/provider.dart';


class CreateReviewView extends StatefulWidget {
  const CreateReviewView({super.key});

  @override
  State<CreateReviewView> createState() => _CreateReviewViewState();
}


class _CreateReviewViewState extends State<CreateReviewView> {
  int _selectedRestaurant = 0;
  double _rating = 0.0;

  final TextEditingController _reviewController = TextEditingController();

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
        color: CupertinoColors.black,
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
        navigationBar: CupertinoNavigationBar(
          middle: Text("New Review"),
          backgroundColor: CupertinoColors.black,
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
            color: CupertinoColors.white,
          ),
        ),
        backgroundColor: CupertinoColors.black,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
        color: CupertinoColors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Selected:",
              style: TextStyle(
                color: CupertinoColors.white,
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
                      List<Widget>.generate(alreadyReviwedList.length, (int index) {
                    return Center(child: Text(alreadyReviwedList[index].name));
                  }),
                ),
              ),
              // This displays the selected restaurant name.
              child: Text(
                alreadyReviwedList[_selectedRestaurant].name,
                style: const TextStyle(
                  fontSize: 22.0,
                ),
              ),
            ),
            const Text(
              "Choose your rating:",
              style: TextStyle(
                fontSize: 30,
                color: CupertinoColors.white,
              ),
            ),
            const SizedBox(height: 20.0),
            IconTheme(
              data: const IconThemeData(
                color: CupertinoColors.white,
                size: 40.0
              ), 
              child: StarWidget(
                initialRating: _rating,
                onRatingChanged: (rating) {
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
                color: CupertinoColors.white,
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
                    color: indulgePrimary,
                    onPressed: () {
                      final review = Review.withParams(
                        restaurantId: alreadyReviwedList[_selectedRestaurant].id,
                        restaurantName: alreadyReviwedList[_selectedRestaurant].name,
                        rating: _rating,
                        comment: _reviewController.text,
                      );
                      final reviewsViewModel = Provider.of<ReviewsViewModel>(context, listen: false);
                      reviewsViewModel.submitReview(review);
                      Restaurant restaurant = alreadyReviwedList[_selectedRestaurant];
                      restaurant.reviewed = 1;
                      final userVM = Provider.of<UserViewModel>(context, listen: false);
                      userVM.incrementReviewed(1);//hard-coded for our single user.
                      Provider.of<RestaurantViewModel>(context, listen: false).updateRestaurant(restaurant);
                      Provider.of<ReviewsViewModel>(context, listen: false).fetchReviews();
                      Navigator.of(context).pop();
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
                    onPressed: () {
                      // go back to reviews page
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: indulgePrimary
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