import 'package:flutter/cupertino.dart';
import 'package:indulge/common/list_separator.dart';
import 'package:indulge/lists/models/dummy_restaurant.dart';


class ListDetailView extends StatelessWidget {
  final String name;
  final List<DummyRestaurant> listItems;

  const ListDetailView({super.key, required this.name, required this.listItems});

  @override
  Widget build(BuildContext context) {
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

            final list = listItems[index];

            return Row(
              children: <Widget>[
                Text(
                  list.restaurantName!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: CupertinoColors.black,
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