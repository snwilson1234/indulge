
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge/lists/widgets/list_item_widget.dart';

class UserListsView extends StatefulWidget {
  const UserListsView({Key? key}) : super(key : key);

  @override
  State<UserListsView> createState() => _DefaultState();
}

class _DefaultState extends State<UserListsView> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "My Lists",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        Divider(),
        // TODO?: possibly add searchbar functionality
        // const SearchBar(
          
        // ),
        Expanded(
          child: ListView.separated(
            itemCount: 20,
            itemBuilder: (context, index) {
              return ListItemWidget();
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          ),
        )
      ],
    );
  }
  
}