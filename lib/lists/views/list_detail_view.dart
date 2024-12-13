import 'package:flutter/cupertino.dart';
import 'package:indulge/common/list_separator.dart';
import 'package:indulge/lists/viewmodels/list_view_model.dart';
import 'package:indulge/lists/viewmodels/lists_view_model.dart';
import 'package:indulge/restaurant/models/restaurant.dart';
import 'package:indulge/restaurant/viewmodels/restaurant_view_model.dart';
import 'package:provider/provider.dart';


class ListDetailView extends StatelessWidget {
  final int id;
  final String name;
  final List<Restaurant> listItems;
  // TODO: remove these attr somehow

  const ListDetailView({super.key, required this.name, required this.listItems, required this.id});

  @override
  Widget build(BuildContext context) {
    bool shouldShowButton = Provider.of<ListsViewModel>(context).shouldShowIndulgedButton(name);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "$name Restaurants",
        ),
        // backgroundColor: CupertinoColors.black,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        // color: CupertinoColors.black,
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
                    color: CupertinoColors.white,
                  ),
                ),
                if (shouldShowButton && restaurant.indulged == 0)
                  Container(//only want to show this when name != "Been There"
                    alignment: Alignment.center,
                    child: CupertinoButton(
                      color: CupertinoColors.white,
                      child: const Text(
                        "Indulged",
                        style: TextStyle(
                          color: CupertinoColors.black
                        ),
                      ), 
                      onPressed: () async {
                        await Provider.of<ListsViewModel>(context, listen: false).addRestaurantToList(1, restaurant.id!);
                        Provider.of<RestaurantViewModel>(context, listen: false).setRestuarantIndulgedById(restaurant.id!, 1);
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