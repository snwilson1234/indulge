import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge/lists/viewmodels/list_view_model.dart';
import 'package:indulge/lists/widgets/list_item_widget.dart';
import 'package:indulge/reviews/viewmodels/review_view_model.dart';
import 'package:indulge/reviews/widgets/review_item_widget.dart';
import 'package:indulge/routing/routes.dart';

class UserListWidget extends StatelessWidget {
  final List<ListViewModel> lists;

  const UserListWidget({super.key, required this.lists});
  
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: lists.length,
      itemBuilder: (context, index) {

        final list = lists[index];

        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              listDetailRoute, 
              arguments: {
                'name': list.name,
                'listItems': list.listItems
              }
            );
          },
          child: ListItemWidget(
            list: list,
            size: list.listItems.length,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }

}