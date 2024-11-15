import 'package:flutter/cupertino.dart';
import 'package:indulge/common/list_separator.dart';
import 'package:indulge/reviews/viewmodels/reviews_view_model.dart';
import 'package:indulge/reviews/widgets/review_list_widget.dart';
import 'package:indulge/routing/routes.dart';
import 'package:provider/provider.dart';


class UserReviewsView extends StatefulWidget {
  const UserReviewsView({super.key});

  @override
  _UserReviewsViewState createState() => _UserReviewsViewState();
}


class _UserReviewsViewState extends State<UserReviewsView> {

  final _textController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    // start with full list
    Provider.of<ReviewsViewModel>(context, listen: false).fetchReviews();
  }
  
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ReviewsViewModel>(context);
    return Container(
      color: CupertinoColors.white,
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
      child: Stack(
        children: <Widget>[
          Column(
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
              const ListSeparator(),
              CupertinoSearchTextField(
                controller: _textController,
                onSubmitted: (value) {
                  // simple searching when typing term and hitting enter
                  if (value.isNotEmpty) {
                    vm.fetchReviews();
                    final vmReviews = vm.reviews;
                    _textController.clear();
                  }
                  else {
                    vm.fetchReviews();
                  }
                },
                onTap: () {
                  vm.fetchReviews();
                },
              ),
              const ListSeparator(),
              Expanded(
                child: ReviewListWidget(
                  reviews: vm.reviews
                ),
              )
            ],
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
            child: CupertinoButton.filled(
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              child: const Icon(CupertinoIcons.plus),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  newReviewRoute,
                );
              }
            ),  
          )
        ],
      )
    );
  }
  
}