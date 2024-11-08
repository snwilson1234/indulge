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
        middle: Text("List $name"),
        backgroundColor: CupertinoColors.white,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
        color: CupertinoColors.white,
        child: ListView.separated(
          itemCount: listItems.length,
          itemBuilder: (context, index) {

            final list = listItems[index];

            return Text(list.name);
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ) 
      )
    );
  }
}