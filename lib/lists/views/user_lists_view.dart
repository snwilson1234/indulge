
import 'package:flutter/cupertino.dart';
import 'package:indulge/common/list_separator.dart';
import 'package:indulge/lists/viewmodels/lists_view_model.dart';
import 'package:indulge/lists/widgets/user_list_widget.dart';
import 'package:provider/provider.dart';

class UserListsView extends StatefulWidget {
  const UserListsView({super.key});

  @override
  State<UserListsView> createState() => _DefaultState();
}

class _DefaultState extends State<UserListsView> {
  
  @override
  void initState() {
    super.initState();
    Provider.of<ListsViewModel>(context, listen: false).fetchLists();
  }
  
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ListsViewModel>(context);
    return Container(
      color: CupertinoColors.black,
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "My Lists",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const ListSeparator(),
          // TODO?: possibly add searchbar functionality
          // const SearchBar(
            
          // ),
          Expanded(
            child: UserListWidget(
              lists: vm.lists
            ),
          )
        ],
      ),
    );
  }
  
}