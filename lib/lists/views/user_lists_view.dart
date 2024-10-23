
import 'package:flutter/material.dart';

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
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "My Lists",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30
          ),
        ),
        // possibly add searchbar functionality
        // const SearchBar(
          
        // ),
        const Divider(),
        Expanded(
          child: ListView(
            children: const <Widget>[
              Text("fake item"),
            ],
          )
        )
      ],
    );
  }
  
}