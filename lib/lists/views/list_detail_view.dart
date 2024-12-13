import 'package:flutter/cupertino.dart';
import 'package:indulge/common/list_separator.dart';
import 'package:indulge/lists/viewmodels/list_view_model.dart';
import 'package:indulge/lists/viewmodels/lists_view_model.dart';
import 'package:indulge/restaurant/models/restaurant.dart';
import 'package:indulge/restaurant/viewmodels/restaurant_view_model.dart';
import 'package:provider/provider.dart';


class ListDetailView extends StatelessWidget {
  final String name;
  final List<Restaurant> listItems;

  const ListDetailView({super.key, required this.name, required this.listItems});

  @override
  Widget build(BuildContext context) {
    bool shouldShowButton = Provider.of<ListsViewModel>(context).shouldShowIndulgedButton(name);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "$name Restaurants",
          style: TextStyle(
            color: CupertinoColors.black,
          ),
        ),
        backgroundColor: CupertinoColors.white,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        color: CupertinoColors.white,
        child: ListView.separated(
          itemCount: listItems.length,
          itemBuilder: (context, index) {

            final restaurant = listItems[index];

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  restaurant.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: CupertinoColors.black,
                  ),
                ),
                if (shouldShowButton)
                  Container(//only want to show this when name != "Been There"
                    alignment: Alignment.center,
                    child: CupertinoButton(
                      color: CupertinoColors.black,
                      child: Text(
                        "Indulged",
                        style: TextStyle(
                          color: CupertinoColors.white
                        ),
                      ), 
                      onPressed: () {
                        print('pressed indulged on ${restaurant.name}'); //TODO: remove this
                        Restaurant newRestaurant = Restaurant.fromMap(
                          {
                            'id': restaurant.id,
                            'name': restaurant.name,
                            'distance': restaurant.distance,
                            'type': restaurant.type,
                            'imageUrl': restaurant.imageUrl,
                            'globalRating': restaurant.globalRating,
                            'listId': 1,//add to been there
                            'reviewed': restaurant.reviewed
                          }
                        );
                        Provider.of<RestaurantViewModel>(context, listen: false).updateRestaurant(newRestaurant);
                        Provider.of<ListsViewModel>(context, listen: false).fetchLists();
                        Navigator.of(context).pop();
                      }
                    ),
                  )
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const ListSeparator();
          },
        ) 
      )
    );
  }
}