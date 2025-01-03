import 'package:flutter/cupertino.dart';
import 'package:indulge/lists/viewmodels/list_view_model.dart';
import 'package:indulge/lists/widgets/list_item_widget.dart';
import 'package:indulge/routing/routes.dart';
import 'package:provider/provider.dart';

import '../../common/list_separator.dart';

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
            // prepare list detail view with selected list
            Provider.of<ListViewModel>(context, listen: false).getListById(list.id!);
            Navigator.of(context).pushNamed(
              listDetailRoute,
            );
          },
          child: ListItemWidget(
            list: list,
            size: list.listItems!.length,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const ListSeparator();
      },
    );
  }

}