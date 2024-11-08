import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge/lists/models/dummy_restaurant.dart';


class ListDetailView extends StatelessWidget {
  final String name;
  final List<DummyRestaurant> listItems;

  ListDetailView({super.key, required this.name, required this.listItems});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("$name Restaurants"),
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
                  "${listItems[index].name}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                )
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ) 
      )
    );
  }
}