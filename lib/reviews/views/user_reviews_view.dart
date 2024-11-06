import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:indulge/reviews/viewmodels/reviews_view_model.dart';
import 'package:indulge/reviews/widgets/review_list_widget.dart';
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
    Provider.of<ReviewsViewModel>(context, listen: false).fetchReviewsJson("");
  }
  
  @override
  Widget build(BuildContext context) {
    // print(ModalRoute.of(context)?.settings.name);
    final vm = Provider.of<ReviewsViewModel>(context);
    return Container(
      color: CupertinoColors.white,
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
      child: Column(
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
            controller: _textController,
            onSubmitted: (value) {
              // simple searching when typing term and hitting enter
              if (value.isNotEmpty) {
                vm.fetchReviewsJson(value);
                _textController.clear();
              }
              else {
                vm.fetchReviewsJson("");
              }
            },
            onTap: () {
              vm.fetchReviewsJson("");
            },
          ),
          Divider(),
          Expanded(
            child: ReviewListWidget(
              reviews: vm.reviews
            ),
          )
        ],
      ),
    );
  }
  
}