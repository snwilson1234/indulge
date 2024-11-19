import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:indulge/restaurant/viewmodels/restaurant_view_model.dart';
import 'package:indulge/restaurant/widgets/restaurant_card.dart';

class RestaurantView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RestaurantViewModel>(context);

    return CupertinoPageScaffold(
      child: SafeArea(
        child: viewModel.isLoading
            ? const Center(child: CupertinoActivityIndicator())
            : Stack(
                alignment: Alignment.center,
                children: [
                  // Display the current card
                  if (viewModel.currentIndex < viewModel.restaurants.length)
                    SwipeableRestaurantCard(
                      restaurant: viewModel.restaurants[viewModel.currentIndex],
                      onSwipeLeft: viewModel.swipeLeft,
                      onSwipeRight: viewModel.swipeRight,
                      onSkip: viewModel.skip,
                    ),

                  // Display a message if no more cards are available
                  if (viewModel.currentIndex >= viewModel.restaurants.length)
                    const Center(
                      child: Text(
                        "No more restaurants",
                        style: TextStyle(color: CupertinoColors.systemGrey, fontSize: 18),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
